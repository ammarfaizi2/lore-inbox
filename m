Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRKSIfS>; Mon, 19 Nov 2001 03:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRKSIfI>; Mon, 19 Nov 2001 03:35:08 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:29967 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S274862AbRKSIey>; Mon, 19 Nov 2001 03:34:54 -0500
Message-ID: <3BF8C388.3080200@yahoo.com>
Date: Mon, 19 Nov 2001 16:32:08 +0800
From: Zhongyu <xxx_pku@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Eckehardt Luhm <bselu@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Network packet drop?
In-Reply-To: <3BF8B2CC.C172F67C@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to modify the value of max_interrupt_work , like
-static int max_interrupt_work = 20
+static int max_interrupt_work = 200
maybe helpful :-)

Eckehardt Luhm wrote:

>Hello.
>
>I'm studying at the University of Karlsruhe and I'm doing some network
>measurements. In conjunction with network drivers for Linux, I'm
>experiencing very strange effects.
>
>In my setup I have two PCs each with a EEPro-100 network card in it
>connected via an X-link cable. mii-tools says they auto-negotiated a
>speed of 100baseTx-FD. Furthermore I have a program which generates UDP
>packets at the highest possible speed, simply by looping a
>sendto(socket, ...), which should block until a packet is out. What I
>want to measure is the maximum output the network card can do. So I'm
>sending n packets and divide the time needed for that by n.
>
>This works perfectly for larger packets (>500 bytes). All of them are
>being sent out. I'm able to verify this by invoking "ifconfig eth0|grep
>TX" and watch the transmitted packets grow by the number of packets I
>intended to send (in fact it grows a bit more, because of some
>ARP-packets, but that doesn't matter).
>
>But when I set the packet size to say 50 bytes (only data size without
>any headers, so on ethernet this would be 102 bytes), something strange
>is going on. Now not all of the packets I send to the other network card
>are being received. There are leaks of tens of packets at the receiver,
>I'm verifying this with tcpdump. Ok, the receiver was just overtaxed, in
>the syslog I got "eth0: Abnormal interrupt, status 00000002.". So it
>couldn't handle the flood of packets, ok.
>BUT: The sender didn't even send all of the packets! "ifconfig eth0|grep
>TX" grew only about 40-50% of the value it should! e.g. I sent 10.000
>packets, and the TX-counter grew only by 4586, not more. Sometimes I got
>even worse results, especially when decreasing the packet size.
>
>I tried several setups on different PCs, sometimes with X-linked network
>cards, sometimes with a switch between them. None of them worked. Except
>one thing: I tested the same setup described above with other network
>card, two noname products with a realtek 8139 chipset (driver module
>8139too). And you would have guessed it: That worked! The TX-counter
>grew by the correct value, so all packets have been sent out.
>
>And to make the confusion perfect: With forcing the cards to work with
>10 MBit/s-FD (with mii-tool), the same strange "packet drops" as with
>the EEPro-cards appeared.
>
>Is there anybody out there, who can explain what is going on in network
>drivers? What causes these strange effects?
>
>
>Regards, Elu
>--- Eckehardt Luhm, eMail: bselu@web.de
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>




_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

