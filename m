Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSF3Qut>; Sun, 30 Jun 2002 12:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSF3Qus>; Sun, 30 Jun 2002 12:50:48 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62095 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315334AbSF3Quq>; Sun, 30 Jun 2002 12:50:46 -0400
Date: Sun, 30 Jun 2002 18:52:58 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Martin Dalecki <dalecki@evision-ventures.com>, <alex@ssi.bg>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 IDE 95 (fwd)
Message-ID: <Pine.SOL.4.30.0206301848370.26714-200000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1025454003=:18032"
Content-ID: <Pine.SOL.4.30.0206301848371.26714@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1025454003=:18032
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.SOL.4.30.0206301848372.26714@mion.elka.pw.edu.pl>


I hope you dont mind Petr.

---------- Forwarded message ----------
Date: Sun, 30 Jun 2002 18:20:03 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH] 2.5.24 IDE 95


Hi!

On Sun, 30 Jun 2002, Petr Vandrovec wrote:

> On Sun, Jun 30, 2002 at 12:53:57AM +0200, Bartlomiej Zolnierkiewicz wrote:
> >
> > Hi Petr!
> >
> > On Sun, 30 Jun 2002, Petr Vandrovec wrote:
> >
> > > Hi,
> > >   I know that IDE95 is broken when it comes to IDE, but... not only
>
> Oops. It should read ... when it comes to CD, ...
> Thanks for your updates, applying them just now.
> 							Petr
>
> P.S.: Locking looks suspicious too. On other side, if hardware is broken
> and requires large data transfers during interrupt, why we should
> bother? ne2000 driver always required disabling interrupts for up to 1.6ms...

1.6ms really bad, masked PIO is about 2ms, this can affect audio etc.,
Legacy/special/broken hardware does only PIO, but most of it do not
require transfers with IRQs disabled (thats why ch->unmask flag).

Even with new locking (ch->lock for everything) we don't have to disable
IRQs completly, we can mask our IRQ and enable rest, but it is not
possible to i.e. share IRQ with audio (because we disable our IRQ).
It was (at least in theory) possible with old locking.

Old locking is that ch->lock spinlock protects access to IDE_BUSY bit in
ch->active, ch->handler and ch->timer. IDE_BUSY protects hardware access,
if it is set we do not enter start_request() in do_request(). When we start
request block layer sets RQ_STARTED flag on request so it is protected
from block layer side. Thats almost all about locking.

Hope this clarifies some things, also old akpm's note about IDE
unmaskirqs attached....

Greets.
--
Bartlomiej

---559023410-851401618-1025454003=:18032
Content-Type: TEXT/PLAIN; NAME="ide-intr.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.30.0206301820030.18032@mion.elka.pw.edu.pl>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ide-intr.txt"

