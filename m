Return-Path: <linux-kernel-owner+w=401wt.eu-S932365AbWLLV3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWLLV3R (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 16:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWLLV3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 16:29:17 -0500
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:44226 "EHLO
	reserv6.univ-lille1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932365AbWLLV3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 16:29:16 -0500
Message-ID: <457F1F0F.20109@tremplin-utc.net>
Date: Tue, 12 Dec 2006 22:28:47 +0100
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: O2micro smartcard reader driver.
References: <20061127182817.d52dfdf1.l.bigonville@edpnet.be> <456C0BD0.7080606@tremplin-utc.net> <200611281249.45243.oliver@neukum.org>
In-Reply-To: <200611281249.45243.oliver@neukum.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-2.0.2 (reserv6.univ-lille1.fr [193.49.225.20]); Tue, 12 Dec 2006 22:28:48 +0100 (CET)
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-USTL-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

28.11.2006 12:49, Oliver Neukum wrote/a écrit:
>> Latest version I've published is there:
>> http://pieleric.free.fr/o2scr/
> 
>         case OZSCR_OPEN: /* Request ICC */
>             dprintk("OZSCR_OPEN\n");
>             ATRLength = ATR_SIZE;
>             pRdrExt->IOBase = (PSCR_REGISTERS *) dev->io_base; //XXX necessary?
>             pRdrExt->membase = dev->am_base; //XXX necessary?
> 
>             pRdrExt->m_SCard.AvailableProtocol = 0;
>             pRdrExt->m_SCard.RqstProtocol = 0;
>             dprintk("membase:%p\n", pRdrExt->membase);
>             dprintk("ioport:0x%03x\n", (unsigned)pRdrExt->IOBase);
> 
>             ret = CmdResetReader( pRdrExt, FALSE, ATRBuffer, &ATRLength );
>             apdu.LengthOut = ATRLength;
> 
> #ifdef PCMCIA_DEBUG
>             printk(KERN_DEBUG "Open finished, ATR buffer = ");
>             for( ATRLength = 0; ATRLength < apdu.LengthOut; ATRLength++ )
>                 printk(" [%02X] ", ATRBuffer[ATRLength] );
>             printk("\n");
> #endif
> 
>             memcpy( apdu.DataOut, ATRBuffer, ATRLength );
>             ret = copy_to_user((struct ozscr_apdu *)arg, &apdu, sizeof(struct ozscr_apdu));
>             break;
> 
> 1. This needs locking against concurrent ioctls
> 2. The interpretation of copy_to_user()'s return code is incorrect
> 

Hi Oliver,

Thanks a lot for reading my code, I didn't even hope that someone would! 
I've corrected the copy_to_user (and copy_from_user) code. However I 
don't know how to do locking for the concurrent ioctls. Indeed, I don't 
think there is anything preventing two programs to call the driver at 
the same time. Unfortunately, I've got no idea how to do the locking and 
surprisingly couldn't find any ioctl code in the kernel doing locking. 
Maybe I've just not looked at the right place, could you give a me some 
hint how to do locking for ioctl's ?

See you,
Eric

