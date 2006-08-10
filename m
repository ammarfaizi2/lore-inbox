Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161456AbWHJQyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161456AbWHJQyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbWHJQye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:54:34 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:12226 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1161456AbWHJQyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:54:33 -0400
Date: Thu, 10 Aug 2006 10:54:31 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Neil Brown <neilb@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Urgent help needed on an NFS question, please help!!!
Message-ID: <20060810165431.GD4379@parisc-linux.org>
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com> <17626.49136.384370.284757@cse.unsw.edu.au> <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com> <17626.52269.828274.831029@cse.unsw.edu.au> <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com> <20060810161107.GC4379@parisc-linux.org> <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 12:23:12PM -0400, Xin Zhao wrote:
> That makes sense.
> 
> Can we make the following two conclusions?
> 1. In a single machine, inode+dev ID+i_generation can uniquely identify a 
> file

sure.

> 2. Given a stored file handle and an inode object received from the
> server,  an NFS client can safely determine whether this inode
> corresponds to the file handle by checking the inode+dev+i_generation.

The NFS client makes up its own inode numbers for use on the local
machine.  It doesn't know the device+inode+generation numbers on the
server (and indeed, the server may not even have the concepts of
inodes).  To quote RFC 1813:

   The file handle contains all the information the server needs to
   distinguish an individual file.  To the client, the file handle is
   opaque. The client stores file handles for use in a later request
   and can compare two file handles from the same server for equality by
   doing a byte-by-byte comparison, but cannot otherwise interpret the
   contents of file handles. If two file handles from the same server
   are equal, they must refer to the same file, but if they are not
   equal, no conclusions can be drawn.  Servers should try to maintain
   a one-to-one correspondence between file handles and files, but this
   is not required. Clients should use file handle comparisons only to
   improve performance, not for correct behavior.
