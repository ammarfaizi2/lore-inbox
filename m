Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267108AbSKSGNc>; Tue, 19 Nov 2002 01:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbSKSGNc>; Tue, 19 Nov 2002 01:13:32 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43790
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267104AbSKSGNa>; Tue, 19 Nov 2002 01:13:30 -0500
Date: Mon, 18 Nov 2002 22:16:02 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Douglas Gilbert <dougg@torque.net>
cc: "J. E. J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: linux-2.4.18-modified-scsi-h.patch
In-Reply-To: <20021118171446.A28459@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.10.10211182138310.2779-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1430322656-1953087833-1037686562=:2779"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1430322656-1953087833-1037686562=:2779
Content-Type: text/plain; charset=us-ascii


Greetings Doug et al.

Please consider the addition of this simple void ptr to the scsi_request
struct.  The addition of this simple void pointer allows one to map any
and all request execution caller the facility to search for a specific
operation without having to run in circles.  Hunting for these details
over the global device list of all HBA's is silly and one of the key
reasons why there error recovery path is so painful.


Scsi_Request    *req = sc_cmd->sc_request;
blah_blah_t     *trace = NULL;

trace = (blah_blah_t *)req->trace_ptr;


Therefore the specific transport invoking operations via the midlayer will
have the ablity to track and trace any operation.

It will save everyone headaches.

Cheers,


Andre Hedrick, CTO & Founder 
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/

--1430322656-1953087833-1037686562=:2779
Content-Type: text/plain; charset=us-ascii; name="linux-2.4.18-modified-scsi-h.patch"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.10.10211182216020.2779@master.linux-ide.org>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.18-modified-scsi-h.patch"

LS0tIGxpbnV4L2RyaXZlcnMvc2NzaS9zY3NpLmgub3JpZwkyMDAyLTEwLTMx
IDAxOjQ1OjM5LjAwMDAwMDAwMCAtMDgwMA0KKysrIGxpbnV4L2RyaXZlcnMv
c2NzaS9zY3NpLmgJMjAwMi0xMC0zMSAwMTo0NjozMS4wMDAwMDAwMDAgLTA4
MDANCkBAIC02NjcsOCArNjY3LDExIEBADQogCXVuc2lnbmVkIHNob3J0IHNy
X3NnbGlzdF9sZW47CS8qIHNpemUgb2YgbWFsbG9jJ2Qgc2NhdHRlci1nYXRo
ZXIgbGlzdCAqLw0KIAl1bnNpZ25lZCBzcl91bmRlcmZsb3c7CS8qIFJldHVy
biBlcnJvciBpZiBsZXNzIHRoYW4NCiAJCQkJICAgdGhpcyBhbW91bnQgaXMg
dHJhbnNmZXJyZWQgKi8NCisJdm9pZCAqdHJhY2VfcHRyOwkvKiBjYXBhYmxl
IG9mIGNtZC1jbW5kLWVycm9yIHRyYWNpbmcgKi8NCiB9Ow0KIA0KKyNkZWZp
bmUgTU9ESUZJRURfU0NTSV9IDQorDQogLyoNCiAgKiBGSVhNRShlcmljKSAt
IG9uZSBvZiB0aGUgZ3JlYXQgcmVncmV0cyB0aGF0IEkgaGF2ZSBpcyB0aGF0
IEkgZmFpbGVkIHRvIGRlZmluZQ0KICAqIHRoZXNlIHN0cnVjdHVyZSBlbGVt
ZW50cyBhcyBzb21ldGhpbmcgbGlrZSBzY19mb28gaW5zdGVhZCBvZiBmb28u
ICBUaGlzIHdvdWxkDQo=
--1430322656-1953087833-1037686562=:2779--
