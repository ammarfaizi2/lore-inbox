Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132127AbRDJVWW>; Tue, 10 Apr 2001 17:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132220AbRDJVWM>; Tue, 10 Apr 2001 17:22:12 -0400
Received: from mail.mediatrix.com ([205.237.248.11]:32016 "EHLO
	mail.mediatrix.com") by vger.kernel.org with ESMTP
	id <S132127AbRDJVWD>; Tue, 10 Apr 2001 17:22:03 -0400
Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4D414A49@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: linux-kernel@vger.kernel.org
Subject: Patch for arch/ppc/8xx_io/fec.c
Date: Tue, 10 Apr 2001 17:18:50 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C0C203.D67DE840"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C0C203.D67DE840
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello.

I've attached to this mail a patch for the FEC driver
on the Motorola MPC8xx embedded CPU.

This patch includes both a bug fix, and a new PHYter implementation.

 Symptom
---------
I was experiencing problems of "transmission timeout" when heavily
loading the network (throughput tests), particularly when the board
was wired to a 10MBits link (but I could also reproduce it on 100Mbits
using the packet sockets). The user process was then "held" by the IP
stack, I had no choice but to kill it.

 Bug description
-----------------
When, in rare cases, the ring buffer became full, the driver was =
stopping
the network queue, which is OK. But, it did not set a flag to restart
the queue in the transmission interrupt service routine.

 Bug fix
---------
I only had to set this flag, at the same time the network queue was =
stopped
(already wrapped in a spin lock).


Supplement:
 PHYter implementation
-----------------------
My board uses the NS chip model DP83843BVJE, for which I filled out the
needed structures.
However, I could not test the PHYter interrupt since it is not wired to =
the
PPC on our board
(but it is enabled in this patch). I had to code a polling routine (not
included in this patch).

It might be a good idea to move all these implementations outside of
"fec.c".
It might be also useful to choose the supported models through the =
kernel
configuration.
Perhaps I will work on that during the next weeks...

By the way, who is maintaining that part (MPC8xx, MPC82xx) of the =
kernel?


 Other issue=20
-------------
I have another problem I will have to address. I'm experiencing a =
strange
behaviour
in the response time when I 'ping flood' my board.

Through the 10Mbits, everything works fine, the average response time =
is
468us,
with realist minimum and maximum values.

  > round-trip min/avg/max/mdev =3D 0.458/0.468/0.600/0.029 ms

But, through the 100Mbits, the response time ranges from 0.26ms to =
10ms,
and an average of about 5ms, always different from test to test.

  > round-trip min/avg/max/mdev =3D 0.265/6.764/10.311/4.512 ms

Strangely, the board is not running anything but bash.
If a start 'top' with a refresh period of 1 second, I get a lower =
average,
but still the same min and max.

  > round-trip min/avg/max/mdev =3D 0.264/0.583/10.018/1.421 ms

If I start an NFS copy of a big file, the maximum gets down to 2ms.


The maximum of 10ms sounds like the timer tick.
Since it is working well in 10Mbps and not in 100Mbps,
can I suspect a problem with the Ethernet driver?


Thank you for your time.

--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Qu=E9bec)
 J1L 2C8  CANADA
--------------------------------------------


------_=_NextPart_000_01C0C203.D67DE840
Content-Type: application/octet-stream;
	name="ppc.8xx_io.fec.c.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="ppc.8xx_io.fec.c.patch.gz"

