Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265934AbUAQByj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 20:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUAQByj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 20:54:39 -0500
Received: from hell.org.pl ([212.244.218.42]:56072 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S265934AbUAQByi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 20:54:38 -0500
Date: Sat, 17 Jan 2004 02:54:47 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [2.6.0-mm2] PM timer still has problems
Message-ID: <20040117015447.GA30456@hell.org.pl>
References: <20031230204831.GA17344@hell.org.pl> <1073340716.15645.96.camel@cog.beaverton.ibm.com> <200401052332.24739.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <200401052332.24739.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dmitry Torokhov:
> Or that Karol's laptop has ACPI PM timer that is accessed through the
> memory (ACPI_ADR_SPACE_SYSTEM_MEMORY), is there such implementations?
> Right now timer_pm.c only supports IO-port based timer access.

Apparently, the PM timer now works as of 2.6.1-mm4:
#v+
Detected 1700.569 MHz processor.
Using pmtmr for high-res timesource
#v-

But the BogoMIPS loop is still wrong:
#v+
Calibrating delay loop... 1683.45 BogoMIPS
#v-

It looks as if it needed to be multiplied by two, right?
Additionally, the /proc/cpuinfo is not updated on governor change (I'm
using the speedstep-ich driver which otherwise works fine), although the
real CPU frequency certainly is. I'm not sure if this is in any way 
related though.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
