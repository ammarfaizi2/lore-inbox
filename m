Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265687AbUAMXad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265686AbUAMXad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:30:33 -0500
Received: from adsl-065-081-070-095.sip.gnv.bellsouth.net ([65.81.70.95]:40605
	"EHLO medicaldictation.com") by vger.kernel.org with ESMTP
	id S265687AbUAMXa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:30:28 -0500
Date: Tue, 13 Jan 2004 18:30:29 -0500
From: Chuck Berg <chuck@encinc.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: HPT372 DMA corruption
Message-ID: <20040113183029.A16406@timetrax.localdomain>
References: <20040109150501.A5891@timetrax.localdomain> <Pine.LNX.4.53.0401091517390.1022@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0401091517390.1022@chaos>; from root@chaos.analogic.com on Fri, Jan 09, 2004 at 03:24:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 03:24:28PM -0500, Richard B. Johnson wrote:
[cmp -l bad good]
> >  89260029   0  31
> >  89260030   0 327
> >  89260031   0 200
> >  89260032   0  13
> 
> Since whole bytes are not written, this looks strangely like
> an attempt to DMA to cached RAM! Since the CPU didn't write

I tested this by reading with O_DIRECT, and immediately after each read(),
read all of a 1MB array (my cache is only 256kB), and then checking the
data. The same corruption occurs. 

Via had a DMA corruption bug a couple years ago with similar symptoms,
apparently with the VT82C686B southbridge. Mine is a VT82C586B (which some
people also reported problems with). My board dates long after these
problems were discovered, so I sure hope it's not the same bug. I'll try
upgrading my BIOS to the latest version in case Soyo's changelog is not
entirely honest.

I did learn some more about the pattern of corruption. The data is not
being written to memory - the "bad" data is whatever happened to be there
before. It usually happens in 4, but sometimes 64 or 32 byte chunks.

When I read from the device with O_DIRECT, the corruption only appears at the
very end of the read. I've confirmed this for reads of 512 bytes through 256k
at multiples of 512 bytes.

