Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129428AbQKXRbC>; Fri, 24 Nov 2000 12:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129735AbQKXRaw>; Fri, 24 Nov 2000 12:30:52 -0500
Received: from inetgw.eproduction.ch ([212.249.19.98]:32248 "EHLO
        zh1sernt102.eproduction.ch") by vger.kernel.org with ESMTP
        id <S129428AbQKXRai>; Fri, 24 Nov 2000 12:30:38 -0500
Message-ID: <5085C686246FD411817A00D0B73EBB2509F057@exchange.intern.eproduction.ch>
From: "Rüegg, Peter H." 
        <pruegg@eproduction.ch>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Strange IP-Connection
Date: Fri, 24 Nov 2000 18:10:05 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
        charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I encounter quite a lot of strange connection on a very busy server
here.
tcpdump -S -n on the firewall in front of it reports as follows:

16:13:03.531896 eth0 > 193.8.109.35.4870 > 212.27.173.35.www: S
1693092819:1693092819(0) win 16384 <mss 512,nop,wscale
0,nop,nop,timestamp 546156 0,nop,nop,ccnew 1576036>
16:13:03.532069 eth0 < 212.27.173.35.www > 193.8.109.35.4870: S
2207402096:2207402096(0) ack 1693092820 win 32256 <mss
512,nop,nop,timestamp 568942 546156,nop,wscale 0> (DF)
16:13:03.598989 eth0 > 193.8.109.35.4870 > 212.27.173.35.www: .
1693092820:1693092820(0) ack 2207402097 win 16384 <nop,nop,timestamp
546156 568942>
16:13:03.610774 eth0 > 193.8.109.35.4870 > 212.27.173.35.www: .
1693092820:1693093320(500) ack 2207402097 win 16384
<nop,nop,timestamp 546156 568942>
16:13:03.611024 eth0 < 212.27.173.35.www > 193.8.109.35.4870: .
2207402097:2207402097(0) ack 1693093320 win 31756 <nop,nop,timestamp
568950 546156> (DF)
16:13:03.611466 eth0 > 193.8.109.35.4870 > 212.27.173.35.www: P
1693093320:1693093368(48) ack 2207402097 win 16384 <nop,nop,timestamp
546156 568942>
16:13:03.612058 eth0 < 212.27.173.35.www > 193.8.109.35.4870: P
2207402097:2207402239(142) ack 1693093368 win 32500
<nop,nop,timestamp 568950 546156> (DF)
16:13:03.612189 eth0 < 212.27.173.35.www > 193.8.109.35.4870: F
2207402239:2207402239(0) ack 1693093368 win 32500 <nop,nop,timestamp
568950 546156> (DF)
16:13:03.689108 eth0 > 193.8.109.35.4870 > 212.27.173.35.www: .
1693093368:1693093368(0) ack 2207402240 win 16242 <nop,nop,timestamp
546157 568950>
16:13:03.689305 eth0 > 193.8.109.35.4870 > 212.27.173.35.www: F
1693093368:1693093368(0) ack 2207402240 win 16384 <nop,nop,timestamp
546157 568950>
16:13:03.689468 eth0 < 212.27.173.35.www > 193.8.109.35.4870: .
2207402240:2207402240(0) ack 1693093369 win 32500 <nop,nop,timestamp
568958 546157> (DF)
16:13:05.661668 eth0 > 193.8.109.35.4870 > 212.27.173.35.www: F
1693093368:1693093368(0) ack 2207402240 win 16384 <nop,nop,timestamp
546160 568950>
16:13:05.661807 eth0 < 212.27.173.35.www > 193.8.109.35.4870: .
4821635:4821635(0) ack 4186827364 win 32500
16:13:05.737763 eth0 > 193.8.109.35.4870 > 212.27.173.35.www: F
1693093368:1693093368(0) ack 2207402240 win 16384 <nop,nop,timestamp
546161 568950>
16:13:05.737914 eth0 < 212.27.173.35.www > 193.8.109.35.4870: .
4821635:4821635(0) ack 4186827364 win 32500
16:13:05.808887 eth0 > 193.8.109.35.4870 > 212.27.173.35.www: F
1693093368:1693093368(0) ack 2207402240 win 16384 <nop,nop,timestamp
546161 568950>
16:13:05.809077 eth0 < 212.27.173.35.www > 193.8.109.35.4870: .
4821635:4821635(0) ack 4186827364 win 32500
16:13:05.870439 eth0 > 193.8.109.35.4870 > 212.27.173.35.www: F
1693093368:1693093368(0) ack 2207402240 win 16384 <nop,nop,timestamp
546161 568950>
16:13:05.870607 eth0 < 212.27.173.35.www > 193.8.109.35.4870: .
4821635:4821635(0) ack 4186827364 win 32500

followed by approximately 1000 repetitions of the last two lines.

My questions are:

   a) Why does the server acknowledge 1693093368, which is wrong, as
it
      should be one higher.
   b) After finally admitting that 1693093369 should be the correct
value
      to send it doesn't Accept the FIN.
   c) And why on earth does the server come up with a completely
different
      connection shortafter?

As said before, this is a very busy machine. The Kernel is 2.2.16
with
the Openwall patches appended. The networkcard is a eepro100, dmesg
reports
"eth0: OEM i82557/i82558 10/100 Ethernet, Board assembly 735190-002,
primary interface chip i82555 PHY #1, ROM checksum self-test passed,
eepro100.c:v1.09j-t 9/29/99 Donald Becker, $Revision: 1.20.2.10 $
2000/05/31"
etc.

The same machine sometimes complains about "Could not fetch RX buffer
(force
0)" or "force 1", so it may be a Hardware-Problem.

I have tcp_syncookies enabled, which may be part of the problem.

The problem seems to happen with quite a lot of machines out there,
of which
I have good reasons to attempt, that their IP isn't spoofed. What
connects
all of them, is that they have a pretty fast connection to us.


Does anyone have an idea, what the problem could be?

Thanks a lot - I will have a look at the source myself, as soon as
I find the time to.

Greets

Peter H. Ruegg
Systems-/Networkadministrator eProduction AG

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use <http://www.pgp.com>

iQA/AwUBOh6Rilcv4X0c4GKrEQLm3ACgsZa98dDQOYdtDoUaXC8oliTexGEAoITh
1EVOdXZoEoaomtANTnlp0Lkr
=MntP
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