RGF0ZTogU2F0LCAyMiBBcHIgMjAwMCAwMTo1MTo1NCArMTAwMA0KRnJvbTog
QW5kcmV3IE1vcnRvbiA8YW5kcmV3bUB1b3cuZWR1LmF1Pg0KU3ViamVjdDog
UmU6IElERSBkcml2ZXMgYW5kIHVubWFza2lycQ0KDQpbIEkgY3V0IGxrbWwg
LSBJJ3ZlIGJlZW4gcG9zdGluZyB0b28gbXVjaCB0b2RheSA6KSBdDQoNCk1h
cnRpam4gdmFuIE9vc3RlcmhvdXQgd3JvdGU6DQo+IA0KPiBPZGQsIGJvdGgg
bXkgaGFyZCBkaXNrcyBhcmUgVURNQS4gWW91J3JlIHNheWluZyB1bm1hc2tp
cnEgaGFzDQo+IG5vIGVmZmVjdCBvbiBVRE1BIHN5c3RlbXM/DQoNCkkgaGF2
ZSBhIHBhdGNoIHdoaWNoIG1lYXN1cmVzIGludGVycnVwdCBsYXRlbmNpZXMu
ICBJdCB0ZWxscyB5b3UgaG93DQpsb25nIHRoZSBrZXJuZWwgc3BlbmRzIHdp
dGggaW50ZXJydXB0cyBkaXNhYmxlZDogd2hlcmUgdGhleSB3ZXJlIHR1cm5l
ZA0Kb2ZmLCB3aGVyZSB0aGV5IHdlcmUgdHVybmVkIG9uLCBtaW4sIG1heCwg
YXZnIG51bWJlciBvZiBtaWNyb3NlY29uZHMuDQoNCldpdGggVURNQTY2IGRy
aXZlczoNCg0KaGRwYXJtIC11MCAtZDAgIChpbnRlcnJ1cHRzIG1hc2tlZCwg
UElPKQ0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENv
dW50ICAgTWluICAgICAgTWF4ICAgICAgQXZnDQppZGUtZGlzay5jOjQ1MSAt
PiBsbF9yd19ibGsuYzoyNzcgIDEyICAgICA4MjUuMTcgIDIzNTAuMTQgIDEy
NjguMzUNCiAgICAgaWRlLWRpc2suYzo0NTEgLT4gaWRlLmM6MTYyMCAgNTkx
ICAgIDgxOC44MiAgMjE3Mi4xOCAgMTEzOC4yNg0KICAgICAgICAgaWRlLmM6
MTUzMSAtPiBpZGUuYzoxNjIwICA3NDA3ICAgIDEyLjEzICAyMTQ3LjMyICAx
NTE5LjI5DQogICAgICAgICBpZGUuYzoxNTMxIC0+IGlkZS5jOjEyOTYgIDcy
MSAgICAgIDkuNTEgIDE5MzAuMTEgICAyMzYuNzMNCiAgICBsbF9yd19ibGsu
YzoyNzEgLT4gaWRlLmM6MTI5NiAgMjkxMiAgICAxMy44MiAgICAyNy44OSAg
ICAxNi41Ng0KICAgICAgICAgLi4uDQoNCmhkcGFybSAtdCBzYXlzIDQuMSBN
Qi9zZWMNCg0KKFRoZSBmaXJzdCB0cmF2ZXJzYWwgc2VlbXMgYSB2ZXJ5IG9k
ZCBwbGFjZSB0byByZWVuYWJsZS4uLikNCg0KLS0tLS0tLQ0KDQpoZHBhcm0g
LXUwIC1kMSAoaW50ZXJydXB0cyBtYXNrZWQsIERNQSkNCg0KICAgICBpZGUu
YzoxNTMxIC0+IGlkZS5jOjE2MjAgIDUyMzAgICAgIDExLjEzICAgIDkwLjc2
ICAgIDI2LjU1DQogICAgIGlkZS5jOjE1MzEgLT4gaWRlLmM6MTI5NiAgNDg0
ICAgICAgMTEuNTMgICAgNzMuMTUgICAgMTcuMTUNCmxsX3J3X2Jsay5jOjI3
MSAtPiBpZGUuYzoxMjk2ICA1MjMyICAgICAxMy43OSAgICAyOC4wNyAgICAx
Ni41MQ0KaWRlLmM6MTI5OCAtPiBsbF9yd19ibGsuYzoyNzcgIDUyMzIgICAg
ICA3LjMzICAgIDE0LjQwICAgICA4LjIzDQogICAgICAuLi4NCg0KaGRwYXJt
IC10IHNheXMgMjEgTUIvc2VjDQoNCi0tLS0tLQ0KDQpoZHBhcm0gLXUxIC1k
MCAoaW50ZXJydXB0cyB1bm1hc2tlZCwgUElPKQ0KDQogICAgICAgICAgaWRl
LmM6NTIyIC0+IGlkZS5jOjUzMSAgODYzMSAgICAgLjgxICAgIDMyLjMwICAg
ICAxLjkzDQogICBsbF9yd19ibGsuYzoyNzEgLT4gaWRlLmM6MTI5NiAgMzky
MSAgIDEzLjgyICAgIDI4Ljk0ICAgIDE2LjUyDQogICAgICAgICAgaWRlLmM6
NDk3IC0+IGlkZS5jOjUwNiAgMTQzODggICAxLjA3ICAgIDI0Ljc5ICAgICA2
LjA3DQogICBpZGUuYzoxMjk4IC0+IGxsX3J3X2Jsay5jOjI3NyAgMzkyMSAg
ICA3LjMzICAgIDE0Ljc2ICAgICA4LjE1DQogICAgICAgICAuLi4NCg0KaGRw
YXJtIC10IHNheXMgNC4yIE1CL3NlYw0KDQotLS0tLS0tLQ0KDQpoZHBhcm0g
LXUxIC1kMSAoaW50ZXJydXB0cyB1bm1hc2tlZCwgRE1BKQ0KDQpsbF9yd19i
bGsuYzoyNzEgLT4gaWRlLmM6MTI5NiAgMzk1MCAgICAgMTMuNzggICAgMjYu
NzQgICAgMTYuNDMNCiAgICAgaWRlLmM6MTcxMyAtPiBpZGUuYzoxMjk2ICAx
ICAgICAgICAyMy42MSAgICAyMy42MSAgICAyMy42MQ0KICAgICAgIGlkZS5j
OjQ5NyAtPiBpZGUuYzo1MDYgIDE0NjIzICAgICAgLjk5ICAgIDIzLjIyICAg
ICA1LjA2DQppZGUuYzoxMjk4IC0+IGxsX3J3X2Jsay5jOjI3NyAgMzk1MCAg
ICAgIDcuMzUgICAgMTUuNzIgICAgIDguMTENCiAgICAgICAgIC4uLg0KDQpo
ZHBhcm0gLXQgc2F5cyAyMiBNQi9zZWMNCg0KDQpTbyB5b3UgY2FuIHNlZSB0
aGF0IGV2ZW4gd2l0aCBETUEsICdoZHBhcm0gLXUxJyBjdXRzIHRoZSBtYXgN
CmludGVycnVwdC1kaXNhYmxlIHRpbWUgZnJvbSA5MCB0byAyNyBtaWNyb3Nl
Y29uZHMuICBJIHNvbWVob3cgZG91YnQgaWYNCnRoYXQgd2lsbCBhZmZlY3Qg
aW50ZXJhY3RpdmUgcGVyY2VwdGlvbnMsIGJ1dCB0aGUgdHdvIG1pbGxpc2Vj
b25kcyBmb3INClBJTy9tYXNrZWQgd2lsbCBhZmZlY3QgYXVkaW8sIGZvciBl
eGFtcGxlLg0KDQo=
---559023410-851401618-1025454003=:18032--
