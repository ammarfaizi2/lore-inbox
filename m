Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131990AbRAXEHg>; Tue, 23 Jan 2001 23:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132197AbRAXEH0>; Tue, 23 Jan 2001 23:07:26 -0500
Received: from quechua.inka.de ([212.227.14.2]:46371 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131990AbRAXEHR>;
	Tue, 23 Jan 2001 23:07:17 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Turning off ARP in linux-2.4.0 
Message-Id: <E14LHDI-00035m-00@sites.inka.de>
Date: Wed, 24 Jan 2001 05:07:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200101240027.QAA14665@tech1.nameservers.com> you wrote:
> So in the setup I have, we have an ATM which gets all incoming requests
> for the web site.  And then we have 7 other machines that get the
> requests passed onto them by the ATM.

You can hardwire the ARP entry of your redirector to your Router. In that case
the router will not ask the shared media about the Owner of the IP.

> Any ideas on how I can turn off the arping? 

why dont u use -arp as you can read it in the manual and as i written in my
post. I dont see a reason why it should not work.

Actually:


calista:/home/ecki# tcpdump -n -e -i eth0 arp &
[1] 26211
calista:/home/ecki# ping 10.0.0.7
PING 10.0.0.7 (10.0.0.7) from 10.0.0.3 : 56(84) bytes of data.
05:05:23.678782 0:0:c0:78:72:df ff:ff:ff:ff:ff:ff 0806 42: arp who-has 10.0.0.7 tell 10.0.0.3

--- 10.0.0.7 ping statistics ---
1 packets transmitted, 0 packets received, 100% packet loss
calista:/home/ecki# 
calista:/home/ecki# 05:05:24.670230 0:0:c0:78:72:df ff:ff:ff:ff:ff:ff 0806 42: arp who-has 10.0.0.7 tell 10.0.0.3

calista:/home/ecki# 05:05:25.670215 0:0:c0:78:72:df ff:ff:ff:ff:ff:ff 0806 42: arp who-has 10.0.0.7 tell 10.0.0.3

calista:/home/ecki# ifconfig eth0 -arp
calista:/home/ecki# 
calista:/home/ecki# ping 10.0.0.9
PING 10.0.0.9 (10.0.0.9) from 10.0.0.3 : 56(84) bytes of data.

--- 10.0.0.9 ping statistics ---
1 packets transmitted, 0 packets received, 100% packet loss
calista:/home/ecki# 

as you can see after using -arp my kernel will no longer issue 3 arp requests
for (not existing in my case) hosts.

And i do habe 2.4.0 with 3com ethernet.

Greetings
Bernd



> -------------------------------------------------------------------------------
>    Achtung: diese Newsgruppe ist eine unidirektional gegatete Mailingliste.
>      Antworten nur per Mail an die im Reply-To-Header angegebene Adresse.
>                    Fragen zum Gateway -> newsmaster@inka.de.
> -------------------------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
