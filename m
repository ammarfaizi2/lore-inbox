Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTAUBWP>; Mon, 20 Jan 2003 20:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTAUBWP>; Mon, 20 Jan 2003 20:22:15 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11780
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266796AbTAUBWO>; Mon, 20 Jan 2003 20:22:14 -0500
Date: Mon, 20 Jan 2003 17:27:06 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Grover <andrew.grover@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: Ask devices to powerdown before S3 sleep
In-Reply-To: <20030119214642.GA27885@elf.ucw.cz>
Message-ID: <Pine.LNX.4.10.10301201714120.16070-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi! Pavel,

Could you do me just one tiny favor?
Please consider attempting an error recovery level path, maybe ...

Every patch I have glanced at has 'panic("blah blah");'

If you do not have enough hardware to generate an accurate path for
recovery, then please do not force the kernel into panic.  Would you
consider failing the request making it jump back to S1 ?  This at least
allows it crash like a power failure.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Sun, 19 Jan 2003, Pavel Machek wrote:

> Hi!
> 
> SUSPEND_RESUME phase is needed for turning off IO-APIC. [I believe
> SUSPEND_DISABLE should be so simple that errors just should not be
> there, and besides we would not know how to safely enable devices from
> such weird state, anyway]. Please apply,
> 
> 								Pavel
> 
> --- clean/drivers/acpi/sleep.c	2003-01-05 22:58:25.000000000 +0100
> +++ linux-swsusp/drivers/acpi/sleep.c	2003-01-19 21:27:00.000000000 +0100
> @@ -143,6 +143,10 @@
>  			return error;
>  		}
>  
> +		error = device_suspend(state, SUSPEND_DISABLE);
> +		if (error)
> +			panic("Sorry, devices really should know how to disable\n");
> +
>  		/* flush caches */
>  		ACPI_FLUSH_CPU_CACHE();
> 
> -- 
> Worst form of spam? Adding advertisment signatures ala sourceforge.net.
> What goes next? Inserting advertisment *into* email?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