H4sICLtV0zoAA3BwYy44eHhfaW8uZmVjLmMucGF0Y2gArVbhbtpIEP4NTzHqSRHBBmwgTZpeq9CE
pFybNIe5U6uqssx6DdsY291dA1Eu9+w3syaJG5IcrWoJMDs738zOfDM7jUYDYpHky0a72W12WoFk
01aWsdbecumLtBVx1mQVL9BwGkiADrid/Z32vtuBtuO4VcuyCvVHFEc5h14mwXXA7e53X+w77ULx
4AAae/YuWPR1cFAFqEPIFZNizBWwNEk40yJNFORKJBPQUw4i0VwmQQxZIIM45viSSg2D1gcbFlPB
pgZFKBgHSjDccQn4BWkE57TvqEnyagP3DBIW52gOVJ4ZjCiVxkSUxnG6IIPnbz+pffjTe/7cbdvw
/uPoxa6z+nVb7WbV+hUwNhyd73X2up03f//RL9yjIwzFZKohSRc2DCCYwZzLS1gESvMoj2Eh9NRY
GedRxKVqAu1CgyzQHGZ8lspLA5MFE/QtSELanUAo5iLk9D6jUKbQfgeRDGZloNEUw7cILhHxAu3D
wCSq49jPwcLvIlW/5UnIo8rhh7PjwYl/3D/0i3OhBNdFwtdE7kNKRVCqViEBKIlKUakC6ooi0PB7
wTWkRyQmzenrddEFMoTHJCLHu84Lew+sruvYyEDyvVIZh5llvcS3a4RuVEQENVxqvGbj0FcMtuDN
kd8/64/80Ud/2O8dfdquWpvsgitCT7gWka90mvnfcp7zWsjn2y8RoRJxVNdLH1MYwytwaZFcgELC
cunrJQpqZEJDfRvtoZvmHK7b6VIK8HfX3nWLLPAkRLdadViLKdRbBFy1UNj4NQ9BEtwIeXcWUGVi
HXp8JjAXYc40Er+UNCrCXPEQ0gRUigw75aEItBRLGKeBDOEG7ld6h0wSETHpESJZxuKQTwQWkgRD
VVH0GFJfcRdOB4Oymo8V7I08cJbIIIo2/gdPBzpXd1hP6Z8Ozr3DIem7Rt/LOBORYD8KcuIZkLYB
OeEJl49gVC2FqyicpyKEmRA+9kvF/TAzeOP5V+4zJWs5NgEjlnxig9IS0wjIXx8pKxiHOlG3al0h
T1dC7Ok+px2ZFHNqNnWkLlIWNzZe0xpxep7GaD3mYPDrCuVbNUPxbHrpK+MwVQRuReHWK/i3hiH1
vVFv5Hvnpz3v3UpKNbdyD+vNWTqO00Z/AB/y6SF5l2q1Qrj/vIJbVNc5PvpoapDHij+8422x4xo/
xaafMbOBnZKh61KqKDQiiVIs/NvXUr4whuQLGsfL09lhro3/npUI8sw2IathNaoCgs2oi3z+gn3J
MKbomUgQAPLsCmYXPh1rIYXmNeLbsH/i9856Q5sO6fbdbRvO/nr/HuDaJoBertPGGZ+kTJj6vyPd
YZpomcaguAa8VqCo7koFfuxBGwHZSFY2OE4NLYzY6ZtM2fA2iKPWMfXOMM9ivlzZuD2H5EF4e4zD
IToPJe4znF3wHI9r0MFR504jSHDeuaeBHdcGoohZfyLYmFWp8wwawJNgHK9GF5lnWt33+y7+603D
vmH9KhNFIvqbQxaxsE3fcJzbhML3SDQhDLnx+S7LepXlp8LsfR8yJQHWw7xR0Cj37MI3HeMRg+vt
sBQWQ1BGI0vMw8lTwdnoAAbvWGBc0lybWQuvZ8nRu6J/beRkcXF8Z+BeC/55fk1zHaaLBAkWCvU/
dLhDxZ5jWuuDo0P5+i6ukSqsd6f6zfvnL6Ypmens/q27GgeLyaW7ayaXtrtzM4OtK6xGQahs3Zr6
pszI/MicU0yVm137JdBS/O3NwkDzGZGsChi6/wCmeKp0LQ0AAA==

------_=_NextPart_000_01C0C203.D67DE840--
