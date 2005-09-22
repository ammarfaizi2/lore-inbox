Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVIVDMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVIVDMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 23:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbVIVDMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 23:12:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55764 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030194AbVIVDMi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 23:12:38 -0400
Date: Thu, 22 Sep 2005 04:11:36 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Roland Dreier <rolandd@cisco.com>
Cc: Christopher Friesen <cfriesen@nortel.com>, dipankar@in.ibm.com,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on 2.6.14-rc2
Message-ID: <20050922031136.GE7992@ftp.linux.org.uk>
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ll1qkrii.fsf@cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 03:03:33PM -0700, Roland Dreier wrote:
>     Christopher> Digging in a bit more, it looks like the files are
>     Christopher> being created/destroyed/renamed in /tmp, which is a
>     Christopher> tmpfs filesystem.
> 
> Hmm... could there be a race in shmem_rename()??

Not likely - in that setup all calls of ->unlink() and ->rename()
are completely serialized by ->i_sem on parent.  One question:
is it dcache or icache that ends up leaking?
