Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264020AbTDJKOs (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 06:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264018AbTDJKOs (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 06:14:48 -0400
Received: from tango1.exp.bessy.de ([193.149.14.28]:35588 "EHLO
	tango1.exp.bessy.de") by vger.kernel.org with ESMTP id S264020AbTDJKOr (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 06:14:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Frank Hoeft <frank.hoeft@bessy.de>
Organization: BESSY
To: linux-kernel@vger.kernel.org
Subject: stacked driver communication
Date: Thu, 10 Apr 2003 13:25:59 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <S264020AbTDJKOr/20030410101447Z+3666@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Stacked driver communication (kernel 2.2.20):

I wrote stacked driver moduls for an measurement system.
The lower driver handles the access to the pci-card.
This pci-card controls a bus-system , like iee488 for example.
This bus controls serveral at96-measurements-cards.
So the upper moduls control these different cards.

If the lower modul receive (from pci-card) an interrupt ,it 
have to  address the corresponding upper modul-isr.
So ,that moduls can read his registers.

I have solve this by ...
The upper modul registered the address from his isr
(and his at96-irq) in the lower modul.
The lower modul can detect wich at96-irq are requested.
The lower modul-isr  jumps in the corresponding 
upper module-isr, can fetch the data and wake up the
process.

I know the possibility to make it with EXPORT_SYMBOL
and use it to access from serveral 
upper-moduls to the lower-modul.

My question is:

It is possible to make this - or doubtful ... , 
if I make it secure (with corresponding 
register- an unregister- functions) that no 
pointer is standing in the wood.  


Best regards Frank Hoeft
