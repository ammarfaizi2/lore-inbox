Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285636AbRLRJe1>; Tue, 18 Dec 2001 04:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285634AbRLRJeS>; Tue, 18 Dec 2001 04:34:18 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:42197 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S285633AbRLRJeD>;
	Tue, 18 Dec 2001 04:34:03 -0500
Message-ID: <F5FEAC407A690E42BD26E4F14530194229055F@esebe002.NOE.Nokia.com>
From: Mika.Liljeberg@nokia.com
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: RE: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
Date: Tue, 18 Dec 2001 11:33:51 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C187A7.1A93601E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C187A7.1A93601E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

HI again Alexey,

We had the missing FIN retransmit problem recur a few times.

> It is possible _only_ if rto is at 120 seconds. It is the only case
> when retransmissions do not happen and this would be normal =
behaviour.
>=20
> For now it is the only hypothesis and it will be clear from=20
> /proc/net/tcp, whether is this right or not.

Again, 10.0.5.11 is Linux, 10.0.5.3 is Symbian. The FIN-ACK from Linux =
to
Symbian gets dropped. Symbian retransmits the FIN, which is acked by =
Linux.
Nothing happens after this. Linux eventually times out from LAST-ACK =
and
Symbian remains stuck in FIN-WAIT-2.

The dump plus /proc/net/tcp is attached. As you can see, no data is
transferred from Linux to Symbian, so the only RTT sample for Linux =
comes
from the SYN exchange (about 200 ms). So, something is wrong?

Cheers,

	MikaL

----------------------------------------------------------------
Mika Liljeberg            Phone:  +358 5048 36791
Nokia Research Center     Fax:    +358 7180 36850
P.O.Box 407               Email:  mika.liljeberg@nokia.com
FIN-00045 NOKIA GROUP     Office: It=E4merenkatu 11-13,
Finland                           FIN-00180, Helsinki, Finland
----------------------------------------------------------------



------_=_NextPart_000_01C187A7.1A93601E
Content-Type: text/plain;
	name="remote.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="remote.txt"


