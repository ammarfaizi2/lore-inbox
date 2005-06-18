Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVFRMxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVFRMxt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 08:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVFRMxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 08:53:49 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:22743 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262107AbVFRMxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 08:53:46 -0400
Message-ID: <42B41956.9020104@colorfullife.com>
Date: Sat, 18 Jun 2005 14:53:42 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marvin24@gmx.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: forcedeth as a module only?
References: <200506171804.j5HI4qoh027680@dbl.q-ag.de> <42B31749.90208@g-house.de> <42B336FC.9000400@colorfullife.com> <200506181245.00670.marvin24@gmx.de>
In-Reply-To: <200506181245.00670.marvin24@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

marvin24@gmx.de wrote:

>Hello Manfred,
>
>I have an Asus K8N-E Deluxe (nForce3) and had problems with loosing network 
>connection from time to time (every 30 minutes or so). The nic is NVENET_7 
>(see lspci). Adding the DEV_NEED_LINKTIMER workaround solved the problem for 
>me.
>What is this workaround doing?
>
The network hardware consists out of two parts:
- the PHY, which performs the physical encoding: basically a very smart 
digital/analog converter. It's a seperate chip on your board.
- the MAC (Media Access controller) does the rest: decide which packet 
to send/receive, verify the CRC, do the memory transfer to/from main 
memory, etc. This part is integrated into the nForce chipset.

The PHY detects the link partner and sets itself to the proper network 
speed. If the link partner changes, then the PHY reconfigures itself. 
The change can be a spurious change - bad cabling, too much 
electromagnetic noise, whatever. The driver must notice if the PHY did a 
reconfiguration and reconfigure the MAC. The driver can either wait for 
an interrupt, or poll the PHY once per second and ask if the link speed 
setting must be updated.
For me, interrupts work. But for some users, no interrupts are 
generated. I thought that nForce 3 generates interrupts and thus polling 
is only used for nForce 1/2.

> Since I also heard of several people having 
>such problems, why isn't this fix applied to all forcedeth devices?
>
>  
>
I'll send a patch to Jeff.

>Btw. Windows XP x86-64 has the same problem - but didn't found the source yet 
>to patch ;-)
>
>  
>
Interesting.

--
    Manfred
