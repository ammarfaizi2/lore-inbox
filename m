Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274001AbRI3T3Q>; Sun, 30 Sep 2001 15:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274002AbRI3T24>; Sun, 30 Sep 2001 15:28:56 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:62363 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S274001AbRI3T2u>;
	Sun, 30 Sep 2001 15:28:50 -0400
Message-ID: <3BB7728D.A691A9FB@candelatech.com>
Date: Sun, 30 Sep 2001 12:29:17 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Belinda <belinda_ye@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: inb() and outb()
In-Reply-To: <20010930190954.18227.qmail@web13904.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Belinda wrote:
> 
> Hi, all
> 
> I wrote a simple program with inb() and outb().
> However, it reports the segmentation error when
> running it.
> 
> The code follows as:
> ---------------------------------
> #include <asm/io.h>
> 
> #define LPT 0x378
>    

You need to add something like this in your main method before
calling write_LPT.

See 'man ioperm' for more info..

if (ioperm(LPT, 3, 1)) {
      printf("Sorry, you were not able to gain access to the ports\n");
      printf("You must be root to run this program\n");
      exit(1);
}


> void write_LPT(unsigned char byte)
> {
>     outb(byte, LPT);
> }
> 
> int main()
> {
>    write_LPT(LPT);
>    printf("Value:%c", inb(LPT));
> 
> }
> ------------------------------------------------------
> 
> Thanks,
> 
> Belinda
> 
> __________________________________________________
> Do You Yahoo!?
> Listen to your Yahoo! Mail messages from any phone.
> http://phone.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