11:28:24.313303 10.0.5.3.3866 > 10.0.5.11.1545: S [tcp sum ok] =
550414008:550414008(0) win 7300 <mss 1460,timestamp 3412683347 =
0,sackOK> (DF) (ttl 63, id 8156, len 56)
11:28:24.313344 10.0.5.11.1545 > 10.0.5.3.3866: S [tcp sum ok] =
1891446655:1891446655(0) ack 550414009 win 5792 <mss =
1460,sackOK,timestamp 8851207 3412683347> (DF) (ttl 64, id 0, len 56)
11:28:24.518049 10.0.5.3.3866 > 10.0.5.11.1545: . [tcp sum ok] 1:1(0) =
ack 1 win 7300 <timestamp 3412902097 8851207,eol> (DF) (ttl 63, id =
8157, len 52)
11:28:24.532032 10.0.5.3.3866 > 10.0.5.11.1545: . 257:1705(1448) ack 1 =
win 7300 <timestamp 3412902097 8851207,eol> (DF) (ttl 63, id 8159, len =
1500)
11:28:24.532080 10.0.5.11.1545 > 10.0.5.3.3866: . [tcp sum ok] 1:1(0) =
ack 1 win 5792 <nop,nop,timestamp 8851229 3412902097,nop,nop,sack sack =
1 {257:1705} > (DF) (ttl 64, id 8348, len 64)
11:28:24.539958 10.0.5.3.3866 > 10.0.5.11.1545: . 1705:3153(1448) ack 1 =
win 7300 <timestamp 3412917722 8851207,eol> (DF) (ttl 63, id 8160, len =
1500)
11:28:24.540008 10.0.5.11.1545 > 10.0.5.3.3866: . [tcp sum ok] 1:1(0) =
ack 1 win 5792 <nop,nop,timestamp 8851230 3412902097,nop,nop,sack sack =
1 {257:3153} > (DF) (ttl 64, id 8349, len 64)
11:28:24.747778 10.0.5.3.3866 > 10.0.5.11.1545: . 3153:4601(1448) ack 1 =
win 7300 <timestamp 3413120847 8851207,eol> (DF) (ttl 63, id 8161, len =
1500)
11:28:24.747828 10.0.5.11.1545 > 10.0.5.3.3866: . [tcp sum ok] 1:1(0) =
ack 1 win 5792 <nop,nop,timestamp 8851250 3412902097,nop,nop,sack sack =
1 {257:4601} > (DF) (ttl 64, id 8350, len 64)
11:28:24.954233 10.0.5.3.3866 > 10.0.5.11.1545: P 1:257(256) ack 1 win =
7300 <timestamp 3413323972 8851207,eol> (DF) (ttl 63, id 8162, len 308)
11:28:24.954289 10.0.5.11.1545 > 10.0.5.3.3866: . [tcp sum ok] 1:1(0) =
ack 4601 win 6432 <nop,nop,timestamp 8851271 3413323972> (DF) (ttl 64, =
id 8351, len 52)
11:28:25.164591 10.0.5.3.3866 > 10.0.5.11.1545: . 4601:6049(1448) ack 1 =
win 7300 <timestamp 3413542722 8851207,eol> (DF) (ttl 63, id 8163, len =
1500)
11:28:25.164642 10.0.5.11.1545 > 10.0.5.3.3866: . [tcp sum ok] 1:1(0) =
ack 6049 win 8688 <nop,nop,timestamp 8851292 3413542722> (DF) (ttl 64, =
id 8352, len 52)
11:28:25.167478 10.0.5.3.3866 > 10.0.5.11.1545: . 6049:7497(1448) ack 1 =
win 7300 <timestamp 3413542723 8851207,eol> (DF) (ttl 63, id 8164, len =
1500)
11:28:25.167530 10.0.5.11.1545 > 10.0.5.3.3866: . [tcp sum ok] 1:1(0) =
ack 7497 win 11584 <nop,nop,timestamp 8851292 3413542723> (DF) (ttl 64, =
id 8353, len 52)
11:28:48.030264 10.0.5.3.3866 > 10.0.5.11.1545: . 498345:499793(1448) =
ack 1 win 7300 <timestamp 3436402097 8851207,eol> (DF) (ttl 63, id =
8581, len 1500)
11:28:48.030318 10.0.5.11.1545 > 10.0.5.3.3866: . [tcp sum ok] 1:1(0) =
ack 501241 win 65160 <nop,nop,timestamp 8853579 3436402097,nop,nop,sack =
sack 1 {502689:508577} > (DF) (ttl 64, id 8714, len 64)
11:28:48.033323 10.0.5.3.3866 > 10.0.5.11.1545: . 501241:502689(1448) =
ack 1 win 7300 <timestamp 3436402098 8851207,eol> (DF) (ttl 63, id =
8582, len 1500)
11:28:48.033376 10.0.5.11.1545 > 10.0.5.3.3866: . [tcp sum ok] 1:1(0) =
ack 508577 win 65160 <nop,nop,timestamp 8853579 3436402098> (DF) (ttl =
64, id 8715, len 52)
11:28:48.037908 10.0.5.3.3866 > 10.0.5.11.1545: . 508577:510025(1448) =
ack 1 win 7300 <timestamp 3436417722 8851207,eol> (DF) (ttl 63, id =
8583, len 1500)
11:28:48.037974 10.0.5.11.1545 > 10.0.5.3.3866: . [tcp sum ok] 1:1(0) =
ack 510025 win 65160 <nop,nop,timestamp 8853580 3436417722> (DF) (ttl =
64, id 8716, len 52)
11:28:48.246533 10.0.5.3.3866 > 10.0.5.11.1545: . 510025:511473(1448) =
ack 1 win 7300 <timestamp 3436620847 8851207,eol> (DF) (ttl 63, id =
8584, len 1500)
11:28:48.246570 10.0.5.11.1545 > 10.0.5.3.3866: . [tcp sum ok] 1:1(0) =
ack 511473 win 65160 <nop,nop,timestamp 8853600 3436620847> (DF) (ttl =
64, id 8717, len 52)
11:28:48.247274 10.0.5.3.3866 > 10.0.5.11.1545: FP 511473:512001(528) =
ack 1 win 7300 <timestamp 3436620848 8851207,eol> (DF) (ttl 63, id =
8585, len 580)
11:28:48.247337 10.0.5.11.1545 > 10.0.5.3.3866: F [tcp sum ok] 1:1(0) =
ack 512002 win 65160 <nop,nop,timestamp 8853600 3436620848> (DF) (ttl =
64, id 8718, len 52)
11:28:49.454437 10.0.5.3.3866 > 10.0.5.11.1545: FP 511473:512001(528) =
ack 1 win 7300 <timestamp 3437839597 8851207,eol> (DF) (ttl 63, id =
8587, len 580)
11:28:49.454468 10.0.5.11.1545 > 10.0.5.3.3866: . [tcp sum ok] 2:2(0) =
ack 512002 win 65160 <nop,nop,timestamp 8853721 3437839597,nop,nop,sack =
sack 1 {511473:512002} > (DF) (ttl 64, id 8719, len 64)

