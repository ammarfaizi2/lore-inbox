Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVKCFz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVKCFz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 00:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbVKCFzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 00:55:25 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:32520 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750951AbVKCFzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 00:55:25 -0500
Date: Thu, 3 Nov 2005 06:43:43 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <gcoady@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.32-rc2
Message-ID: <20051103054343.GA19202@alpha.home.local>
References: <20051031175704.GA619@logos.cnet> <4366E9AA.4040001@gmail.com> <20051101074959.GQ22601@alpha.home.local> <20051101063402.GA3311@logos.cnet> <4367C95D.3050108@drugphish.ch> <20051102002821.GC13557@alpha.home.local> <43689CCF.1060102@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43689CCF.1060102@drugphish.ch>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roberto,

On Wed, Nov 02, 2005 at 12:02:39PM +0100, Roberto Nibali wrote:
> Bonjour Willy,
> 
> >>Willy, if you have time, could you check your non-i386 boxes with a
> >>2.95.x compiled 2.4.x kernel, with IPVS enabled?
> >  
> > Yes, no problem, but you'll have to tell me what to test ! (a config
> > or script will save me some time). I have a Sun Ultra60 (ultrasparc SMP)
> > which matches your description. I just have a doubt about gcc-2.95
> > availability on this box, I know I have a 3.3.6, do you think that the
> > problem is gcc-related (too strong optimization or de-inlining, etc) ?
> 
> At least following should be set, the rest you can leave to your gusto:
> 
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_MMCONFIG=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SYSTEM=y

OK, I can confirm that these ones get washed out

> CONFIG_IP_VS=m
> CONFIG_IP_VS_DEBUG=y
> CONFIG_IP_VS_TAB_BITS=12
> CONFIG_IP_VS_RR=m
> CONFIG_IP_VS_WRR=m
> CONFIG_IP_VS_LC=m
> CONFIG_IP_VS_WLC=m
> CONFIG_IP_VS_LBLC=m
> CONFIG_IP_VS_LBLCR=m
> CONFIG_IP_VS_DH=m
> CONFIG_IP_VS_SH=m
> CONFIG_IP_VS_SED=m
> CONFIG_IP_VS_NQ=m
> CONFIG_IP_VS_HPRIO=m
> CONFIG_IP_VS_FTP=m

These ones stay enabled.

> One issue is a possible C99'ism in the last IPVS patch. If you find
> time, please have a 2.95.x compiler installed.

I discovered that gcc-2.95.4 cannot compile kernel on sparc64 anymore :-(
I even wonder if it ever had been able to, because it does not know about
the -mmedlow option. I removed it to check further, but then ld segfaults
complaining that v8plus objects are not compatible with v9 output. Retrying
with 3.3.5 so...

> Another thing that could fail is if you additionally set
> 
> CONFIG_ACPI_FAN=m
> 
> and compile with CFLAGS="-g -ggdb"

I bet you guessed it gets ignored too :-) But I could test this on my
dual-athlon with gcc-2.95 if it is of any interest.

Regards,
Willy

