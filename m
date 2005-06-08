Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVFHE7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVFHE7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 00:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVFHE7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 00:59:46 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:557 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262104AbVFHE67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 00:58:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=t4UsVegUnCA4RWijntrIRM8dsoFSO3XA3mzwGbEAhkgnToS9KEEis4QkMOjSLu3Wv/vhqn8UbnZPyKg1TP3UjOwF3Z/Q4tV78b5Qs8Osn/fP1h/KmgLUhlJsopti+wnH97dkdcKd4oOZnunDqfumG2OQKwnx6/iAITpu0o+cxUk=
Message-ID: <b70d738005060721584aa25e71@mail.gmail.com>
Date: Tue, 7 Jun 2005 21:58:51 -0700
From: Adam Morley <adam.morley@gmail.com>
Reply-To: Adam Morley <adam.morley@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: psmouse doesn't seem to reinitialize after mem suspend (acpi) when using i8042 on ALi M1553 ISA bridge with 2.6.11.11 or 2.6.12-rc5?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506072252.40120.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9386_23689681.1118206731932"
References: <b70d73800506051924546c8931@mail.gmail.com>
	 <200506060125.00489.dtor_core@ameritech.net>
	 <b70d7380050606002834116fea@mail.gmail.com>
	 <200506072252.40120.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_9386_23689681.1118206731932
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 6/7/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Monday 06 June 2005 02:28, Adam Morley wrote:
> > Hi Dimitry,
> >
> > On 6/5/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > On Sunday 05 June 2005 21:24, Adam Morley wrote:
> > >  > When I do a mem suspend (echo mem > /sys/power/state), either thro=
ugh
> > > > a lid switch ACPI action, or manually echo'ing the parameter, the
> > > > mouse doesn't work after un-suspending.  It seems like it is no lon=
ger
> > > > detected/initialized.  cat'ing the device file doesn't produce outp=
ut,
> > > > and gpm and X don't get mouse inputs.
> > >
> > > Could you please try booting 2.6.12-rc5 with "i8042.debug" on the ker=
nel
> > > command line; suspend, resume and post your dmesg?
> >
> > Sure.  Here it is.  Suspend was done using acpid using a lid action.
> > psmouse was modprobe -r'ed before suspend and modprobe'ed back in
> > after resume.
> >
>=20
> We are trying to resume but KBC signals timeout condition every time we
> ping AUX port:
>=20
> > drivers/input/serio/i8042.c: 60 -> i8042 (command) [220701]
> > drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [220701]
> > drivers/input/serio/i8042.c: d4 -> i8042 (command) [220703]
> > drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [220703]
> > drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) =
[220725]
> > drivers/input/serio/i8042.c: d4 -> i8042 (command) [220726]
> > drivers/input/serio/i8042.c: ed -> i8042 (parameter) [220726]
> > drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) =
[220747]
> > drivers/input/serio/i8042.c: 60 -> i8042 (command) [220748]
> > drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [220748]
> > drivers/input/serio/i8042.c: 60 -> i8042 (command) [220943]
> > drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [220943]
> > drivers/input/serio/i8042.c: d4 -> i8042 (command) [220943]
> > drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [220943]
> > drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) =
[220965]
>=20
> Could you please try the patch below?

Ok, patch applied (against 2.6.12-rc5, clean, offset 2 lines for both
hunk 3 and 4).  Mouse still doesn't work on resume.  dmesg
w/i8042.debug set on kernel command line attached covering one
suspend/resume.

Thanks a bunch!  let me know if more data will help.

--=20
adam

------=_Part_9386_23689681.1118206731932
Content-Type: text/plain; name="dmesg.patch.i8042.debug.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg.patch.i8042.debug.txt"