------_=_NextPart_000_01C187A7.1A93601E
Content-Type: text/plain;
	name="proc.net.tcp.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc.net.tcp.txt"

  sl  local_address rem_address   st tx_queue rx_queue tr tm->when =
retrnsmt   uid  timeout inode                                           =
          =0A=
   0: 00000000:3241 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000  1001        0 2246 1 c70e5b60 300 0 0 2 -1                    =
          =0A=
   1: 00000000:0203 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 205 1 c789c460 300 0 0 2 -1                     =
          =0A=
   2: 00000000:0025 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 183 1 c7a5b7c0 300 0 0 2 -1                     =
          =0A=
   3: 00000000:05E8 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000  1001        0 12119 1 c4da4b80 300 0 0 2 -1                   =
          =0A=
   4: 00000000:05E9 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000  1001        0 12120 1 c4da40a0 300 0 0 2 -1                   =
          =0A=
   5: 00000000:0009 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 180 1 c7f7a400 300 0 0 2 -1                     =
          =0A=
   6: 00000000:05EB 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 9381 1 c70e5080 300 0 0 2 -1                    =
          =0A=
   7: 00000000:05EC 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000  1001        0 12122 1 c4da4440 300 0 0 2 -1                   =
          =0A=
   8: 00000000:4E2C 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 191 1 c79e3b80 300 0 0 2 -1                     =
          =0A=
   9: 00000000:05ED 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000  1001        0 12123 1 c7f0c0c0 300 0 0 2 -1                   =
          =0A=
  10: 00000000:000D 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 182 1 c7a5b420 300 0 0 2 -1                     =
          =0A=
  11: 00000000:05EF 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000  1001        0 12126 1 c5efc420 300 0 0 2 -1                   =
          =0A=
  12: 00000000:004F 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 186 1 c79e3440 300 0 0 2 -1                     =
          =0A=
  13: 00000000:05F0 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000  1001        0 12127 1 c5efc080 300 0 0 2 -1                   =
          =0A=
  14: 00000000:1770 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 485 1 c6ecebe0 300 0 0 2 -1                     =
          =0A=
  15: 00000000:0050 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 474 1 c6ece840 300 0 0 2 -1                     =
          =0A=
  16: 00000000:0071 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 187 1 c79e37e0 300 0 0 2 -1                     =
          =0A=
  17: 00000000:0015 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 184 1 c7a5bb60 300 0 0 2 -1                     =
          =0A=
  19: 00000000:0017 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 185 1 c79e30a0 300 0 0 2 -1                     =
          =0A=
  20: 00000000:1F98 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 384 1 c7734820 300 0 0 2 -1                     =
          =0A=
  21: 00000000:0019 00000000:0000 0A 00000000:00000000 00:00000000 =
