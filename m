Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVAUPYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVAUPYm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 10:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVAUPYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 10:24:42 -0500
Received: from apachihuilliztli.mtu.ru ([195.34.32.124]:65030 "EHLO
	Apachihuilliztli.mtu.ru") by vger.kernel.org with ESMTP
	id S262389AbVAUPYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 10:24:35 -0500
Subject: Re: knfsd and append-only attribute:  "operation not permitted"
From: Vladimir Saveliev <vs@namesys.com>
To: "Aaron D.Ball" <adb@bdi.com>
Cc: reiserfs-list@namesys.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <8381054C-6B13-11D9-BFA6-000D933B35AA@bdi.com>
References: <8381054C-6B13-11D9-BFA6-000D933B35AA@bdi.com>
Content-Type: text/plain
Message-Id: <1106318654.3200.38.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 21 Jan 2005 17:44:14 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, 2005-01-20 at 21:45, Aaron D.Ball wrote:
> When I use the kernel-based NFS server to export directories on 
> ReiserFS that have the append-only attribute set, I can't access the 
> files from the client machines at all:  for example, "ls" returns 
> "operation not permitted".  Is this a known bug?  Is there a good 
> workaround?
> 

It looks like the problem is not in reiserfs, but in nfsd.
fs/nfsd/vfs.c:nfsd_open() refuses to open append only files.

	/* Disallow access to files with the append-only bit set or
	 * with mandatory locking enabled
	 */
	err = nfserr_perm;
	if (IS_APPEND(inode) || IS_ISMNDLK(inode))
		goto out;


> I'm running up-to-date Debian sid with Linux 2.6.10 compiled from the 
> stock Debian kernel-source package.  Everything works fine in other 
> contexts, such as
> 
> * direct access on the server
> * access via Samba
> * access via the userspace NFS server (which I'm using as a workaround 
> for now)
> 
> I'd really like to get things working with the kernel-based server so I 
> can have locks.  Abandoning extended attributes would mean I have to 
> monitor certain files and directories for changes and check them after 
> the fact rather than simply blocking all the changes I don't want.  Is 
> there hope?  Am I just doing something dumb?
> 
> 

