Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277409AbRJJU1I>; Wed, 10 Oct 2001 16:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277408AbRJJU1C>; Wed, 10 Oct 2001 16:27:02 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:12563 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S277409AbRJJU0s>; Wed, 10 Oct 2001 16:26:48 -0400
Message-Id: <200110102027.f9AKRFY85831@aslan.scsiguy.com>
To: Alexander Feigl <Alexander.Feigl@gmx.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: aic7xxx SCSI system hangs 
In-Reply-To: Your message of "10 Oct 2001 21:36:06 +0200."
             <1002742566.9219.5.camel@PowerBox.MysticWorld.de> 
Date: Wed, 10 Oct 2001 14:27:15 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't have any real kdb experiences and not much time at the
>moment.But I try to post the required information. I attached a second
>computer via null modem cable to serial and logged the output. Tell me
>if some essential output is missing.

You should run with "aic7xxx=verbose".  Since you are using modules,
you will need to add a line similar to the following to /etc/modules.conf
and, if you are using an initrd, rerun mkinitrd to have the change come
into effect.

#you should already have this line
alias scsi_hostadapter aic7xxx
#but need this line
options aic7xxx aic7xxx='"verbose"'

>Where can I find information how to trace the problem with kdb or
>anything else?

The kdb package comes with several man pages.

>Entering kdb (current=0xc183e000, pid 3) due to Keyboard Entry
>kdb> b btp 16
>    EBP       EIP         Function(args)
>0xdf945f6c 0xc0112d34 schedule+0x2d4 (0xc18627c0, 0xdf944000)
>                               kernel .text 0xc0100000 0xc0112a60 0xc0112e80
>0xdf945f9c 0xc0105df0 __down_interruptible+0x80 (0xdf945fd8, 0xe082051f, 0xdf9
>45
>fec, 0xe08189d7, 0x100)
>                               kernel .text 0xc0100000 0xc0105d70 0xc0105e50
>0xdf945fac 0xc0105eae __down_failed_interruptible+0xa
>                               kernel .text 0xc0100000 0xc0105ea4 0xc0105eb4
>           0xc0105763 kernel_thread+0x23
>                               kernel .text 0xc0100000 0xc0105740 0xc0105780
>kdb> 

This looks pretty normal for an exception handling thread.  It is asleep
waiting for some error condition to wake it up.

--
Justin