00000000     0        0 387 1 c7734bc0 300 0 0 2 -1                     =
          =0A=
  22: 0105000A:05F5 0205000A:0546 01 00000000:00000000 00:00000000 =
00000000     0        0 12148 1 c12804a0 21 4 27 3 -1                   =
          =0A=
  23: 0105000A:05F4 0205000A:0544 01 00000000:00000000 00:00000000 =
00000000     0        0 12147 1 c5c0e0e0 21 4 8 2 -1                    =
          =0A=
  24: 0B05000A:0609 0305000A:0F1A 09 00000001:00000000 01:000010AE =
00000000     0        0 0 2 c60023e0 12000 4 30 2 -1                    =
          =0A=
  25: 0105000A:05EB 0105000A:05F1 01 00000000:00000000 00:00000000 =
00000000     0        0 12129 1 c5efcb60 21 0 0 2 -1                    =
          =0A=
  26: 0105000A:05F3 0105000A:05F0 01 00000000:00000000 00:00000000 =
00000000     0        0 12131 1 c365b060 21 0 0 2 -1                    =
          =0A=
  27: 0105000A:05F0 0105000A:05F3 01 00000000:00000000 00:00000000 =
00000000  1001        0 12141 1 c1280840 21 4 10 2 -1                   =
          =0A=
  28: 0105000A:05ED 0205000A:0540 01 00000000:00000000 00:00000000 =
00000000  1001        0 12143 1 c1280be0 21 0 0 2 -1                    =
          =0A=
  29: 0105000A:05EF 0105000A:05F2 01 00000000:00000000 00:00000000 =
00000000  1001        0 12139 1 c365b400 21 0 0 2 -1                    =
          =0A=
  30: 0105000A:05E9 0205000A:053E 01 00000000:00000000 00:00000000 =
00000000  1001        0 12135 1 c365bb40 21 4 26 2 -1                   =
          =0A=
  31: 0105000A:05EC 0205000A:053F 01 00000000:00000000 00:00000000 =
00000000  1001        0 12137 1 c1280100 21 4 4 2 -1                    =
          =0A=
  32: 0105000A:05F2 0105000A:05EF 01 00000000:00000000 00:00000000 =
00000000     0        0 12130 1 c365b7a0 21 0 0 2 -1                    =
          =0A=
  33: 0105000A:05EB 0105000A:05EE 01 00000000:00000000 00:00000000 =
00000000     0        0 12125 1 c7f0c800 21 4 21 2 -1                   =
          =0A=
  34: 0105000A:05E8 0205000A:053D 01 00000000:00000000 00:00000000 =
00000000  1001        0 12133 1 c7f0c460 21 0 0 2 -1                    =
          =0A=
  35: 0105000A:05EA 0205000A:05EB 01 00000000:00000000 00:00000000 =
00000000  1001        0 12121 1 c4da47e0 21 4 0 3 -1                    =
          =0A=
  36: 0105000A:05E6 0205000A:05EB 01 00000000:00000000 00:00000000 =
00000000  1001        0 12117 1 c219c800 21 0 0 2 -1                    =
          =0A=
  37: 0105000A:05E7 0205000A:05EB 01 00000000:00000000 00:00000000 =
00000000  1001        0 12118 1 c55aa160 21 4 8 2 -1                    =
          =0A=
  38: 0B05000A:3241 0305000A:0F07 01 00000000:00000000 00:00000000 =
00000000  1001        0 12181 1 c6002780 71 4 11 2 2                    =
          =0A=
  39: 0105000A:05EE 0105000A:05EB 01 00000000:00000000 00:00000000 =
00000000  1001        0 12124 1 c7f0cba0 21 4 18 2 -1                   =
          =0A=
  40: 0105000A:05F1 0105000A:05EB 01 00000000:00000000 00:00000000 =
00000000  1001        0 12128 1 c5efc7c0 21 0 0 2 -1                    =
          =0A=

------_=_NextPart_000_01C187A7.1A93601E--
