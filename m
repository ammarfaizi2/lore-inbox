Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268253AbTBNI6O>; Fri, 14 Feb 2003 03:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268254AbTBNI6O>; Fri, 14 Feb 2003 03:58:14 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:56791 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268253AbTBNI6N>; Fri, 14 Feb 2003 03:58:13 -0500
Date: Fri, 14 Feb 2003 10:08:04 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Pavel Machek <pavel@suse.cz>, John Levon <levon@movementarian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
In-Reply-To: <15947.41003.250547.617866@kim.it.uu.se>
Message-ID: <Pine.GSO.3.96.1030214100458.666A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Mikael Pettersson wrote:

> +static int __init init_local_apic_devicefs(void)
>  {
> -	if (apic_pm_state.active)
> -		pm_register(PM_SYS_DEV, 0, apic_pm_callback);
> +	if (!cpu_has_apic)

 This looks broken -- what if an external local APIC is present?

> +		return 0;
> +	if (!apic_pm_state.active) {
> +		local_apic_driver.resume = NULL;
> +		local_apic_driver.suspend = NULL;
> +	}
> +	driver_register(&local_apic_driver);
> +	return sys_device_register(&device_local_apic);
>  }

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