U3RvcHBpbmcgdGFza3M6ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
fApkcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmM6IDYwIC0+IGk4MDQyIChjb21tYW5kKSBbNTQ3
NDIwXQpkcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmM6IDQ3IC0+IGk4MDQyIChwYXJhbWV0ZXIp
IFs1NDc0MjBdCmV0aDE6IE9yaW5vY28tUENJIGVudGVyaW5nIHNsZWVwIG1vZGUgKHN0YXRlPTMp
CiBod3NsZWVwLTAzMDYgWzA4XSBhY3BpX2VudGVyX3NsZWVwX3N0YXRlOiBFbnRlcmluZyBzbGVl
cCBzdGF0ZSBbUzNdCkJhY2sgdG8gQyEKQUNQSTogUENJIEludGVycnVwdCAwMDAwOjAwOjAyLjBb
QV0gLT4gTGluayBbTE5LVV0gLT4gR1NJIDExIChsZXZlbCwgbG93KSAtPiBJUlEgMTEKQUNQSTog
UENJIEludGVycnVwdCAwMDAwOjAwOjA0LjBbQV0gLT4gTGluayBbTE5LSF0gLT4gR1NJIDkgKGxl
dmVsLCBsb3cpIC0+IElSUSA5CiBwY2lfaXJxLTAzNzAgWzExXSBhY3BpX3BjaV9pcnFfZGVyaXZl
ICAgOiBVbmFibGUgdG8gZGVyaXZlIElSUSBmb3IgZGV2aWNlIDAwMDA6MDA6MGYuMApBQ1BJOiBQ
Q0kgSW50ZXJydXB0IDAwMDA6MDA6MGYuMFtBXTogbm8gR1NJIC0gdXNpbmcgSVJRIDAKZXRoMDog
bGluayB1cCwgMTAwTWJwcywgZnVsbC1kdXBsZXgsIGxwYSAweDQxRTEKZXRoMTogT3Jpbm9jby1Q
Q0kgd2FraW5nIHVwCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxNC4wW0FdIC0+IExpbmsg
W0xOS0RdIC0+IEdTSSA5IChsZXZlbCwgbG93KSAtPiBJUlEgOQpkcml2ZXJzL2lucHV0L3Nlcmlv
L2k4MDQyLmM6IDYwIC0+IGk4MDQyIChjb21tYW5kKSBbNTU1ODk2XQpkcml2ZXJzL2lucHV0L3Nl
cmlvL2k4MDQyLmM6IDQ3IC0+IGk4MDQyIChwYXJhbWV0ZXIpIFs1NTU4OTZdCmRyaXZlcnMvaW5w
dXQvc2VyaW8vaTgwNDIuYzogNjAgLT4gaTgwNDIgKGNvbW1hbmQpIFs1NTU4OTddCmRyaXZlcnMv
aW5wdXQvc2VyaW8vaTgwNDIuYzogNDcgLT4gaTgwNDIgKHBhcmFtZXRlcikgWzU1NTg5N10KZHJp
dmVycy9pbnB1dC9zZXJpby9pODA0Mi5jOiA2MCAtPiBpODA0MiAoY29tbWFuZCkgWzU1NTg5OF0K
ZHJpdmVycy9pbnB1dC9zZXJpby9pODA0Mi5jOiA0NyAtPiBpODA0MiAocGFyYW1ldGVyKSBbNTU1
ODk4XQpkcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmM6IGYyIC0+IGk4MDQyIChrYmQtZGF0YSkg
WzU1NTg5OV0KZHJpdmVycy9pbnB1dC9zZXJpby9pODA0Mi5jOiBmYSA8LSBpODA0MiAoaW50ZXJy
dXB0LCBLQkQsIDEpIFs1NTU5MDJdCmRyaXZlcnMvaW5wdXQvc2VyaW8vaTgwNDIuYzogYWIgPC0g
aTgwNDIgKGludGVycnVwdCwgS0JELCAxKSBbNTU1OTA5XQpkcml2ZXJzL2lucHV0L3NlcmlvL2k4
MDQyLmM6IDU0IDwtIGk4MDQyIChpbnRlcnJ1cHQsIEtCRCwgMSkgWzU1NTkxNF0KZHJpdmVycy9p
bnB1dC9zZXJpby9pODA0Mi5jOiBlZCAtPiBpODA0MiAoa2JkLWRhdGEpIFs1NTU5MTldCmRyaXZl
cnMvaW5wdXQvc2VyaW8vaTgwNDIuYzogZmEgPC0gaTgwNDIgKGludGVycnVwdCwgS0JELCAxKSBb
NTU1OTIyXQpkcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmM6IDAwIC0+IGk4MDQyIChrYmQtZGF0
YSkgWzU1NTkzOV0KZHJpdmVycy9pbnB1dC9zZXJpby9pODA0Mi5jOiBmYSA8LSBpODA0MiAoaW50
ZXJydXB0LCBLQkQsIDEpIFs1NTU5NDJdCmRyaXZlcnMvaW5wdXQvc2VyaW8vaTgwNDIuYzogZjMg
LT4gaTgwNDIgKGtiZC1kYXRhKSBbNTU1OTU5XQpkcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmM6
IGZhIDwtIGk4MDQyIChpbnRlcnJ1cHQsIEtCRCwgMSkgWzU1NTk2Ml0KZHJpdmVycy9pbnB1dC9z
ZXJpby9pODA0Mi5jOiAwMCAtPiBpODA0MiAoa2JkLWRhdGEpIFs1NTU5NzldCmRyaXZlcnMvaW5w
dXQvc2VyaW8vaTgwNDIuYzogZmEgPC0gaTgwNDIgKGludGVycnVwdCwgS0JELCAxKSBbNTU1OTgy
XQpkcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmM6IGY0IC0+IGk4MDQyIChrYmQtZGF0YSkgWzU1
NTk5OV0KZHJpdmVycy9pbnB1dC9zZXJpby9pODA0Mi5jOiBmYSA8LSBpODA0MiAoaW50ZXJydXB0
LCBLQkQsIDEpIFs1NTYwMDJdCmRyaXZlcnMvaW5wdXQvc2VyaW8vaTgwNDIuYzogZWQgLT4gaTgw
NDIgKGtiZC1kYXRhKSBbNTU2MDE5XQpkcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmM6IGZhIDwt
IGk4MDQyIChpbnRlcnJ1cHQsIEtCRCwgMSkgWzU1NjAyMl0KZHJpdmVycy9pbnB1dC9zZXJpby9p
ODA0Mi5jOiAwMCAtPiBpODA0MiAoa2JkLWRhdGEpIFs1NTYwMzldCmRyaXZlcnMvaW5wdXQvc2Vy
aW8vaTgwNDIuYzogZmEgPC0gaTgwNDIgKGludGVycnVwdCwgS0JELCAxKSBbNTU2MDQyXQpSZXN0
YXJ0aW5nIHRhc2tzLi4uPDc+ZHJpdmVycy9pbnB1dC9zZXJpby9pODA0Mi5jOiA2MCAtPiBpODA0
MiAoY29tbWFuZCkgWzU1NjEwMV0KZHJpdmVycy9pbnB1dC9zZXJpby9pODA0Mi5jOiA0NyAtPiBp
ODA0MiAocGFyYW1ldGVyKSBbNTU2MTAxXQpkcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmM6IGQ0
IC0+IGk4MDQyIChjb21tYW5kKSBbNTU2MTAyXQpkcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmM6
IGYyIC0+IGk4MDQyIChwYXJhbWV0ZXIpIFs1NTYxMDJdCiBkb25lCmRyaXZlcnMvaW5wdXQvc2Vy
aW8vaTgwNDIuYzogZmUgPC0gaTgwNDIgKGludGVycnVwdCwgQVVYLCAxMiwgdGltZW91dCkgWzU1
NjEyNF0KZHJpdmVycy9pbnB1dC9zZXJpby9pODA0Mi5jOiBkNCAtPiBpODA0MiAoY29tbWFuZCkg
WzU1NjEyNF0KZHJpdmVycy9pbnB1dC9zZXJpby9pODA0Mi5jOiBlZCAtPiBpODA0MiAocGFyYW1l
dGVyKSBbNTU2MTI0XQpkcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmM6IGZlIDwtIGk4MDQyIChp
bnRlcnJ1cHQsIEFVWCwgMTIsIHRpbWVvdXQpIFs1NTYxNDZdCmRyaXZlcnMvaW5wdXQvc2VyaW8v
aTgwNDIuYzogNjAgLT4gaTgwNDIgKGNvbW1hbmQpIFs1NTYxNDZdCmRyaXZlcnMvaW5wdXQvc2Vy
aW8vaTgwNDIuYzogNDUgLT4gaTgwNDIgKHBhcmFtZXRlcikgWzU1NjE0Nl0KdXNiIDEtMzogVVNC
IGRpc2Nvbm5lY3QsIGFkZHJlc3MgMwp1c2IgMS0zOiBuZXcgbG93IHNwZWVkIFVTQiBkZXZpY2Ug
dXNpbmcgb2hjaV9oY2QgYW5kIGFkZHJlc3MgNAppbnB1dDogVVNCIEhJRCB2MS4wMCBNb3VzZSBb
RnVqaXRzdSBUYWthbWlzYXdhIFVTQiBUb3VjaCBQYW5lbF0gb24gdXNiLTAwMDA6MDA6MDIuMC0z
CmRyaXZlcnMvaW5wdXQvc2VyaW8vaTgwNDIuYzogNjAgLT4gaTgwNDIgKGNvbW1hbmQpIFs1NTc3
MzFdCmRyaXZlcnMvaW5wdXQvc2VyaW8vaTgwNDIuYzogNDcgLT4gaTgwNDIgKHBhcmFtZXRlcikg
WzU1NzczMV0KZHJpdmVycy9pbnB1dC9zZXJpby9pODA0Mi5jOiBkNCAtPiBpODA0MiAoY29tbWFu
ZCkgWzU1NzczMl0KZHJpdmVycy9pbnB1dC9zZXJpby9pODA0Mi5jOiBmMiAtPiBpODA0MiAocGFy
YW1ldGVyKSBbNTU3NzMyXQpkcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmM6IGZlIDwtIGk4MDQy
IChpbnRlcnJ1cHQsIEFVWCwgMTIsIHRpbWVvdXQpIFs1NTc3NTNdCmRyaXZlcnMvaW5wdXQvc2Vy
aW8vaTgwNDIuYzogNjAgLT4gaTgwNDIgKGNvbW1hbmQpIFs1NTc3NTNdCmRyaXZlcnMvaW5wdXQv
c2VyaW8vaTgwNDIuYzogNDUgLT4gaTgwNDIgKHBhcmFtZXRlcikgWzU1Nzc1M10KZHJpdmVycy9p
bnB1dC9zZXJpby9pODA0Mi5jOiAxYyA8LSBpODA0MiAoaW50ZXJydXB0LCBLQkQsIDEpIFs1NjQ3
NjVdCg==
------=_Part_9386_23689681.1118206731932--
