Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265739AbTFSJER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 05:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265742AbTFSJER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 05:04:17 -0400
Received: from asclepius.uwa.edu.au ([130.95.128.56]:38108 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id S265739AbTFSJEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 05:04:16 -0400
Date: Thu, 19 Jun 2003 17:17:43 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Florian-Daniel Otel <otel@ce.chalmers.se>
Cc: EricAltendorf@orst.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: RTC causes hard lockups in 2.5.70-mm8
Message-ID: <20030619091743.GA765@amidala>
References: <Pine.LNX.4.55L-032.0306122205210.4915@unix48.andrew.cmu.edu> <1055492730.5162.0.camel@dhcp22.swansea.linux.org.uk> <200306171232.27887.EricAltendorf@orst.edu> <200306190031.54686.EricAltendorf@orst.edu> <16113.30505.519963.233275@solen.ce.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16113.30505.519963.233275@solen.ce.chalmers.se>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 10:41:13AM +0200, Florian-Daniel Otel wrote:
> I can confirm the RTC problems on a Fujitsu LifeBook P2120 (Crusoe
> TM5800, ALi, ACPI). In my case I was even more fortunate (??) since
> using RTC (either compiled-in in the kernel and/or as a module), any
> call to "hwclock" locks the machine rock solid

Ditto. Also an ALi here. I traced it through (printk debugging) and
it appears to lock up in the call to schedule() in rtc_read().
(2.4.21)

Has happened since about 2.4.21-pre3'ish. Haven't had time yet to
establish exactly which release (or ACPI release) started it.

A quirkier but similar bug - this laptop would freeze when writing
to the hardware clock *IF* there was a CD-ROM in the drive (IDE).
This freeze also seemed to occur at midnight most nights. Ejecting
the CD-ROM before saving the hwclock and also at 11:59pm disabled
the problem. This problem existed even without ACPI.

Bernard.

-- 
 Bernard Blackham 
 bernard at blackham dot com dot au

