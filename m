Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbSKUSb0>; Thu, 21 Nov 2002 13:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbSKUSbZ>; Thu, 21 Nov 2002 13:31:25 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:7689 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266938AbSKUSbZ>;
	Thu, 21 Nov 2002 13:31:25 -0500
Date: Thu, 21 Nov 2002 19:33:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: john stultz <johnstul@us.ibm.com>
Cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [RFC] [PATCH] subarch cleanup
Message-ID: <20021121183304.GA1144@mars.ravnborg.org>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	"J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	lkml <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <1037750429.4463.71.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037750429.4463.71.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 04:00:29PM -0800, john stultz wrote:
> James, All,
> 
> 	This is a small patch to try to somewhat cleanup the subarch code.
> First it moves all the subarch .h files out of arch/i386/mach-xyz into
> include/asm-i386/mach-xyz, then it changes the include patch to include
> include/asm-i386/mach-xyz and include/asm-i386/mach-generic when
> compiling. This allows the compiler to use the arch specific .h files
> when needed, and then falls back to the generic .h files if no subarch
> specific changes are needed. 
Why do you need to move the .h files?

>  ifdef CONFIG_VISWS
> -MACHINE	:= mach-visws
> +MACHINE_C	:= mach-visws
> +MACHINE_H	:= mach-visws
>  else
> -MACHINE	:= mach-generic
> +MACHINE_C	:= mach-generic
> +MACHINE_H	:= mach-generic

No reason to have two different variables assigned the same value.
If you are modifying this anyway consider something like:
machine-y               := mach-generic
machine-$(CONFIG_VISWS) := mach-visws

And then replace $(MACHINE) with $(machine-y).
This makes it much cleaner to add summit for example.

> -CFLAGS += -Iarch/i386/$(MACHINE)
> -AFLAGS += -Iarch/i386/$(MACHINE)
> +CFLAGS += -Iinclude/asm-i386/$(MACHINE_H) -Iinclude/asm-i386/mach-generic
> +AFLAGS += -Iinclude/asm-i386/$(MACHINE_H) -Iinclude/asm-i386/mach-generic

What's wrong with:
CFLAGS += -Iarch/i386/$(MACHINE_H) -Iarch/i386/mach-generic
That should achieve the same effect?

	Sam
