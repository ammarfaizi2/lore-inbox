Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbTJAKp6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 06:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTJAKp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 06:45:58 -0400
Received: from mail.convergence.de ([212.84.236.4]:17364 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261761AbTJAKp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 06:45:56 -0400
Message-ID: <3F7AB062.9030505@convergence.de>
Date: Wed, 01 Oct 2003 12:45:54 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Sweetman <ed.sweetman@wmich.edu>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE I/O disturbes other PCI busmasters on VIA platforms
References: <3F79B630.8070308@convergence.de> <20030930171821.GL9523@vana.vc.cvut.cz> <3F79BFD2.5010006@wmich.edu>
In-Reply-To: <3F79BFD2.5010006@wmich.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ed,

> I get none of these problems. That is with a bt878 tv card, G450 agp 
> video card, 2.6.0-test5, udma4 enabled, and using xawtv with xv via the 
> v4l module for X.  If i disable dma, the tv is the only thing 
> uneffected. This is on a Abit mobo with VIA vt82c686b ide chipset and 
> VIA Twister-K/KT133x/KM133 agp chipset (using agpgart). DRI not loaded.

> If disabling dma gives you picture distortion, then it seems to me to be 
> obvious that Busmastering has nothing to do with the problem and rather 
> it's a rendering issue.  

Hm, I don't think so. I think that disabling dma and thus the polling of 
the CPU on the IDE->PCI bus simply hogs it completely.

> If you're using x11 to render the image than it 
> will most certainly be effected by heavy io as the kernel will have 
> issues scheduling under heavy io, especially in 2.4.   I would check to 
> make sure you're using xv to render the tv window if you have that 
> option, if not then maybe that's as best as you can do with X.

I'm using the overlay facility, ie. the data is written directly to the 
framebuffer. There is no CPU, no scheduling and no memcpy() involved, 
just pure PCI-to-AGP busmaster transfer. If I see distortions there, 
then I guess it's a busmastering issue.

As I have already written, you can make things even worse, if you lower 
the latencies vie setpci or shrink the dma burst sizes. Then you'll get 
only pixel garbage... ;-)

CU
Michael.

