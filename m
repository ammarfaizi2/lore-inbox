Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318404AbSGYJSt>; Thu, 25 Jul 2002 05:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318392AbSGYJSt>; Thu, 25 Jul 2002 05:18:49 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16890 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318404AbSGYJSs>; Thu, 25 Jul 2002 05:18:48 -0400
Subject: Re: 2.4.19-rc3-ac2 I2O (Promise SX6000) funkiness
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stuffed Crust <pizza@shaftnet.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020725034316.GA4501@shaftnet.org>
References: <20020725034316.GA4501@shaftnet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 11:35:48 +0100
Message-Id: <1027593348.9488.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 04:43, Stuffed Crust wrote:
> It starts out fine, then the console starts spewing these messages after
> about 30/2664 inode tables.
> 
> 	i2o/iop0: No handler for event (0x00000020)
> 	i2o/iop0: No handler for event (0x00000020)
> 	i2o/iop0: No handler for event (0x00000020)
> 	i2o/iop0: No handler for event (0x00000020)
> 	i2o/iop0: No handler for event (0x00000020)

Its spewing events we didnt ask for then it dies

> 
> 	i2o/iop0: Hardware Failure: Unknown Error  
> 	i2o/iop0: Hardware Failure: Unknown Error  
> 	i2o/iop0: Hardware Failure: Unknown Error  

That says it all. Thats a message from the controller on the SX6000
saying "I broke".

> FWIW, this is a newer SX6000 with PDC20276 chips on it, and it's sharing
> IRQ10 with the usb controller.  Disabling it makes no difference.

You will need at list 2.4.19ac from a cold boot for this card to work.
Also check your boot logs to ensure it skipped over the PDC20276
controllers correctly. I think the code is right but I am not yet sure.

If we don't skip the 20276 chips properly then we reconfigure them and
the raid card has kittens (rightly so)

> Further details can be provided upon request...
> 
> I can move the controller to another machine this weekend for further
> testing.  But in the mean time, Just what is event 0x00000020?

Its an invalid I2O event code. Promise cards emit them before crashing
when you ask them to do anything they take offence too.

> I suppose I can call up Promise, but as their driver won't even compile,
> I don't have much faith in their ability to do anything but shave a
> couple of hours off of my life.

Actually the promise provided driver for the supertrak cards seems to
work fine. I actually used it to debug the generic i2o_block support for
their chips. It won't help if we are eating the ide controllers however

