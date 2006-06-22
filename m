Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751849AbWFVRbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbWFVRbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWFVRbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:31:32 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:27851 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751849AbWFVRbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:31:31 -0400
Date: Thu, 22 Jun 2006 19:31:29 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Danial Thom <danial_thom@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Measuring tools - top and interrupts
Message-ID: <20060622173128.GD14682@harddisk-recovery.com>
References: <20060622162141.GC14682@harddisk-recovery.com> <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 09:58:08AM -0700, Danial Thom wrote:
> --- Erik Mouw <erik@harddisk-recovery.com> wrote:
> > 75K packets/s isn't too hard for modern NICs,
> > especially when using
> > NAPI.
> 
> Well thats just a ridiculous answer, so why
> bother? 
> 
> You polling guys just crack me up. There isn't
> much less work to be done with polling. The only
> reason you THINK its less work is because the
> measuring tools don't work properly. You still
> have to process the same number of packets when
> you poll, and you have polls instead of
> interrupts. Since you can control the # of
> interrupts with most cards, there is zero
> advantage to polling, and more negatives.

There certainly is less work to be done with polling. Less IRQs means
less expensive context switches, which means a lower system load. See
Documentation/NAPI_HOWTO.txt for information and a link to the Linux
NAPI paper.

> And 75K pps may not be "much", but its still at
> least 10% of what the system can handle, so it
> should measure around a 10% load. 2.4 measures
> about 12% load. So the only conclusion is that
> load accounting is broken in 2.6.

Network traffic is usually IO bound, not CPU bound. The load figures
top shows tell something about the amount of work the CPU has to do,
not about how busy your PCI bus (or whatever bus the NIC lives on) is.

IIRC the networking layer in 2.6 differs quite a lot from 2.4, so the
load average figures can be quite misleading.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
