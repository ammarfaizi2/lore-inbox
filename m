Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbSKUTN7>; Thu, 21 Nov 2002 14:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbSKUTN7>; Thu, 21 Nov 2002 14:13:59 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:8460 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266969AbSKUTN5>;
	Thu, 21 Nov 2002 14:13:57 -0500
Date: Thu, 21 Nov 2002 20:15:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [RFC] [PATCH] subarch cleanup
Message-ID: <20021121191506.GA2007@mars.ravnborg.org>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	"J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	lkml <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <1037750429.4463.71.camel@w-jstultz2.beaverton.ibm.com> <20021121183304.GA1144@mars.ravnborg.org> <1037904954.7576.62.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037904954.7576.62.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 10:55:54AM -0800, john stultz wrote:
> Actually, in some cases, such as summit, we only have one header file
> that is different from generic. We don't want to replicate all the
> generic .c files, So in that case MACHINE_C := mach-generic and
> MACHINE_H := mach-summit. 

If we are going to extend the concept of machines for i386 we should
add a default CONFIG option for the generic case.
Then we could do something like:

core-$(CONFIG_MACH_I386GENERIC)  += arch/i386/mach-generic
core-$(CONFIG_MACH_VISWS)        += arch/i386/mach-visws
core-$(CONFIG_MACH_SUMMIT)       += arch/i386/mach-generic

mflags-$(CONFIG_MACH_VISWS)      := asm/mach-visws
mflags-$(CONFIG_MACH_SUMMIT)     := asm/mach-summit
mflags-y                         += asm/mach-generic
AFLAGS += $(mflags-y)
CFLAGS += $(mflags-y)

There is something similar done for arm in newest kernel.

	Sam
