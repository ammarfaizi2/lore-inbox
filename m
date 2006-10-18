Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWJRNe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWJRNe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWJRNe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:34:59 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:7127 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1161011AbWJRNe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:34:58 -0400
Date: Wed, 18 Oct 2006 09:34:30 -0400
To: Paul B Schroeder <pschroeder@uplogix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Exar quad port serial
Message-ID: <20061018133430.GU30991@csclub.uwaterloo.ca>
References: <1160068402.29393.7.camel@rupert> <20061005173628.GB30993@csclub.uwaterloo.ca> <45357CA1.80706@uplogix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45357CA1.80706@uplogix.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 08:00:17PM -0500, Paul B Schroeder wrote:
> Sorry for the late response..  Here is a fuller explanation.  Maybe 
> somebody out there has a better solution:
> 
> This is on our "Envoy" boxes which we have, according to the documentation, 
> an "Exar ST16C554/554D Quad UART with 16-byte Fifo's".  The box also has 
> two other "on-board" serial ports and a modem chip.
> 
> The two on-board serial UARTs were being detected along with the first two 
> Exar UARTs.  The last two Exar UARTs were not showing up and neither was 
> the modem.
> 
> This patch was the only way I could the kernel to see beyond the standard 
> four serial ports and get all four of the Exar UARTs to show up.
> 
> I hope this explains it well enough..

I suspect all you have to do might be to change how many ports it looks
for.  The default max ports is 4 I believe on many kernel versions.

Look for CONFIG_SERIAL_8250_NR_UARTS and
CONFIG_SERIAL_8250_RUNTIME_UARTS in the kernel config.

If that doesn't work and you do need a special driver, at least label it
with more detail like 'for exar st16c554 quad uart' or 'for envoy board'
or whatever makes it clear which hardware it is for.  I use exar pci
uarts (exar XR17d15[248] chips) which work fine already with the 8250
driver, or optionally with the jsm driver with a small change to the
list if pci identifiers.  THey of course would not work with your driver
since they are completely different exar chips (even though one is also
a quad uart, although 64byte fifo).

--
Len Sorensen
