Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264876AbUFAESg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264876AbUFAESg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 00:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbUFAESg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 00:18:36 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:26576 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264876AbUFAERr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 00:17:47 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Paul Serice <paul@serice.net>
Date: Tue, 1 Jun 2004 14:17:40 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16572.868.477203.352122@cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iso9660 inodes beyond 4GB
In-Reply-To: message from Paul Serice on Monday May 31
References: <40BB714B.8050504@serice.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 31, paul@serice.net wrote:
> This is my third attempt to patch the isofs code.  It is a completely
> different patch from the previous two.  I do not think there are any
> trade-offs with this patch.
snip
> 
> Lastly, the current code uses the default export_operations to handle
> accessing the file system through NFS.  The problem with this is that
> the default NFS operations assume that iget() works which is no longer
> the case because of the necessary switch to iget5_locked().  So, I had
> to implement the NFS operations too.
> 
> I did not, however, implement the NFS get_parent() method.  So, the
> default method which just returns an error is used.  This is not a
> reduction in functionality because the current code also uses the
> default method.  If someone can explain what I need to do to trigger
> this error, I will gladly try to implement the method.
> 

The easiest way to trigger the error is:
  export the filesystem and mount it on some client.
  On the client, cd into some subdirectory.
  On the server, unexport, unmount, remount, reexport
    (i.e. simulate a reboot).
  On the client "ls -l"

That should cause the server to try to call get_parent to find the
path back up to the root of the filesystem.

A quick glance at the rest of the export related code suggests that it
is all ok.  

NeilBrown
