Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWHIMIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWHIMIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWHIMIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:08:30 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:49119 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161011AbWHIMI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:08:28 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 2/5] swsusp: Use memory bitmaps during resume
Date: Wed, 9 Aug 2006 14:04:56 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
References: <200608091152.49094.rjw@sisk.pl> <200608091204.36186.rjw@sisk.pl> <20060809114942.GS3308@elf.ucw.cz>
In-Reply-To: <20060809114942.GS3308@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091404.56737.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 09 August 2006 13:49, Pavel Machek wrote:
> > Make swsusp use memory bitmaps to store its internal information during the
> > resume phase of the suspend-resume cycle.
> > 
> > If the pfns of saveable pages are saved during the suspend phase instead of
> > the kernel virtual addresses of these pages, we can use them during the resume
> > phase directly to set the corresponding bits in a memory bitmap.  Then, this
> > bitmap is used to mark the page frames corresponding to the pages that were
> > saveable before the suspend (aka "unsafe" page frames).
> > 
> > Next, we allocate as many page frames as needed to store the entire suspend
> > image and make sure that there will be some extra free "safe" page frames for
> > the list of PBEs constructed later.  Subsequently, the image is loaded and,
> > if possible, the data loaded from it are written into their "original" page frames
> > (ie. the ones they had occupied before the suspend).  The image data that
> > cannot be written into their "original" page frames are loaded into "safe" page
> > frames and their "original" kernel virtual addresses, as well as the addresses
> > of the "safe" pages containing their copies, are stored in a list of PBEs.
> > Finally, the list of PBEs is used to copy the remaining image data into their
> > "original" page frames (this is done atomically, by the architecture-dependent
> > parts of swsusp).
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACK. If we get bitmap code we may as well use it. Should wait in -mm
> for a while.

Sure.

> > @@ -53,7 +40,7 @@ static inline void pm_restore_console(vo
> >  static inline int software_suspend(void)
> >  {
> >  	printk("Warning: fake suspend called\n");
> > -	return -EPERM;
> > +	return -ENOSYS;
> >  }
> >  #endif /* CONFIG_PM */
> >  
> 
> Heh, yes, it is right.. it is also totally unrelated and changes
> userland interface ;-)))... which is probably okay here. But separate
> would be nice.

Ah, well, that's a "btw" thing. ;-)  Will separate.

Rafael
