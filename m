Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVEPBJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVEPBJC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 21:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEPBJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 21:09:02 -0400
Received: from fmr19.intel.com ([134.134.136.18]:11466 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261207AbVEPBIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 21:08:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C559B3.D3672E87"
Subject: [PATCH] Haunted spurious interrupt
Date: Mon, 16 May 2005 09:07:25 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E8402142C6A@pdsmsx404>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Haunted spurious interrupt
Thread-Index: AcVZs59eJ4x7ieyoQYGNwkAE8aiIeA==
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 16 May 2005 01:08:53.0431 (UTC) FILETIME=[D39E4470:01C559B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C559B3.D3672E87
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On my IA64 machine, after kernel 2.6.12-rc3 boots, an edge-triggered
interrupt (IRQ 46) keeps triggered over and over again. There is no IRQ
46 interrupt action handler. It has lots of impact on performance.
Kernel 2.6.10 and its prior versions have no the problem. Basically,
kernel 2.6.10 will mask the spurious edge interrupt if the interrupt is
triggered for the second time and its status includes
IRQ_DISABLE|IRQ_PENDING. Originally, IA64 kernel has its own specific
_irq_desc definitions in file arch/ia64/kernel/irq.c. The definition
initiates _irq_desc[irq].status to IRQ_DISABLE. Since kernel 2.6.11, it
was moved to architecture independent codes, i.e. kernel/irq/handle.c,
but kernel/irq/handle.c initiates _irq_desc[irq].status to 0 instead of
IRQ_DISABLE.

The attachment is a patch against kernel 2.6.12-rc3. I tested it on my
IA64 and IA32 machines.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

 <<haunted_interrupt_2.6.12-rc3.patch>>=20

------_=_NextPart_001_01C559B3.D3672E87
Content-Type: application/octet-stream;
	name="haunted_interrupt_2.6.12-rc3.patch"
Content-Transfer-Encoding: base64
Content-Description: haunted_interrupt_2.6.12-rc3.patch
Content-Disposition: attachment;
	filename="haunted_interrupt_2.6.12-rc3.patch"

ZGlmZiAtTnJhdXAgbGludXgtMi42LjEyLXJjMy9rZXJuZWwvaXJxL2hhbmRsZS5jIGxpbnV4LTIu
Ni4xMi1yYzNfZml4L2tlcm5lbC9pcnEvaGFuZGxlLmMKLS0tIGxpbnV4LTIuNi4xMi1yYzMva2Vy
bmVsL2lycS9oYW5kbGUuYwkyMDA1LTA0LTIyIDAwOjI0OjQwLjAwMDAwMDAwMCArMDgwMAorKysg
bGludXgtMi42LjEyLXJjM19maXgva2VybmVsL2lycS9oYW5kbGUuYwkyMDA1LTA1LTEyIDEyOjIx
OjE0LjkzNDMzMjc1NiArMDgwMApAQCAtMzAsNiArMzAsNyBAQAogICovCiBpcnFfZGVzY190IGly
cV9kZXNjW05SX0lSUVNdIF9fY2FjaGVsaW5lX2FsaWduZWQgPSB7CiAJWzAgLi4uIE5SX0lSUVMt
MV0gPSB7CisJCS5zdGF0dXMgPSBJUlFfRElTQUJMRUQsCiAJCS5oYW5kbGVyID0gJm5vX2lycV90
eXBlLAogCQkubG9jayA9IFNQSU5fTE9DS19VTkxPQ0tFRAogCX0K

------_=_NextPart_001_01C559B3.D3672E87--
