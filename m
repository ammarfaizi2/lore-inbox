Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbSIWTNQ>; Mon, 23 Sep 2002 15:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSIWTL6>; Mon, 23 Sep 2002 15:11:58 -0400
Received: from magic.adaptec.com ([208.236.45.80]:39319 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S261343AbSIWTLT>; Mon, 23 Sep 2002 15:11:19 -0400
Date: Mon, 23 Sep 2002 13:15:44 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Konstantin Kletschke <konsti@ludenkalle.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre7-ac3 aic7xxx broken?
Message-ID: <2539730816.1032808544@aslan.btc.adaptec.com>
In-Reply-To: <20020923180017.GA16270@sexmachine.doom>
References: <20020923180017.GA16270@sexmachine.doom>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
> 
> I wonder if my 
> 
> Bus  0, device   9, function  0:
>       SCSI storage controller: Adaptec AHA-7850 (rev 3).

...

> is broken or the aic7xxx driver in linux-2.4.20-pre7-ac3?
> 
> The modul loads fine, the cdrom seems to work properly, though,
> but this messages appears in my
> message.log:
> 
> ==> /var/log/syslog <==
> Sep 23 19:32:23 sexmachine kernel: scsi1: PCI error Interrupt at seqaddr
> = 0x9
> Sep 23 19:32:23 sexmachine kernel: scsi1: Data Parity Error Detected
> during address or write data phase
> 
> several times a minute. The aic7xxx_old produces no errorr messages...

On some motherboards with some chipsets, you can get these messages if
another busmaster (say an IDE drive or a sound card) is hogging the bus.
Usually this is with a VIA chipset.  Its not clear why the aic7xxx_old
driver would behave differently other than it disables memory write
and invalidate PCI transactions on this chip.  The new driver doesn't
need that work around.

As to wether it is safe or not, well our investigation into these issues
has shown that the parity errors are real, but it is the parity that
is at fault.  It is hard to say if that is the case for your MB or not.
Can you provide, in private email, a full lspci dump?

Thanks,
Justin
