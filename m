Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266911AbRGHQID>; Sun, 8 Jul 2001 12:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266912AbRGHQHx>; Sun, 8 Jul 2001 12:07:53 -0400
Received: from wretched.demon.co.uk ([193.237.109.203]:25102 "EHLO
	linux1.wretched.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266911AbRGHQHm>; Sun, 8 Jul 2001 12:07:42 -0400
Message-ID: <3B48829E.1975F8E4@wretched.demon.co.uk>
Date: Sun, 08 Jul 2001 16:56:14 +0100
From: Simon Waters <Simon@wretched.demon.co.uk>
Reply-To: Simon@wretched.demon.co.uk
Organization: Eighth Layer Limited
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IP DoS on 2.2.17
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please excuse a post from a non-member, but this seems the
most suitable place I could find. Please e-mail me any
thoughts, and I'll summarise if I make any progress.

I am getting some sort of IP DoS (Side effect of a Port
scan), and am trying to unpick the cause (Other than nasty
hackers).

The symptom is that after a specific type of scan (ipchain
logs below), and 4 packets logged on port 111, the machine
loses the ability to send "outgoing" packets (both UDP and
TCP). PLOAD shows a dimishing dribble of incoming packets,
presumably the remains of the scan, plus the odd attempt to
send me something useful.

The only way to reset this (short of a reboot) is to take
down the PPP interface, by killing ppp watch (NB "ifdown
ppp0" results in ppp-watch restarting the Interface, but the
ISDN never connects successfully?!?), ifdown ppp0, rmmod -a
(Takes out down to and including slhc in list below, I
haven't yet tried stepping through the modules to see which
one is confused).


What is best way to proceed - assuming I want to understand
what is happening rather than just lock everything down (I'd
prefer to do both of course)?

Should I upgrade to 2.2.19 and hope it goes away (I'll
probably do this anyway, but reading release notes I'm not
immediately struck by anything obvious)?

Any one any idea on the scanner in use? If I could reproduce
the problem at will I'd be in a better position to analyse
what is happening.

I don't understand why I am the only one seeing this (I
found some promising references, only to find they were many
kernel revisions out of date) - it is a very infrequent
problem (Despite seeing scans against port 111 every few
hours, I've only seen this problem a handful of times).

Maybe others just assume it is yet another ISP problem and
reboot?!, but the ability to only get incoming packets is
rather distinctive (Although I only spotted this as I
happened to have pload running).

As a temporary supplement to security I've stuck in
"iptrap", with a custom script, which mails me, and then
kills all traffic between my box, and anyone creating
unauthorised TCP connections to well known services
(Including 111), but this hasn't cured the issue (So maybe
it isn't the port 111 part of the scan!?), although I
blacklisted three wannabe hackers last night.

Jul  7 18:48:26 linux1 kernel: Packet log: input DENY ppp0
PROTO=6 211.250.197.2:3024 193.237.109.203:111 L=60 S=0x00
I=14018 F=0x4000 T=43 SYN (#3)
Jul  7 18:48:26 linux1 kernel: Packet log: input DENY ppp0
PROTO=6 211.250.197.2:3024 193.237.109.203:111 L=60 S=0x00
I=14018 F=0x4000 T=43 SYN (#3)
Jul  7 18:48:29 linux1 kernel: Packet log: input DENY ppp0
PROTO=6 211.250.197.2:3024 193.237.109.203:111 L=60 S=0x00
I=15081 F=0x4000 T=43 SYN (#3)
Jul  7 18:48:29 linux1 kernel: Packet log: input DENY ppp0
PROTO=6 211.250.197.2:3024 193.237.109.203:111 L=60 S=0x00
I=15081 F=0x4000 T=43 SYN (#3)

Portmapper isn't running, nor any of the known "problem"
Redhat services, inetd.conf has one line "imap", Postfix
supplies SMTP (Which is usually good at logging odd
activity), and ipchains filters the other services which
refuse to be bound to Internal interfaces only. TCP wrappers
is also in there somewhere telling some wrapper aware
programs who to trust.

Masquerading is enabled, but no masqueraded machines are
powered on overnight when this seems to occur most often.

Linux box, based on Redhat 6.1, later upgraded to 7.0.
It runs Kernel 2.2.17, ipchains 1.3.9, ppp-2.3.11-7, BT
Speedway ISDN card (Hence hisax driver).

 lsmod
Module                  Size  Used by
ppp_deflate            40852   0  (autoclean)
bsd_comp                3884   0  (autoclean)
hisax                 143816   1  (autoclean)
isdn                  111596   1  (autoclean) [hisax]
ppp                    20140   2  (autoclean) [ppp_deflate
bsd_comp]
slhc                    4440   1  (autoclean) [isdn ppp]
rtl8139                12416   1  (autoclean)
wvlan_cs               23616   1
ds                      6280   2  [wvlan_cs]
i82365                 21984   2
pcmcia_core            44512   0  [wvlan_cs ds i82365]
cmpci                  22124   0
soundcore               2372   4  [cmpci]

As yet no evidence of any successful intrusion, but I'm
trying to run some interesting software for which a really
solid Internet connection would be useful.

	Simon
-- 
Are you using the Internet to best effect ?
www.eighth-layer.com
Tel: +44(0)1395 232769      ICQ: 116952768
Moderated discussion of teleworking at
news:uk.business.telework
