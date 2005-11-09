Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVKIOUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVKIOUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVKIOUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:20:33 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:15665
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750839AbVKIOOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:14:15 -0500
Message-Id: <4372127F.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 15:15:11 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH 20/39] NLKD/x86-64 - switch_to() floating point
	adjustment
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <43720F5E.76F0.0078.0@novell.com> <43720F95.76F0.0078.0@novell.com> <43720FBA.76F0.0078.0@novell.com> <43720FF6.76F0.0078.0@novell.com> <43721024.76F0.0078.0@novell.com> <4372105B.76F0.0078.0@novell.com> <437210D1.76F0.0078.0@novell.com> <4372120B.76F0.0078.0@novell.com> <43721239.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part22001E7F.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part22001E7F.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Touching of the floating point state in a kernel debugger must be
NMI-safe, specifically math_state_restore() must be able to deal with
being called out of an NMI context. In order to do that reliably, the
context switch code must take care to not leave a window open where
the current task's TS_USEDFPU flag and CR0.TS could get out of sync.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part22001E7F.1__=
Content-Type: application/octet-stream; name="linux-2.6.14-nlkd-x86_64-switch_to-fpu.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-nlkd-x86_64-switch_to-fpu.patch"

VG91Y2hpbmcgb2YgdGhlIGZsb2F0aW5nIHBvaW50IHN0YXRlIGluIGEga2VybmVsIGRlYnVnZ2Vy
IG11c3QgYmUKTk1JLXNhZmUsIHNwZWNpZmljYWxseSBtYXRoX3N0YXRlX3Jlc3RvcmUoKSBtdXN0
IGJlIGFibGUgdG8gZGVhbCB3aXRoCmJlaW5nIGNhbGxlZCBvdXQgb2YgYW4gTk1JIGNvbnRleHQu
IEluIG9yZGVyIHRvIGRvIHRoYXQgcmVsaWFibHksIHRoZQpjb250ZXh0IHN3aXRjaCBjb2RlIG11
c3QgdGFrZSBjYXJlIHRvIG5vdCBsZWF2ZSBhIHdpbmRvdyBvcGVuIHdoZXJlCnRoZSBjdXJyZW50
IHRhc2sncyBUU19VU0VERlBVIGZsYWcgYW5kIENSMC5UUyBjb3VsZCBnZXQgb3V0IG9mIHN5bmMu
CgpGcm9tOiBKYW4gQmV1bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4KCkluZGV4OiAyLjYuMTQt
bmxrZC9hcmNoL3g4Nl82NC9rZXJuZWwvcHJvY2Vzcy5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIDIuNi4xNC1u
bGtkLm9yaWcvYXJjaC94ODZfNjQva2VybmVsL3Byb2Nlc3MuYwkyMDA1LTExLTA5IDExOjIwOjUx
LjAwMDAwMDAwMCArMDEwMAorKysgMi42LjE0LW5sa2QvYXJjaC94ODZfNjQva2VybmVsL3Byb2Nl
c3MuYwkyMDA1LTExLTA0IDE2OjE5OjMzLjAwMDAwMDAwMCArMDEwMApAQCAtNTA1LDYgKzUwNSwx
MCBAQCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKl9fc3dpdGNoX3RvKHN0cnVjdCB0CiAJaW50IGNwdSA9
IHNtcF9wcm9jZXNzb3JfaWQoKTsgIAogCXN0cnVjdCB0c3Nfc3RydWN0ICp0c3MgPSAmcGVyX2Nw
dShpbml0X3RzcywgY3B1KTsKIAorCS8qIFRoaXMgbXVzdCBiZSBkb25lIHByaW9yIHRvIGV4YW1p
bmluZyBUU19VU0VERlBVIGluIHRoZSBvdXRnb2luZworCSAgIHRhc2sgKGFuZCBwZXJoYXBzIHNl
dHRpbmcgQ1IwLlRTKSwgc28gdGhhdCBtYXRoX3N0YXRlX3Jlc3RvcmUoKQorCSAgIHdpbGwgc2V0
IFRTX1VTRURGUFUgaW4gdGhlIGNvcnJlY3QgKG5ldykgdGFzayBhZnRlcndhcmRzLiAqLworCXdy
aXRlX3BkYShwY3VycmVudCwgbmV4dF9wKTsKIAl1bmxhenlfZnB1KHByZXZfcCk7CiAKIAkvKgpA
QCAtNTY0LDExICs1NjgsMTAgQEAgc3RydWN0IHRhc2tfc3RydWN0ICpfX3N3aXRjaF90byhzdHJ1
Y3QgdAogCX0KIAogCS8qIAotCSAqIFN3aXRjaCB0aGUgUERBIGNvbnRleHQuCisJICogU3dpdGNo
IHRoZSByZW1haW5pbmcgUERBIGNvbnRleHQuCiAJICovCiAJcHJldi0+dXNlcnJzcCA9IHJlYWRf
cGRhKG9sZHJzcCk7IAogCXdyaXRlX3BkYShvbGRyc3AsIG5leHQtPnVzZXJyc3ApOyAKLQl3cml0
ZV9wZGEocGN1cnJlbnQsIG5leHRfcCk7IAogCXdyaXRlX3BkYShrZXJuZWxzdGFjaywgKHVuc2ln
bmVkIGxvbmcpbmV4dF9wLT50aHJlYWRfaW5mbyArIFRIUkVBRF9TSVpFIC0gUERBX1NUQUNLT0ZG
U0VUKTsKIAogCS8qCg==

--=__Part22001E7F.1__=--
