Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWHQLEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWHQLEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWHQLEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:04:45 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:62919 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964801AbWHQLEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:04:45 -0400
Date: Thu, 17 Aug 2006 13:01:10 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux@horizon.com
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [NTP 8/9] convert to the NTP4 reference model
In-Reply-To: <20060810203106.1476.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0608171246300.6762@scrub.home>
References: <20060810203106.1476.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, linux@horizon.com wrote:

> The original NTP kernel interface was defined in units of microseconds.
> That's what Linux implements.  As computers have gotten faster and can
> now split microseconds easily, a new kernel interface using nanosecond
> units was defined ("the nanokernel", confusing as that name is to OS
> hackers), and there's an STA_NANO bit in the adjtimex() status field to
> tell the application which units it's using.

BTW this patch didn't add the STA_NANO bits yet, as that requires changes 
to <sys/timex.h> and a recompiled ntpd, so the values are still in usec.
It's not difficult to change/add, but one has to be a little careful about 
compatibility.

> The current ntpd supports both, but Linux loses some possible timing
> resolution because of quantization effects, and the ntpd hackers would
> really like to be able to drop the backwards compatibility code.
> 
> Ulrich Windl has been maintaining a patch set to do the conversion for
> years, but it's hard to keep in sync.

I think you refer to the PPSKit? Well, the first step to integrate it 
properly is done. Ulrich took the reference code rather unmodified, which 
has a rather strong emphasis on weird portability (one only has to look at 
l_fp.h to know what I mean), which is not really acceptable in the kernel. 
Its ioctl API probably should be converted to sysfs, so there is still 
some way to go.

bye, Roman
