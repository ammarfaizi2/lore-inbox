Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311530AbSDIUx7>; Tue, 9 Apr 2002 16:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311575AbSDIUx6>; Tue, 9 Apr 2002 16:53:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29200 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S311530AbSDIUxH>; Tue, 9 Apr 2002 16:53:07 -0400
Date: Tue, 9 Apr 2002 22:53:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19pre5-ac3
Message-ID: <20020409205309.GC4322@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200204051945.g35JjnX23183@devserv.devel.redhat.com> <20020408214612.GR961@matchmail.com> <20020408013801.B329@toy.ucw.cz> <20020409204019.GD523@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Linux 2.4.19pre5-ac3
> > > > o	Software suspend initial patch 		(Pavel Machek, Gabor Kuti,..)
> > > > 	| Don't enable this idly. Its here to get exposure and so
> > > > 	| people can bring the rest of the code up to meet its needs as
> > > > 	| well as fix it.
> > > > 	| Read the docs first!
> > > 
> > > Didn't enable software suspend, but I do use ACPI...
> > 
> > Looks like we need some #ifdefs in acpi... I'll fix that.
> 
> 10 minutes ago emailed to alan with following:

S4 is not supported in current ACPI, so you should better make it
printk("s4 not supported") and do nothing instead of entering ACPI-S4
and powering system down when user wants "only" suspend. 

> diff -Nru a/drivers/acpi/ospm/system/sm_osl.c b/drivers/acpi/ospm/system/sm_osl.c
> --- a/drivers/acpi/ospm/system/sm_osl.c	Wed Apr 10 00:03:00 2002
> +++ b/drivers/acpi/ospm/system/sm_osl.c	Wed Apr 10 00:03:00 2002
> @@ -140,10 +140,14 @@
>  	if (system->states[value] != TRUE)
>  		return -EINVAL;
>  	
> +#ifdef CONFIG_SOFTWARE_SUSPEND
>  	if (value != ACPI_S4)
> +#endif
>  		sm_osl_suspend(value);
> +#ifdef CONFIG_SOFTWARE_SUSPEND
>  	else
>  		software_suspend();
> +#endif
>  	
>  	return (count);
>  }

Kill first ifdef and replace second one with something like

	else
#ifdef CONFIG_....
		software_suspend();
#else
		printk("You need .... for S4.");
#endif
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
