Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271741AbTHDOPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271749AbTHDOPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:15:46 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:60141
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S271741AbTHDOPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:15:43 -0400
Date: Mon, 4 Aug 2003 18:18:46 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: "Cho, joon-woo" <jwc@core.kaist.ac.kr>, linux-kernel@vger.kernel.org
Subject: Re: [Q] Question about memory access
Message-ID: <20030804161846.GA814@wind.cocodriloo.com>
References: <00a001c35a58$02c20f00$a5a5f88f@core8fyzomwjks> <1059989725.392.2.camel@sherbert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059989725.392.2.camel@sherbert>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 10:35:25AM +0100, Gianni Tedesco wrote:
> On Mon, 2003-08-04 at 08:14, Cho, joon-woo wrote:
> > If someone want to transfer large data from some device to memory, he may
> > use DMA method.
> > 
> > At this point, i am confused.
> > 
> > I think that only one process can access physical memory(RAM) at a time.
> 
> The DMA controller is a dedicated piece of hardware that copies the data
> from devices to RAM. This means that other processes can use the CPU
> while the DMA is in progress. That is the whole point of DMA.

Yes, this is called having 2 bus masters, which are the chips that
can use the bus to read and write to memory. What can be done is to
timeshare the bus, for example the cpu accesses memory on odd cycles
and the dma chip does on even cycles.

A more complex design would allow the cpu to access memory on all
cycles, but give the dma chip more priority. This would mean that
a dma transfer would take priority over the cpu. Think about
a sound card reading the sound data to pump it to the speakers,
you would prefer not to have it skip.

Greets, Antonio.

-- 

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
