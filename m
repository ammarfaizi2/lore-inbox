Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267319AbTBFOpw>; Thu, 6 Feb 2003 09:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbTBFOpw>; Thu, 6 Feb 2003 09:45:52 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46238
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267319AbTBFOpv>; Thu, 6 Feb 2003 09:45:51 -0500
Subject: Re: [PATCH] PATCH: add framework for ndelay (nanoseconds)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20030206174944.A17905@jurassic.park.msu.ru>
References: <200302040533.h145Xqq19457@hera.kernel.org>
	 <Pine.GSO.4.21.0302051533320.16681-100000@vervain.sonytel.be>
	 <20030206174944.A17905@jurassic.park.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044546783.10374.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Feb 2003 15:53:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 14:49, Ivan Kokshaysky wrote:
> > Wouldn't it make more sense to call the parameter `nsecs' (or `ns')?
> 
> There are more serious problems with this implementation:
> 1) It's *very* imprecise. Even on an 1 GHz CPU and with HZ = 100 precision
>    is ~86 nsec. With HZ = 1000 it's almost unusable on *any* CPU.

HZ = 1000 isn't a 2.4 thing.

> As of current 2.4, there is the only user of ndelay() - ide_execute_command()
> that calls ndelay(400). Why udelay(1) cannot be used instead?

Why waste 500nS every IDE command as opposed to doing the job right ? The initial
ndelay() is a quick implementation. If you don't like it implement a better one,
if your box isnt fast implement it as udelay.

In the 2.5 tree I also hope we can avoid the ndelay in some cases

Alan

