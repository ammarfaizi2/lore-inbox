Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269460AbUJFVtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269460AbUJFVtx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269501AbUJFVrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:47:01 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:22216 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S269530AbUJFVnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:43:20 -0400
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
	availlable
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041006192335.GH10153@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
	 <20041006173823.GA26740@kroah.com>
	 <20041006180421.GD10153@wohnheim.fh-wedel.de>
	 <20041006181958.GB27300@kroah.com>
	 <20041006192335.GH10153@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Organization: Linux Networx
Date: Wed, 06 Oct 2004 15:22:51 -0600
Message-Id: <1097097771.3845.28.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 21:23 +0200, Jörn Engel wrote:
> On Wed, 6 October 2004 11:19:58 -0700, Greg KH wrote:
> > On Wed, Oct 06, 2004 at 08:04:21PM +0200, J?rn Engel wrote:
> > > On Wed, 6 October 2004 10:38:23 -0700, Greg KH wrote:
> > > > 
> > > > Your printk() calls need the proper KERN_* level.
> > > 
> > > As does the original one.  Which one would you like for both?
> > 
> > KERN_WARNING perhaps?
> 
> As in the patch below?
> 
> > > > usually do not have a /dev/null this early in the boot process).  Does
> > > > this mean we should add a /dev/null to the initramfs image, like the
> > > > /dev/console node we currently have there?
> > > 
> > > Yes, that would fix the case.  Is this a problem?
> > 
> > I don't have a problem with doing that.
> 
> Then please do so. :)

Take your pick:

This depends on the initramfs from file patch that is in the mm tree:

--- usr/initramfs_list.orig     2004-10-06 15:49:40.838941640 -0600
+++ usr/initramfs_list  2004-10-06 15:48:51.076506680 -0600
@@ -2,4 +2,5 @@

 dir /dev 0755 0 0
 nod /dev/console 0600 0 0 c 5 1
+nod /dev/null 0666 0 0 c 1 3
 dir /root 0700 0 0


This is the old, hard-coded list built in to gen_init_cpio:

--- usr/gen_init_cpio.c.orig    2004-10-06 15:53:21.538390224 -0600
+++ usr/gen_init_cpio.c 2004-10-06 15:53:36.454122688 -0600
@@ -215,6 +215,7 @@
 {
        cpio_mkdir("/dev", 0755, 0, 0);
        cpio_mknod("/dev/console", 0600, 0, 0, 'c', 5, 1);
+       cpio_mknod("/dev/null", 0600, 0, 0, 'c', 1, 3);
        cpio_mkdir("/root", 0700, 0, 0);
        cpio_trailer();


