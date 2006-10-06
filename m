Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWJFJoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWJFJoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWJFJoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:44:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:45395 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932147AbWJFJop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:44:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=c7Z4MzUOwyORutkRyufMcwWljg6QvzWZWz/BIuwfD1iRErtJ1Mpe0dKuW9WphyrqM+LtuzTGuWq2lL3nuImDVArB0hs3XZDx9OPFs7lnDApFTS19hPoHcjLf7HCSyStzWa79JWCxvGvogGqVM8+cx86yt0d+DM/WDJwpte/lr6A=
Message-ID: <cc723f590610060244x45d482b3v9a645bc1406ae21a@mail.gmail.com>
Date: Fri, 6 Oct 2006 15:14:44 +0530
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] lockdep-design.txt
In-Reply-To: <cc723f590610050859l11cdf15cmbfad829872d086e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_30695_30866055.1160127884117"
References: <cc723f590610050859l11cdf15cmbfad829872d086e4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_30695_30866055.1160127884117
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ingo,

I was looking at lockdep-desing.txt and i guess i am confused with the
changes with respect to fd7bcea35e7efb108c34ee2b3840942a3749cadb. It
says

+   '.'  acquired while irqs enabled
+   '+'  acquired in irq context
+   '-'  acquired in process context with irqs disabled
+   '?'  read-acquired both with irqs enabled and in irq context
+


But the get_usage_chars() function does this for '-'
 if (class->usage_mask & LOCKF_ENABLED_HARDIRQS)
                        *c1 = '-';



So i guess what would be correct would be
'.'  acquired while irqs disabled
'+'  acquired in irq context
'-'  acquired with irqs enabled
'?' read acquired in irq context with irqs enabled.

Is this correct ?

-aneesh

------=_Part_30695_30866055.1160127884117
Content-Type: text/x-patch; name="lockdep-design.txt.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lockdep-design.txt.diff"
X-Attachment-Id: f_esye6l2x

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vbG9ja2RlcC1kZXNpZ24udHh0IGIvRG9jdW1lbnRh
dGlvbi9sb2NrZGVwLWRlc2lnbi50eHQKaW5kZXggZGFiMTIzZC4uNDg4NzczMCAxMDA2NDQKLS0t
IGEvRG9jdW1lbnRhdGlvbi9sb2NrZGVwLWRlc2lnbi50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9s
b2NrZGVwLWRlc2lnbi50eHQKQEAgLTUwLDEwICs1MCwxMCBAQCBUaGUgYml0IHBvc2l0aW9uIGlu
ZGljYXRlcyBoYXJkaXJxLCBzb2Z0CiBzb2Z0aXJxLXJlYWQgcmVzcGVjdGl2ZWx5LCBhbmQgdGhl
IGNoYXJhY3RlciBkaXNwbGF5ZWQgaW4gZWFjaAogaW5kaWNhdGVzOgogCi0gICAnLicJIGFjcXVp
cmVkIHdoaWxlIGlycXMgZW5hYmxlZAorICAgJy4nICBhY3F1aXJlZCB3aGlsZSBpcnFzIGRpc2Fi
bGVkCiAgICAnKycgIGFjcXVpcmVkIGluIGlycSBjb250ZXh0Ci0gICAnLScgIGFjcXVpcmVkIGlu
IHByb2Nlc3MgY29udGV4dCB3aXRoIGlycXMgZGlzYWJsZWQKLSAgICc/JyAgcmVhZC1hY3F1aXJl
ZCBib3RoIHdpdGggaXJxcyBlbmFibGVkIGFuZCBpbiBpcnEgY29udGV4dAorICAgJy0nICBhY3F1
aXJlZCB3aXRoIGlycXMgZW5hYmxlZAorICAgJz8nIHJlYWQgYWNxdWlyZWQgaW4gaXJxIGNvbnRl
eHQgd2l0aCBpcnFzIGVuYWJsZWQuCiAKIFVudXNlZCBtdXRleGVzIGNhbm5vdCBiZSBwYXJ0IG9m
IHRoZSBjYXVzZSBvZiBhbiBlcnJvci4KIAo=
------=_Part_30695_30866055.1160127884117--
