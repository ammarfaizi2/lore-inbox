Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131474AbRCQAc7>; Fri, 16 Mar 2001 19:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbRCQAct>; Fri, 16 Mar 2001 19:32:49 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:53830 "EHLO
	phenoxide.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S131474AbRCQAcg>; Fri, 16 Mar 2001 19:32:36 -0500
Date: Fri, 16 Mar 2001 16:31:53 -0800
From: Johannes Erdfelt <jerdfelt@valinux.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'linux-usb-devel@lists.sourceforge.net'" 
	<linux-usb-devel@lists.sourceforge.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: [Acpi] [PATCH] USB suspend when no devices attached
Message-ID: <20010316163153.K25511@valinux.com>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE775@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE775@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Fri, Mar 16, 2001 at 04:21:28PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2001, Grover, Andrew <andrew.grover@intel.com> wrote:
> This is a preliminary patch against 2.4.2 to uhci.c that puts the host
> controller into global suspend when there are no devices attached. This
> conserves power on mobile systems, and because suspending the host
> controller ceases UHCI's incessant busmastering activity, it allows the CPU
> to enter a deeper idle state.
> 
> The main problem with this implementation is that it just looks at the 2
> root hub ports and suspends if nothing is connected. Ideally, it would be
> smart enough to realize it can also suspend when only hubs are present, or
> when all devices on the USB are also suspended. I hope a USB expert can add
> these enhancements, as it's beyond me.

If you want it to be seamless, you really can't do that. USB is a polled
bus, so the HC needs to send something to the device so it tells us that
something has changed, like a device being plugged into a hub (not the root
hub).

> You should be able to verify this patch is working in one of two ways:
> 1) Turn on USB debug messages, and look for suspend_hc and wakeup_hc
> messages
> 2) Download the latest ACPI patch from
> http://developer.intel.com/technology/iapc/acpi/downloads.htm and verify
> that /proc/acpi/processor/0/status shows mostly 0's for busmastering
> activity (as opposed to mostly F's) when no USB devices are connected.

Thanks for the patch. I'll integrate into my patch and send it off to Linus
as well after I run it through it's paces.

It looks good on visual inspection atleast.

JE

