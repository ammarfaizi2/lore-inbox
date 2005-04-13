Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVDMJZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVDMJZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVDMJZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:25:57 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:20998 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261270AbVDMJZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:25:21 -0400
From: Yuri Vilmanis <vilmanis@internode.on.net>
To: linux-kernel@vger.kernel.org
Subject: EXPORT_SYMBOL_GPL for __symbol_get replacing EXPORT_SYMBOL for deprecated inter_module_get
Date: Wed, 13 Apr 2005 18:55:00 +0930
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504131855.00806.vilmanis@internode.on.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that, in general, new functions which replace deprecated functions 
which were exported as EXPORT_SYMBOL, should also be exported as 
EXPORT_SYMBOL, not as EXPORT_SYMBOL_GPL. The reason I say this is because 
deprecation of old functions breaks old modules and drivers that use them, 
and changing the level of GPL strictness of the function prevents these old 
modules being updated and used with newer kernels.

The case in point for me is ATI's binary openGL accelerated drivers (fglrx) - 
these used inter_module_get() to communicate with the agp gart module, for 
obvious reasons - this AGP communication is essential to the functionality of 
the driver. No, I don't like ATI only having closed-source drivers any more 
than you, but given the extremely competetive nature of high end video card 
sales, I can see why they want to do it this way. The point is that now, as 
of 2.6.11-? or 2.6.12-? (not sure of the exact revision), the 
inter_module_get() functions has been removed, and the functionality can only 
be got (as far as I can tell) through use of the symbol_get() function. 

Am I take it to mean that no closed-source / binary-only driver may use AGP 
acceleration in the future, including ones that have in the past? Or if an 
alternate method of AGP accelerated access exists (I dont know the kernel 
well enough to know for sure), does this mean companies which have at least 
been respectful enough to have provided linux drivers must now rewrite them 
to use an entirely different methodology in their drivers, write entirely new 
agp drivers which will then probably also be closed-source, and are likely to 
cause further problems down the line, or GPL drivers which contain code 
important to the competetiveness of the company? I think this is not a good 
situation for linux users or hardware manufacturers, and indeed shows Linux 
itself in a bad light.

I respect and agree with the use of EXPORT_SYMBOL_GPL to maintain new 
*software* functionality added by kernel developers, but when this prevents 
propriatary drivers from using advanced *hardware* features of common 
hardware connectivity devices like an AGP port, its silliness, plain and 
simple (I think this applies equally to other devices which are required for 
the connection of the device for which the propriatary driver was created, 
such as USB, PCI, serial, AGP, PCIExpress, firewire, IDA/SATA etcetc where 
DMA, ATA, fast serial (as provided by some Maxim chips with accelarated 
slew-rate) or other advanced advanced transfer modes are provided and enabled 
by the *harware*).

Also, deprecating non-GPL-strict functionality and replacing it with 
GPL-strict funtionality is just as bad, in my view, as going through the 
kernel and randomly changing instance of EXPORT_SYMBOL to EXPORT_SYMBOL_GPL - 
it has the same effect, of breaking established propriatary drivers, and 
forcing companies which do not feel that they can GPL the source and maintain 
their competetive advantage, to rewrite their drivers to use alternate 
methods (which they therefore have no certainty will be available in the 
future either), or dropping support altogether (which I'm sure nobody really 
wants). If Linux had a near-monopoly market share, it might be possible to 
get away with such strong-arm tactics in the interest of spreading the FSF 
distribution philosophy - but then again, look what similar tactics did to 
public opinion of the distribution philosophy of a certain Redmond company 
which did have near-monopoly market share.... I shudder at the thought of the 
point being applicable to Linux, but I think it must be made in order to 
prevent it becoming creepingly (and creepily) more valid in the future.

The case of inter_module_get deprecation and replacement with symbol_get 
embodies both sides: it makes a non-GPL export into a GPL export (yes, its 
now called by a different name, and the backend has changed, but the first 
change is cosmetic and the second change is internal), and it also prevents 
closed-source drivers from using functionality of a device that they have no 
choice but to connect through, and require for competetive performance.

To sum up:
1) Please make symbol_get a non-GPL export, so that those of us with hardware 
that needs it can continue to use it (eg anyone with an ATI video card that 
wants to use the shaders and extensions that are the point in favour over 
NVidia offerings)
2) I think the use of GPL symbol exports should be more carefully monitored 
where it affects existing closed-source drivers and designed-in hardware 
functionality like AGP, to avoid alienating companies which have been polite 
enough to come half way and supported their hardware under this great OS.

After all, I think we all want Linux to win by being the best - not by going 
around shouting "Thou shalt use the GPL, it ownz your propriatary 
distribution model and if you dont use it youre a moron and we wont let you 
use Linux" at passing strangers (not that this is likely to work anyway).

-Yuri

PS - This was not meant to be a rant, start a flamewar or even tread on 
anyones toes, really.... I'm just a bit annoyed that I can't do my shader 
development while running a nice bleeding-edge kernel, and apprehensive of 
not being able to do my shader development in a few months/years when this 
kernel is officially OldHat (TM, Inc, or whatever)
