Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRDJRMi>; Tue, 10 Apr 2001 13:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129292AbRDJRMY>; Tue, 10 Apr 2001 13:12:24 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:31756 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S129166AbRDJRLf>; Tue, 10 Apr 2001 13:11:35 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE818@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Cc: "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: Serious bug in ACPI enumeration
Date: Tue, 10 Apr 2001 10:11:13 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is because at this stage of ACPI development, we want to be as strict
as possible w.r.t. AML, to expose bugs in the software.

That said, maybe it's better to just emit a warning here, instead of
failing. I'll bring it up with the team.

Regards -- Andy

> From: Pavel Machek [mailto:pavel@suse.cz]
> 
> Hi!
> 
> My "toshiba workaround" was not toshiba specific: you stopped scanning
> at first device that was not present. That's bad, you have to continue
> scanning. Here's fix.
> 
> 								Pavel
> 
> --- clean/drivers/acpi/namespace/nsxfobj.c	Sun Apr  1 00:23:00 2001
> +++ linux/drivers/acpi/namespace/nsxfobj.c	Thu Apr  5 22:49:18 2001
> @@ -592,7 +595,7 @@
>  
>  	status = acpi_cm_execute_STA (node, &flags);
>  	if (ACPI_FAILURE (status)) {
> -		return (status);
> +		return AE_OK;
>  	}
>  
>  	if (!(flags & 0x01)) {
> 
> 
> -- 
> I'm pavel@ucw.cz. "In my country we have almost anarchy and I 
> don't care."
> Panos Katsaloulis describing me w.r.t. patents at 
> discuss@linmodems.org
> 

