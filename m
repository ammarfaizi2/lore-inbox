Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbTI3Rkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 13:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTI3Rkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 13:40:42 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:29419 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261648AbTI3Rjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 13:39:32 -0400
Message-ID: <3F79BFD2.5010006@wmich.edu>
Date: Tue, 30 Sep 2003 13:39:30 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Michael Hunold <hunold@convergence.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE I/O disturbes other PCI busmasters on VIA platforms
References: <3F79B630.8070308@convergence.de> <20030930171821.GL9523@vana.vc.cvut.cz>
In-Reply-To: <20030930171821.GL9523@vana.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> On Tue, Sep 30, 2003 at 06:58:24PM +0200, Michael Hunold wrote:
> 
>>Hello all,
>>
>>If you disable dma, you'll notice frozen pictures, which will last up to 
>>several seconds.
>>
>>I tried the following
>>- use latest 2.4 kernel
>>- set latencies for the different PCI devices with "setpci"
>>- play with burst and threshold settings of the saa7146 busmaster
>>
>>Unfortunately, non of these things really helped. I was able to make 
>>things worse (by setting latencies very low or by lowering the burst 
>>size of the transfers), but I did not get rid of the problem.
>>
>>Does anyone know a solution for this problem? Any help is appreciated.
> 
> 
> Do not perform busmaster transfers between busses with diffrerent speeds,
> or use only 20MBps bandwidth or do not use VIA. All chips I saw from
> them are not able to convert burst transfer on PCI to the burst
> transfer on AGP bus. Either go through main memory, or plug PCI videocard
> to your box.
> 						Petr Vandrovec


I get none of these problems. That is with a bt878 tv card, G450 agp 
video card, 2.6.0-test5, udma4 enabled, and using xawtv with xv via the 
v4l module for X.  If i disable dma, the tv is the only thing 
uneffected. This is on a Abit mobo with VIA vt82c686b ide chipset and 
VIA Twister-K/KT133x/KM133 agp chipset (using agpgart). DRI not loaded.

If disabling dma gives you picture distortion, then it seems to me to be 
obvious that Busmastering has nothing to do with the problem and rather 
it's a rendering issue.  If you're using x11 to render the image than it 
will most certainly be effected by heavy io as the kernel will have 
issues scheduling under heavy io, especially in 2.4.   I would check to 
make sure you're using xv to render the tv window if you have that 
option, if not then maybe that's as best as you can do with X.

