Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280836AbRLLPaD>; Wed, 12 Dec 2001 10:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRLLP3y>; Wed, 12 Dec 2001 10:29:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33038 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S280814AbRLLP3g>;
	Wed, 12 Dec 2001 10:29:36 -0500
Date: Wed, 12 Dec 2001 16:29:28 +0100
From: Jens Axboe <axboe@suse.de>
To: A Duston <hald@sound.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bio and "old" block drivers
Message-ID: <20011212152928.GC9324@suse.de>
In-Reply-To: <Pine.GSO.4.10.10112111539180.5913-100000@sound.net> <20011212101957.GE7562@suse.de> <3C177767.8132794F@sound.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C177767.8132794F@sound.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12 2001, A Duston wrote:
> Jens Axboe wrote:
> > 
> > On Tue, Dec 11 2001, Hal Duston wrote:
> > > I'm looking at the bio changes for ps2esdi.  The driver
> > > appears to no longer work compiled when into the kernel.
> > > The ps2esdi_init call has been removed from
> > > ll_rw_blk.c:blk_dev_init.  Where is the new/correct place
> > > to call this from?  This appears to be the same way with
> > > many of the other "old" block drivers as well.
> > 
> > Just use module_init to make this happen automagically.
> 
> Sorry, I am not understanding you here.  Could you spell it 
> out please?  My root filesystem is on the ps2esdi disk, do 
> I need to set up an initrd, and load the ps2esdi driver as 
> a module?  Or do you mean that I should change things to 
> have module_init call it even when it isn't built as a 
> module?  Or something else?

I mean:

--- /opt/kernel/linux-2.5.1-pre10/drivers/block/ps2esdi.c	Tue Dec 11 13:30:36 2001
+++ drivers/block/ps2esdi.c	Wed Dec 12 10:26:09 2001
@@ -189,6 +189,8 @@
 	return 0;
 }				/* ps2esdi_init */
 
+module_init(ps2esdi_init);
+
 #ifdef MODULE
 
 static int cyl[MAX_HD] = {-1,-1};

and then it will be initialized correctly. module_init isn't specific to
modules, it will work for builtin stuff too. See __initcall

-- 
Jens Axboe

