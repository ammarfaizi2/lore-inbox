Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270748AbTG0L37 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270749AbTG0L37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:29:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8460 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S270748AbTG0L3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:29:55 -0400
Date: Sun, 27 Jul 2003 13:13:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Tomas Szepe <szepe@pinerecords.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] sanitize power management config menus
Message-ID: <20030727111340.GB1957@openzaurus.ucw.cz>
References: <20030726200213.GD16160@louise.pinerecords.com> <20030726194651.5e3f00bb.rddunlap@osdl.org> <20030727025647.GB17724@louise.pinerecords.com> <20030726204623.47b08882.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030726204623.47b08882.rddunlap@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> | > 3.  The help text for Software Suspend (not part of this patch)
> | > really needs some help.  Would you address that or shall I?
> | 
> | Sure, it would be nice if you could fish out an entry from somewhere.
> 
> OK, how's this look?

Hey, I had similar patch in queue somewhere.

> --- ./arch/i386/Kconfig~swshelp	2003-07-25 10:23:11.000000000 -0700
> +++ ./arch/i386/Kconfig	2003-07-26 20:30:50.000000000 -0700
> @@ -824,27 +824,27 @@
>  	bool "Software Suspend (EXPERIMENTAL)"
>  	depends on EXPERIMENTAL && PM && SWAP
>  	---help---
> -	  Enable the possibilty of suspendig machine. It doesn't need APM.
> -	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
> -	  (patch for sysvinit needed). 
> -
> -	  It creates an image which is saved in your active swaps. By the next
> -	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
> -	  detect the saved image, restore the memory from
> -	  it and then it continues to run as before you've suspended.
> -	  If you don't want the previous state to continue use the 'noresume'
> -	  kernel option. However note that your partitions will be fsck'd and
> -	  you must re-mkswap your swap partitions/files.
> +	  Enable the possibility of suspending the machine. It doesn't need
> +	  APM. You may suspend your machine by 'swsusp' or 'shutdown -z <time>'
> +	  (patch for sysvinit is needed). 
> +
> +	  This creates an image which is saved in your active swap space. On
> +	  the next boot, pass the 'resume=/path/to/your/swap/file' option and

Swap *files* are no longer supported. Swap partitions work.

> +	  the kernel will detect the saved image, restore the memory from it,
> +	  and then continue to run as before you suspended.
> +	  If you don't want the previous state to continue, use the 'noresume'
> +	  kernel option. However, note that your partitions will appear to be
> +	  damaged so you must re-mkswap your swap partitions/files to use them.
>  
>  	  Right now you may boot without resuming and then later resume but
> -	  in meantime you cannot use those swap partitions/files which were
> +	  in the meantime you cannot use those swap partitions/files which were
>  	  involved in suspending. Also in this case there is a risk that buffers
>  	  on disk won't match with saved ones.

I guess we do not want to teach people doing this.

> -	  SMP is supported __as-is''. There's a code for it but doesn't work.
> -	  There have been problems reported relating SCSI.
> +	  SMP is supported __as-is''. There's code for it but doesn't work.
> +	  There have been problems reported relating to SCSI.

SMP is not supported. Kill the note about SCSI.

> -	  This option is about getting stable. However there is still some
> +	  This option is close to getting stable. However there is still some
>  	  absence of features.

Kill this. Saying (EXPERIMENTAL) should be enough.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

