Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316837AbSG1O3x>; Sun, 28 Jul 2002 10:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSG1O3x>; Sun, 28 Jul 2002 10:29:53 -0400
Received: from [210.78.134.243] ([210.78.134.243]:16144 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S316797AbSG1O3w>;
	Sun, 28 Jul 2002 10:29:52 -0400
Date: Sun, 28 Jul 2002 22:35:19 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: problem with eepro100 NAPI driver
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207282238830.SM00792@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i applied the patch0708, but i still met the problem. 
when i tested the 64bytes frame with smartbits, in the beginning both the RX and TX of the system are OK. but after a while,the network card would not receive and transmit packets any more.
i checked the proc/ params, and found that when soft_reset_count increased one, the system would stop to receive packets for a while.  
the code after patched is as follows. at what condition will soft_reset_count increase? and  is there something  incorrect when dealing with that?  maybe the sp->cur_rx should be dealt?

      if (!(status & RxComplete)) {
         int intr_status;
         unsigned long ioaddr = dev->base_addr;
         unsigned long flags;

         spin_lock_irqsave(&sp->lock,flags);
         intr_status = inw(ioaddr + SCBStatus);
         /* We check receiver state here because if
          * we have to do soft reset,sp->cur_rx should
          * point to an empty entry or something
          * unexpected will happen
          */
         if ((intr_status & 0x3c) != 0x10) {
            if (speedo_debug > 4)
               printk("No resource,reset\n");
            speedo_rx_soft_reset(dev);
            sp->soft_reset_count++;
         }
         spin_unlock_irqrestore(&sp->lock,flags);
         break;
      }



>  I don't know which version you get.The ealier versions do have
>serious problems. The latest one(6.19) on NAPI website works
>well for me,but someone report problem of it too.Since i get no
>environment and time to investigate it,the problem is pending now.
>I will send you the latest patch in case you can't find it in other mail.
>
>zhengchuanbo wrote:
>
>>i tried ehe eepro100 NAPI driver on linux2.4.19. the kernel was compiled successfully. but when i tested the throughput of the system,i met some problem.
>>i tested the system with smartbits. when the frame size is 64bytes, in the beginning the system can receive and transmit packets. but after a while, the network card would not receive and transmit packets any more. 
>>then with frame size bigger than 128bytes, it worked well. the throughput was improved. (but sometimes it also has some problem just like 64bytes frames).
>>so what's the problem? is there something wrong with the driver?
>>please cc. thanks.
>>
>>
>>zhengchuanbo  
>>
>>
>>



