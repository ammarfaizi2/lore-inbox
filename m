Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbRFQPxJ>; Sun, 17 Jun 2001 11:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbRFQPw6>; Sun, 17 Jun 2001 11:52:58 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:14867 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S261309AbRFQPwv>; Sun, 17 Jun 2001 11:52:51 -0400
Message-ID: <003e01c0f745$3e0cbc40$a35812bc@corp.fedex.com>
From: "Jeff Chua" <jeffchua@silk.corp.fedex.com>
To: "Christian Robottom Reis" <kiko@async.com.br>, <eepro100@scyld.com>
Cc: <saw@saw.sw.com.sg>, <linux-kernel@vger.kernel.org>,
        "Jeff Chua" <jchua@fedex.com>
In-Reply-To: <Pine.LNX.4.32.0106162339280.191-100000@blackjesus.async.com.br>
Subject: Re: eepro100 problems with 2.2.19 _and_ 2.4.0
Date: Sun, 17 Jun 2001 23:49:41 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to add "options eepro100 options=0" to your /etc/modules.conf
to default the speed to 10Mbps if you're using 10BaseT.

add to /etc/modules.conf ...
# options=0x30 100mbps full duplex
# options=0x20 100mbps half duplex
# options=0     10mbps half duplex
options eepro100 options=0

then run "depmod -a"

Thanks,
Jeff
[ jchua@fedex.com ]
----- Original Message ----- 
From: "Christian Robottom Reis" <kiko@async.com.br>
To: <eepro100@scyld.com>
Cc: <saw@saw.sw.com.sg>; <linux-kernel@vger.kernel.org>
Sent: Sunday, June 17, 2001 10:43 AM
Subject: Re: eepro100 problems with 2.2.19 _and_ 2.4.0



Just noticed:

On Sat, 16 Jun 2001, Christian Robottom Reis wrote:

> Steps to reproduce problem:
>
> * Run large ( > 2MB works ) ftp transfer in box.
> * ssh in from another box and attempt an ls -lR /

Note below:

> * 2.2.19 with Donald's eepro100.c scyld:network/
> Hard lock (seems to take longer to hang) - it also creates
> 8 devices eth0-eth7!
>
> * 2.2.19 with Donald's eepro100.c fromscyld:network/test/
> Hard lock (pretty fast) - no multiple creation bugs

Actually, they don't hang _immediately_. They report:

eth0: Transmit timed out: status 0050  0000 at 6022/6034 commands 000c0000
000c0000 000c0000
Command 0000 was not immediately accepted, 10001 ticks!

And the ssh connection stalls but does on trying (it eventually hangs, but
not after a lot of errors are reported on the problem-box's console)

And then the box hard locks. Interesting to see that only when I run the
ssh ls -lR is that any error at all is produced. The lockups I was seeing
were all interactive use and I never really noticed if errors were showing
up or not; I just assumed they weren'.

Any help you can provide is very much appreciated. I'm about to try
Intel's drivers to see how they do.

Take care,
--
/\/\ Christian Reis, Senior Engineer, Async Open Source, Brazil
~\/~ http://async.com.br/~kiko/ | [+55 16] 274 4311

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


