Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130841AbRBQTn3>; Sat, 17 Feb 2001 14:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130678AbRBQTnT>; Sat, 17 Feb 2001 14:43:19 -0500
Received: from mail2.rdc2.bc.home.com ([24.2.10.85]:50599 "EHLO
	mail2.rdc2.bc.home.com") by vger.kernel.org with ESMTP
	id <S129489AbRBQTnR>; Sat, 17 Feb 2001 14:43:17 -0500
To: stefan@hanse.com
Cc: linux-kernel@vger.kernel.org
From: jbinpg@home.com
Subject: re. too long mac address for --mac-source netfilter option
X-Mailer: Gmail 0.6.8 (http://gmail.linuxpower.org)
Message-Id: <20010217194308.GKTJ585.mail2.rdc2.bc.home.com@nonesuch.localdomain>
Date: Sat, 17 Feb 2001 11:43:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jack  Bowling wrote -

>> I am trying to use the --mac-source option in the netfilter code to better refine access to my linux box. However, I > have run up against something. The router through which my private subnet work box passes sends a 14-group "invalid" > mac address, presumably as an attempt to conceal the real hextile mac address. However, the code for the > --mac-source netfilter option is looking for a valid hextile mac address and complains loudly as such (numerals converted to x's):
>> 
>> iptables v1.1.1: Bad mac address `xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx'
>> 
>> to the respective iptable line:
>> 
>> $IPT -A INPUT -p tcp -s xxx.xxx.xxx.xxx -d $NET -m mac --mac-source xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx --dport 5900:5901 -j ACCEPT
>> 
>> The idea here is to allow VNC access to my home box with the access filtered by both IP and mac address.
>> 
>> Is there a resolution to this other than a rewrite and recompile of the relevant sections of the iptable code? Or am I stuck? I know this option is tagged by Rusty as experimental still so I would assume that the code is open for feedback ;) The question could be rephrased as: is there any chance of allowing "invalid" mac addresses to be recognized by the --mac-source option of the netfilter code? Running Redhat v7/kernel 2.4.1-ac15.

Stefan Hanse writes -

>Umm..  An ethernet MAC address is 48bit long, ie AA:BB:CC:DD:EE:FF, 6 groups, not 14. Is this really an ethernet
>interface? (If it really has 14 groups).

Good question. I have determined by scanning my firewall logs that the "invalid" mac addresses are all coming from cable modem routers. And my linux kernel is recognizing them as being MAC addresses. Would it be better to write another module looking for these long "MAC"  rather than tamper with the mac module? 

To illustrate, here is a cut from my system log showing a portscan from my cable modem provider (a routine part of their service contract since you are not allowed to run client-side servers). SRC and DST have been x'ed out:

Feb 17 08:49:42 nonesuch kernel: IN=eth0 OUT= MAC=00:01:02:69:49:4f:00:00:77:93:83:d2:08:00 SRC=xx.xx.xx.xx DST=xx.xx.xx.xx LEN=44 TOS=0x00 PREC=0x00 TTL=246 ID=21419 PROTO=TCP SPT=45435 DPT=119 WINDOW=8760 RES=0x00 SYN URGP=0 
Feb 17 08:49:43 nonesuch kernel: IN=eth0 OUT= MAC=00:01:02:69:49:4f:00:00:77:93:83:d2:08:00 SRC=xx.xx.xx.xx DST=xx.xx.xx.xx LEN=40 TOS=0x00 PREC=0x00 TTL=246 ID=21420 PROTO=TCP SPT=45435 DPT=119 WINDOW=8760 RES=0x00 RST URGP=0 
Feb 17 08:49:43 nonesuch kernel: IN=eth0 OUT= MAC=00:01:02:69:49:4f:00:00:77:93:83:d2:08:00 SRC=xx.xx.xx.xx DST=xx.xx.xx.xx LEN=44 TOS=0x00 PREC=0x00 TTL=246 ID=21421 PROTO=TCP SPT=45806 DPT=119 WINDOW=8760 RES=0x00 SYN URGP=0 
Feb 17 08:49:43 nonesuch kernel: IN=eth0 OUT= MAC=00:01:02:69:49:4f:00:00:77:93:83:d2:08:00 SRC=xx.xx.xx.xx DST=xx.xx.xx.xx LEN=40 TOS=0x00 PREC=0x00 TTL=246 ID=21422 PROTO=TCP SPT=45806 DPT=119 WINDOW=8760 RES=0x00 RST URGP=0 
Feb 17 08:49:43 nonesuch kernel: IN=eth0 OUT= MAC=00:01:02:69:49:4f:00:00:77:93:83:d2:08:00 SRC=xx.xx.xx.xx DST=xx.xx.xx.xx LEN=44 TOS=0x00 PREC=0x00 TTL=246 ID=21423 PROTO=TCP SPT=46248 DPT=119 WINDOW=8760 RES=0x00 SYN URGP=0 
Feb 17 08:49:44 nonesuch kernel: IN=eth0 OUT= MAC=00:01:02:69:49:4f:00:00:77:93:83:d2:08:00 SRC=xx.xx.xx.xx DST=xx.xx.xx.xx LEN=40 TOS=0x00 PREC=0x00 TTL=246 ID=21424 PROTO=TCP SPT=46248 DPT=119 WINDOW=8760 RES=0x00 RST URGP=0 

All hits on my firewall from cable modem servers other than my own provider also have the 14 group "MAC" address so it looks like this may be a feature of these units.

Jack

P.S. - I have moved this to another of my email accounts



