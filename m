Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966153AbWKOHpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966153AbWKOHpY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966059AbWKOHpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:45:23 -0500
Received: from hera.kernel.org ([140.211.167.34]:27349 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S966004AbWKOHpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:45:21 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Wed, 15 Nov 2006 02:48:12 -0500
User-Agent: KMail/1.8.2
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
References: <200611142303.47325.david-b@pacbell.net>
In-Reply-To: <200611142303.47325.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611150248.12578.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 02:03, David Brownell wrote:
> dmesg reports to me stuff like
> 
> ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
> ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [20060707]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPC0.BAT1._BIF] (Node ffff8100020368d0), AE_TIME
> ACPI Exception (acpi_battery-0148): AE_TIME, Evaluating _BIF [20060707]
> ACPI: read EC, IB not empty
> ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
> ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [20060707]
> ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.THRM._TMP] (Node ffff810002032d10), AE_TIME

AE_TIME is generally used for timeout situations -- ie didn't get a semaphore within a certain period.

Any change if you boot with "ec_intr=0"?

thanks,
-Len

> It never used to complain at all.  This is an amd64 laptop, and related symptoms
> include
> 
>  - kpowersave not being able to monitor the batter or AC adapter correctly;
>    leading to catastrophes like laptop powering itself off with no warning,
>    loss of work, filesystem needing log recovery, and so forth.
> 
>  - Serious fan action.  Recent kernels seemed to finally be doing sane things
>    so that e.g. just editing text kept the CPU cool ... but now it's on almost
>    all the time, CPU is very hot.
> 
> What's an AE_TIME?
> 
> I'm not quite sure where these problems crept in, but I never saw such stuff with
> 2.6.18 at all.
> 
> - Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
