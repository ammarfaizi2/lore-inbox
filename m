Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293712AbSCPFRH>; Sat, 16 Mar 2002 00:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293713AbSCPFQ6>; Sat, 16 Mar 2002 00:16:58 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:50072 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S293712AbSCPFQs>;
	Sat, 16 Mar 2002 00:16:48 -0500
Date: Fri, 15 Mar 2002 18:23:56 -0500
From: Theodore Tso <tytso@mit.edu>
To: David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
Subject: Re: mke2fs (and mkreiserfs) core dumps
Message-ID: <20020315182355.A1123@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020313123114.A11658@greenhydrant.com> <20020313205537.GC429@turbolinux.com> <20020313133748.A12472@greenhydrant.com> <20020313215420.GD429@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20020313215420.GD429@turbolinux.com>; from adilger@clusterfs.com on Wed, Mar 13, 2002 at 02:54:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 02:54:20PM -0700, Andreas Dilger wrote:
> 
> If you don't have any "ulimit" calls in the login, it should also be OK.
> It's just that some vendor startup scripts set a ulimit for non-root
> users.  Trying to set it back to "unlimited" doesn't work.
> 

Also check your PAM configuration files, since pam_limits can also be
causing the problem.  (Namely, any attempt to set the filesize to be
"unlimited" cause it to be capped at 2GB.)  There's also the question
whether or not filesize limits should really apply to device files,
since the original point of filesize limits were as a simple-minded
quota control mechanism, and there seems to be little point to causing
attempts to access block deivces to fail --- under what circumstances
would this *ever* be considered a useful thing?

Anyway, as of e2fsprogs 1.27, since I got tired of handling user
questions about this, e2fsprogs will attempt to unlimit filesize
unconditionally, if it has the superuser privileges to do so.  Because
of the fact that in effect, the kernel ABI changed between 2.2 and 2.4
(the value of "Unlimited" change), in e2fsprogs I had to hard-code the
value of unlimited, so that it would do the right thing regardless of
which header files were used to compile e2fsprogs.  (Oh, joy, oh
rapture.)

						- Ted

