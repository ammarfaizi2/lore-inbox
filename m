Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbUDQLs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 07:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263926AbUDQLs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 07:48:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44304 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263861AbUDQLs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 07:48:56 -0400
Date: Sat, 17 Apr 2004 12:48:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Rolf Kutz <kutz@netcologne.de>, 244207@bugs.debian.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#244207: kernel-source-2.6.5: mwave gives warning on suspend
Message-ID: <20040417124850.C14786@flint.arm.linux.org.uk>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	Rolf Kutz <kutz@netcologne.de>, 244207@bugs.debian.org,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040417104311.9C13A1D802@jamaika.kutz.dyndns.org> <20040417113918.GA4846@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040417113918.GA4846@gondor.apana.org.au>; from herbert@gondor.apana.org.au on Sat, Apr 17, 2004 at 09:39:18PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 09:39:18PM +1000, Herbert Xu wrote:
> On Sat, Apr 17, 2004 at 12:43:11PM +0200, Rolf Kutz wrote:
> > Package: kernel-source-2.6.5
> > Version: 2.6.5-1
> > Severity: normal
> > 
> > The mwave module gives the following warning on suspend:
> > 
> > Apr 16 09:55:13 localhost kernel: Device 'mwave' does not have a release() funct
> > ion, it is broken and must be fixed.
> > Apr 16 09:55:13 localhost kernel: Badness in device_release at drivers/base/core
> > .c:85
> 
> Thanks for the report.
> 
> This patch should shut the warning up.

And that's all it does.  It doesn't stop the oops which potentically can
happen when the struct device is freed (by the module being unloaded)
while there is still a reference to the struct device.

This is the whole point of the warning - to warn that the necessary
release functionality is not present, and that the way the device
is being used is buggy.

Providing an empty release function is not a solution - it merely papers
over the warning leaving the real bug behind.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
