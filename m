Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUFJVgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUFJVgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 17:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUFJVga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 17:36:30 -0400
Received: from main.gmane.org ([80.91.224.249]:21144 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263088AbUFJVgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 17:36:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lars <terraformers@gmx.net>
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
Date: Thu, 10 Jun 2004 23:36:17 +0200
Message-ID: <caak85$9vg$1@sea.gmane.org>
References: <ca9jj9$dr$1@sea.gmane.org> <200406101459.45750.bzolnier@elka.pw.edu.pl> <ca9nid$bnc$1@sea.gmane.org> <200406101558.54240.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e7f092.dip.t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks

after some reading, im using now in rc.local:

### C1 Halt Disconnect Fix for Chip rev. C17
setpci -H1 -s 0:0.0 6F=1F
setpci -H1 -s 0:0.0 6E=01
echo "Applying C1 Halt Disconnect Fix"

this is for an older nforce2 board (a7n8x 1.04) with rev. C17 chip
and worked fine so far.

for the newer chip revision it should read

### C1 Halt Disconnect Fix for Chip rev. C18D
setpci -H1 -s 0:0.0 6F=9F
setpci -H1 -s 0:0.0 6E=01
echo "Applying C1 Halt Disconnect Fix"

first setpci is for the c1 halt bit and the second one enables the
80ns stability value.


i understand that its not good to enable c1 for all boards, but it would
be nice to have the option to force the fixup on boards which
work ok but have no bios option to enable c1. (like the a7n8x)
an bootoption like "forceC1halt" or something would be nice here.


cheers,
lars


>> ...maybe a switch to force the fixup on boards without c1 disconnect
>> bios-settings would do it ?



> 
> We can't do that, some older boards hang if C1 disconnect is used.
> 
> However you can enable fixup and then C1 Halt Disconnect yourself. :-)
> 
> setpci -v -H1 -s 0:0.0 6C.L=$(printf %x $((0x$(setpci -H1 -s 0:0.0 6C.L) &
> 0x9F01FF01)))
> 
> - to enable fixup first
> 
> setpci -v -H1 -s 0:0.0 6F=$(printf %x $((0x$(setpci -H1 -s 0:0.0 6F) |
> 0x10)))
> 
> - to enable C1 Halt Disconnect
> 
> [ this is untested as I don't have nForce2 board ]


