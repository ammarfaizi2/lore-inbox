Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315263AbSEFXpe>; Mon, 6 May 2002 19:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315264AbSEFXpd>; Mon, 6 May 2002 19:45:33 -0400
Received: from 106-MAD2-X31.libre.retevision.es ([62.83.131.106]:386 "EHLO
	TaNGa") by vger.kernel.org with ESMTP id <S315263AbSEFXpc>;
	Mon, 6 May 2002 19:45:32 -0400
Subject: little problem with nat , resending packets to wrong destination.
From: bladi <bladi@euskalnet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 07 May 2002 09:41:37 +0200
Message-Id: <1020757298.1962.153.camel@TaNGa>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi the last day a notice a extrange thing with my packetsniffer one host
recive a packet that i request from the linux "router"


Network:


-----ppp0 modem-- [Linux router]eth0------[Honneypot]---

			192.168.1.2	  192.168.1.56

i have 2 rules  in iptables

iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE
iptables -t nat -A PREROUTING --in-interface ppp0 --protocol tcp
--destination-port ! ssh --jump DNAT --to-destination 192.168.1.5

I usaly use the linux router to work and the  honneypot to fun & profit.

i always exeute  tcpdump -i eth0 -s 9000 -w LOGFILE  on the router
machine.

The last day when im making a revision of the log , i discover that in
the log i could raead a "response" of an http request  that i do from
router linux ( i make a the request  to external site over ppp
connection).

|---|
unfornatly i only have the snoop of the ppp0 interface.

80.34.69.xxx = external server


1) i make http request to 80.34.69.xxx server
2) i read the web contents correctly
3) aparently the kernel forward the response to 192.168.1.56 (honeypot)



#tcpdump  -r JAULA6 -n 'tcp port 80 && host 80.34.69.xxx'

03:28:03.303637 80.34.69.xxx.80 > 192.168.1.56.33352: .
3888813151:3888814599(1448) ack 2877177511 win 6710 <nop,nop,timestamp
110497018 7927497> (DF)
03:28:03.304382 192.168.1.56.33352 > 80.34.69.xxx.80: R
2877177511:2877177511(0) win 0

#tcpdump  -r JAULA6 -n 'tcp port 3000 && host 80.34.69.xxx'


03:17:04.803886 80.34.69.xxx.3000 > 192.168.1.56.33329: P
3209289308:3209289324(16) ack 2224478666 win 6720 <nop,nop,timestamp
110431569 7862787> (DF)
03:17:04.804585 192.168.1.56.33329 > 80.34.69.xxx.3000: R
2224478666:2224478666(0) win 0

In the 2 case the honneypot respond with rst because he dont start the
conexion.


This happend rarely only 2 times in 1 day :|



Bye!

















