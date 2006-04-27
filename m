Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWD0M5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWD0M5W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWD0M5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:57:22 -0400
Received: from mail.ccur.com ([66.10.65.12]:17256 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S964898AbWD0M5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:57:22 -0400
Subject: CLONE_NEWNS and mount command?
From: Tom Horsley <tom.horsley@ccur.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: bugsy <bugsy@ccur.com>
Content-Type: multipart/mixed; boundary="=-Jr+9SaT/UOPsxESQ/1+x"
Date: Thu, 27 Apr 2006 08:57:20 -0400
Message-Id: <1146142640.23667.9.camel@tweety>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jr+9SaT/UOPsxESQ/1+x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I stumbled across the CLONE_NEWNS flag in the clone() man page and
thought I'd see if I could write a program that would let me do things
like run an sshd on my machine in a different "namespace" created
before any network filesystems were mounted (so I could run rpm
commands without NFS timeouts, etc).

In my experiments though, I got very confused. I created the attached
program, used it to exec an xterm, then in that xterm unmounted
a NFS filesystem.

It disappeared from the mounts listed by the "mount" command
in both the old and new namespace, but if I attempted to remount
the system in the old namespace I get an error telling me it is
already mounted (even though it doesn't show up). In the new
namespace where I unmounted it, I can remount it (then it shows
up again in the mount listing in both namespaces).

Should the /proc/mounts file be paying more attention to this
"namespace" thing? Is this a bug, or just the way things happen
to work out?

--=-Jr+9SaT/UOPsxESQ/1+x
Content-Disposition: attachment; filename=nomounts.c
Content-Type: text/x-csrc; name=nomounts.c; charset=us-ascii
Content-Transfer-Encoding: base64

LyogUnVuIGEgcHJvY2VzcyBpbiBhIG5ldyAibmFtZXNwYWNlIi4NCiAqLw0KI2luY2x1ZGUgPHNj
aGVkLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQojaW5j
bHVkZSA8c3lzL3dhaXQuaD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KDQojZGVmaW5lIFNUQUNLX1NJ
WkUgKCgyMCo0MDk2KS9zaXplb2YoZG91YmxlKSkNCnN0YXRpYyBkb3VibGUgc3RhY2tfc3BhY2Vb
U1RBQ0tfU0laRV07DQoNCmludA0KZG9fbmV3X25hbWVzcGFjZSh2b2lkICogYXJnKSB7DQogICBj
aGFyICoqIGFyZ3YgPSAoY2hhciAqKilhcmc7DQogICBleGVjdnAoYXJndlswXSwgYXJndik7DQog
ICBwZXJyb3IoImV4ZWN2cCIpOw0KICAgX2V4aXQoMik7DQp9DQoNCmludA0KbWFpbihpbnQgYXJn
YywgY2hhciAqKiBhcmd2KSB7DQogICBpbnQgY2xvbmVfaWQ7DQogICBpbnQgd3N0YXQ7DQogICBw
aWRfdCBraWQ7DQoNCiAgIGNsb25lX2lkID0gY2xvbmUoZG9fbmV3X25hbWVzcGFjZSwgJnN0YWNr
X3NwYWNlW1NUQUNLX1NJWkUtMl0sIENMT05FX05FV05TLA0KICAgICAgICAgICAgICAgICAgICAo
dm9pZCAqKShhcmd2ICsgMSkpOw0KICAgaWYgKGNsb25lX2lkID09IC0xKSB7DQogICAgICBwZXJy
b3IoImNsb25lIik7DQogICAgICBfZXhpdCgyKTsNCiAgIH0NCiAgIGtpZCA9IHdhaXRwaWQoKHBp
ZF90KWNsb25lX2lkLCAmd3N0YXQsIDApOw0KICAgaWYgKGtpZCA9PSAocGlkX3QpLTEpIHsNCiAg
ICAgIHBlcnJvcigid2FpdHBpZCIpOw0KICAgICAgX2V4aXQoMik7DQogICB9DQogICBpZiAoKGtp
ZCA9PSAocGlkX3QpY2xvbmVfaWQpICYmIFdJRkVYSVRFRCh3c3RhdCkpIHsNCiAgICAgIF9leGl0
KFdFWElUU1RBVFVTKHdzdGF0KSk7DQogICB9IGVsc2Ugew0KICAgICAgX2V4aXQoMik7DQogICB9
DQp9DQo=


--=-Jr+9SaT/UOPsxESQ/1+x--
