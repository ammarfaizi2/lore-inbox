Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWEAOqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWEAOqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 10:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWEAOqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 10:46:50 -0400
Received: from spirit.analogic.com ([204.178.40.4]:17415 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932123AbWEAOqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 10:46:49 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C66D2E.0CF5DB00"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060501141901.GA7267@mipter.zuzino.mipt.ru>
X-OriginalArrivalTime: 01 May 2006 14:46:38.0570 (UTC) FILETIME=[0D4CD4A0:01C66D2E]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
Date: Mon, 1 May 2006 10:46:37 -0400
Message-ID: <Pine.LNX.4.61.0605011042450.20917@chaos.analogic.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] CodingStyle: add typedefs chapter
thread-index: AcZtLg1Wy33yujrPQKi+oW2bCGCCaA==
References: <20060430174426.a21b4614.rdunlap@xenotime.net> <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr> <20060501141901.GA7267@mipter.zuzino.mipt.ru>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Linux kernel" <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C66D2E.0CF5DB00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On Mon, 1 May 2006, Alexey Dobriyan wrote:

> On Mon, May 01, 2006 at 04:00:09PM +0200, Jan Engelhardt wrote:
>>> +Please don't use things like "vps_t".
>>> +It's a _mistake_ to use typedef for structures and pointers. When you=
 see a
>>> +	vps_t a;
>>> +in the source, what does it mean?
>>> +In contrast, if it says
>>> +	struct virtual_container *a;
>>> +you can actually tell what "a" is.
>>> +
>>> +Lots of people think that typedefs "help readability". Not so. They=
 are
>>> +useful only for:
>> [...]
>>
>> What about task_t vs struct task_struct? Both are used in the kernel.
>
> task_t			=3D> struct task
> struct task_struct	=3D> struct task
>
> Roughly 2765 hits :-\

Yes, also 'current' is probably the most used. Any, since this
has become a FAQ, maybe it's about time to put something in the
Documentation?

--- /usr/src/linux-2.6.16.4/Documentation/CodingStyle.orig	2006-05-01=
 10:17:03.000000000 -0400
+++ /usr/src/linux-2.6.16.4/Documentation/CodingStyle	2006-05-01=
 10:37:09.000000000 -0400
@@ -343,6 +343,33 @@
  Remember: if another thread can find your data structure, and you don't
  have a reference count on it, you almost certainly have a bug.

+	typedefs and and structs
+
+Typedefs should never be used for information hiding. In other words,
+if a typedef defines an aggregate type, and the individual components
+are accessed anywhere in the code, a typedef should not be used.
+
+An example of proper usage:
+typedef struct opaque_type FILE;	// In a header
+
+	FILE *fp;			// In a program block
+
+The type 'FILE' in this example is something that was defined in
+a 'C' runtime library. The code uses pointers to this opaque type,
+but never even knows, and doesn't care, what's inside that structure.
+Therefore, FILE can have been defined using a typedef.
+
+An example of incorrect usage:
+
+typedef struct file_operations FO;	// In a header
+
+	FO	fo;			// In a program block
+	memset(&foo, 0x00, sizeof(foo));
+
+In this case, object FO contains structure members that will be
+accessed by the code. It should not have been defined. Instead,
+the structure name should have been used directly.
+

  		Chapter 11: Macros, Enums and RTL



In case the M$ server mangles the patch, it's included as an attachment.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_
=1A=04


****************************************************************
The information transmitted in this message is confidential and may be=
 privileged.  Any review, retransmission, dissemination, or other use of=
 this information by persons or entities other than the intended recipient=
 is prohibited.  If you are not the intended recipient, please notify=
 Analogic Corporation immediately - by replying to this message or by=
 sending an email to DeliveryErrors@analogic.com - and destroy all copies=
 of this information, including any attachments, without reading or=
 disclosing them.

Thank you.
------_=_NextPart_001_01C66D2E.0CF5DB00
Content-Type: TEXT/PLAIN;
	name="style.patch"
Content-Transfer-Encoding: base64
Content-Description: style.patch
Content-Disposition: attachment;
	filename="style.patch"

