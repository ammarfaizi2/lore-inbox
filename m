Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUDOS25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUDOSR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:17:56 -0400
Received: from colino.net ([62.212.100.143]:24054 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S263153AbUDOSLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:11:48 -0400
Date: Thu, 15 Apr 2004 20:11:17 +0200
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sf.net
Subject: 2.6.6-rc1: cdc-acm still (differently) broken
Message-Id: <20040415201117.11524f63@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.4.0; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__15_Apr_2004_20_11_17_+0200_q+VVjoAW0Socb98="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__15_Apr_2004_20_11_17_+0200_q+VVjoAW0Socb98=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

cdc-acm was broken since after 2.6.4, due to the alt_cursetting changes. I sent a patch, which has been integrated (well, the same one has ;-)) not long ago.
I gave 2.6.6-rc1 a try, and found that cdc-acm is now broken is a new way:
when plugging the phone, acm_probe() fails on interface #0; I traced the problem to this: usb_interface_claimed() returns true - and in fact intf->dev.driver is already cdc-acm (despite the fact that this is the first call to acm_probe() !), for reasons beyond my comprehension.

But, even if the interface is claimed, the intfdata hasn't been set, which allows to do another check: the attached patch fixes this bug. 

HTH,
-- 
Colin

--Multipart=_Thu__15_Apr_2004_20_11_17_+0200_q+VVjoAW0Socb98=
Content-Type: application/octet-stream;
 name="cdc-acm.patch"
Content-Disposition: attachment;
 filename="cdc-acm.patch"
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvdXNiL2NsYXNzL2NkYy1hY20uYy5vcmlnCTIwMDQtMDQtMTUgMjA6MDQ6NDcu
MDUxMTQ1MTQ0ICswMjAwCisrKyBkcml2ZXJzL3VzYi9jbGFzcy9jZGMtYWNtLmMJMjAwNC0wNC0x
NSAyMDowNTo1Mi40MTkyMDc2ODggKzAyMDAKQEAgLTU4NSw3ICs1ODUsOCBAQAogCiAJCWZvciAo
aiA9IDA7IGogPCBjZmFjbS0+ZGVzYy5iTnVtSW50ZXJmYWNlcyAtIDE7IGorKykgewogCQkgICAg
Ci0JCQlpZiAodXNiX2ludGVyZmFjZV9jbGFpbWVkKGNmYWNtLT5pbnRlcmZhY2Vbal0pIHx8CisJ
CQlpZiAoKHVzYl9pbnRlcmZhY2VfY2xhaW1lZChjZmFjbS0+aW50ZXJmYWNlW2pdKSAKKwkJCQkm
JiB1c2JfZ2V0X2ludGZkYXRhKGNmYWNtLT5pbnRlcmZhY2Vbal0pICE9IE5VTEwgKSB8fAogCQkJ
ICAgIHVzYl9pbnRlcmZhY2VfY2xhaW1lZChjZmFjbS0+aW50ZXJmYWNlW2ogKyAxXSkpCiAJCQkJ
Y29udGludWU7CiAK

--Multipart=_Thu__15_Apr_2004_20_11_17_+0200_q+VVjoAW0Socb98=--
