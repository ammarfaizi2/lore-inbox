Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273001AbTGaNJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273006AbTGaNJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:09:26 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46085
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S273001AbTGaNJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:09:23 -0400
Date: Thu, 31 Jul 2003 06:00:01 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pavel Machek <pavel@suse.cz>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Warn about taskfile?
In-Reply-To: <20030731102827.GD464@elf.ucw.cz>
Message-ID: <Pine.LNX.4.10.10307310557570.19607-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Did you bother to turn off the suspend to death?  Since it appears to do
all kinds of orthoginal operations to the state machine?

Not hat it matters.

-a

On Thu, 31 Jul 2003, Pavel Machek wrote:

> Hi!
> 
> > > > > I had some strange fs corruption, and andi suggested that it probably
> > > > > is TASKFILE-related. Perhaps this is good idea?
> > > >
> > > > Idea is good.
> > > >
> > > > Did corruption go away after disabling taskfile?
> > >
> > > Not sure, it took week for corruption to creep in, and it might have
> > > been loop-related or swsusp-related. I'm not at all sure it was
> > > TASKFILE, but I'm turning it off for now.
> > 
> > I doubt it was taskfile, your /dev/hda is using UDMA so taskfile's impact
> > is minimal.  I've checked this codepath once again today and can't
> > see anything which has (possibly) caused Andi's problems.
> > 
> > I think if it is taskfile related it might be caused by some timing issues
> > (races) and should be visible (less frequently) with non-taskfile code too
> > and this is not happening.
> > 
> > If you are not sure if it was taskfile why do you want to warn about it?
> > [ Because Andi is spreading FUD about taskfile? ;-) ]
> 
> This was i386 machine, but I'm not sure if I told that to Andi.
> 
> > > At least it is strange to have option that says both "experimental"
> > > and "it is safe to say Y". What are those "most cases"?
> > 
> > Using (U)DMA should be 100% safe, using single-sector PIO should
> > also be safe, using multi-sector PIO might be less safe...
> 
> Perhaps this is good idea?
> 								Pavel
> 
> --- clean/drivers/ide/Kconfig	2003-07-27 22:31:13.000000000 +0200
> +++ linux/drivers/ide/Kconfig	2003-07-31 12:24:16.000000000 +0200
> @@ -283,7 +283,8 @@
>  	---help---
>  	  Use new taskfile IO code.
>  
> -	  It is safe to say Y to this question, in most cases.
> +  	  It is safe to say Y to this question if you are using (U)DMA or
> +	  single-sector PIO. Be carefull wilh multi-sector PIO.
>  
>  comment "IDE chipset support/bugfixes"
>  	depends on BLK_DEV_IDE
> 
> 
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