LS0tIC91c3Ivc3JjL2xpbnV4LTIuNi4xNi40L0RvY3VtZW50YXRpb24vQ29kaW5nU3R5bGUub3Jp
ZwkyMDA2LTA1LTAxIDEwOjE3OjAzLjAwMDAwMDAwMCAtMDQwMA0KKysrIC91c3Ivc3JjL2xpbnV4
LTIuNi4xNi40L0RvY3VtZW50YXRpb24vQ29kaW5nU3R5bGUJMjAwNi0wNS0wMSAxMDozNzowOS4w
MDAwMDAwMDAgLTA0MDANCkBAIC0zNDMsNiArMzQzLDMzIEBADQogUmVtZW1iZXI6IGlmIGFub3Ro
ZXIgdGhyZWFkIGNhbiBmaW5kIHlvdXIgZGF0YSBzdHJ1Y3R1cmUsIGFuZCB5b3UgZG9uJ3QNCiBo
YXZlIGEgcmVmZXJlbmNlIGNvdW50IG9uIGl0LCB5b3UgYWxtb3N0IGNlcnRhaW5seSBoYXZlIGEg
YnVnLg0KIA0KKwl0eXBlZGVmcyBhbmQgYW5kIHN0cnVjdHMNCisNCitUeXBlZGVmcyBzaG91bGQg
bmV2ZXIgYmUgdXNlZCBmb3IgaW5mb3JtYXRpb24gaGlkaW5nLiBJbiBvdGhlciB3b3JkcywNCitp
ZiBhIHR5cGVkZWYgZGVmaW5lcyBhbiBhZ2dyZWdhdGUgdHlwZSwgYW5kIHRoZSBpbmRpdmlkdWFs
IGNvbXBvbmVudHMNCithcmUgYWNjZXNzZWQgYW55d2hlcmUgaW4gdGhlIGNvZGUsIGEgdHlwZWRl
ZiBzaG91bGQgbm90IGJlIHVzZWQuDQorDQorQW4gZXhhbXBsZSBvZiBwcm9wZXIgdXNhZ2U6DQor
dHlwZWRlZiBzdHJ1Y3Qgb3BhcXVlX3R5cGUgRklMRTsJLy8gSW4gYSBoZWFkZXINCisNCisJRklM
RSAqZnA7CQkJLy8gSW4gYSBwcm9ncmFtIGJsb2NrDQorDQorVGhlIHR5cGUgJ0ZJTEUnIGluIHRo
aXMgZXhhbXBsZSBpcyBzb21ldGhpbmcgdGhhdCB3YXMgZGVmaW5lZCBpbg0KK2EgJ0MnIHJ1bnRp
bWUgbGlicmFyeS4gVGhlIGNvZGUgdXNlcyBwb2ludGVycyB0byB0aGlzIG9wYXF1ZSB0eXBlLA0K
K2J1dCBuZXZlciBldmVuIGtub3dzLCBhbmQgZG9lc24ndCBjYXJlLCB3aGF0J3MgaW5zaWRlIHRo
YXQgc3RydWN0dXJlLg0KK1RoZXJlZm9yZSwgRklMRSBjYW4gaGF2ZSBiZWVuIGRlZmluZWQgdXNp
bmcgYSB0eXBlZGVmLg0KKw0KK0FuIGV4YW1wbGUgb2YgaW5jb3JyZWN0IHVzYWdlOg0KKw0KK3R5
cGVkZWYgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBGTzsJLy8gSW4gYSBoZWFkZXINCisNCisJRk8J
Zm87CQkJLy8gSW4gYSBwcm9ncmFtIGJsb2NrDQorCW1lbXNldCgmZm9vLCAweDAwLCBzaXplb2Yo
Zm9vKSk7DQorDQorSW4gdGhpcyBjYXNlLCBvYmplY3QgRk8gY29udGFpbnMgc3RydWN0dXJlIG1l
bWJlcnMgdGhhdCB3aWxsIGJlDQorYWNjZXNzZWQgYnkgdGhlIGNvZGUuIEl0IHNob3VsZCBub3Qg
aGF2ZSBiZWVuIGRlZmluZWQuIEluc3RlYWQsDQordGhlIHN0cnVjdHVyZSBuYW1lIHNob3VsZCBo
YXZlIGJlZW4gdXNlZCBkaXJlY3RseS4NCisNCiANCiAJCUNoYXB0ZXIgMTE6IE1hY3JvcywgRW51
bXMgYW5kIFJUTA0KIA0K

------_=_NextPart_001_01C66D2E.0CF5DB00--
