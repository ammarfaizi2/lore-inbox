Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWJQPeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWJQPeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWJQPeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:34:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:10113 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751149AbWJQPes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:34:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=jg8TGpMoAN45HVyAQ014L6orTAe11s5mnph4kO66fiLSP8GYV0XCnmhbBQfuBpUx0GAbmhcZHLZT+z/AtR9zTj8VzJgs4aTr+sM2Ri1RezfMoGQY9LxvNmW8LNoNW0ni0QFtGIZNj0v3TvXVWLddwTeYdfeqIMBAID/mBIymR6I=
Message-ID: <86802c440610170834q5921908u5bcd7c2cb4b78dd5@mail.gmail.com>
Date: Tue, 17 Oct 2006 08:34:47 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
Subject: Re: [PATCH] x86_64: store Socket ID in phys_proc_id
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA412D6E3@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_98416_30282581.1161099287030"
References: <5986589C150B2F49A46483AC44C7BCA412D6E3@ssvlexmb2.amd.com>
X-Google-Sender-Auth: 3f01ef9e650977b6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_98416_30282581.1161099287030
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Current code store phys_proc_id with init APIC ID, and later will change
to apicid>>bits.

So for the apic id lifted system, for example BSP with apicid 0x10, the
phys_proc_id will be 8.

This patch use initial APIC ID to get Socket ID.

It also removed ht_nodeid calculating, because We already have correct
socket id for sure.

Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

------=_Part_98416_30282581.1161099287030
Content-Type: text/x-patch; name=setup_c.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etegesdr
Content-Disposition: attachment; filename="setup_c.diff"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9zZXR1cC5jIGIvYXJjaC94ODZfNjQva2Vy
bmVsL3NldHVwLmMKaW5kZXggZmM5NDRiNS4uZDMwZjc4YSAxMDA2NDQKLS0tIGEvYXJjaC94ODZf
NjQva2VybmVsL3NldHVwLmMKKysrIGIvYXJjaC94ODZfNjQva2VybmVsL3NldHVwLmMKQEAgLTY0
MywzNCArNjQzLDIwIEBAICNlbmRpZgogCiAJLyogTG93IG9yZGVyIGJpdHMgZGVmaW5lIHRoZSBj
b3JlIGlkIChpbmRleCBvZiBjb3JlIGluIHNvY2tldCkgKi8KIAljLT5jcHVfY29yZV9pZCA9IGMt
PnBoeXNfcHJvY19pZCAmICgoMSA8PCBiaXRzKS0xKTsKLQkvKiBDb252ZXJ0IHRoZSBBUElDIElE
IGludG8gdGhlIHNvY2tldCBJRCAqLwotCWMtPnBoeXNfcHJvY19pZCA9IHBoeXNfcGtnX2lkKGJp
dHMpOworCS8qIENvbnZlcnQgdGhlIGluaXRpYWwgQVBJQyBJRCBpbnRvIHRoZSBzb2NrZXQgSUQg
Ki8KKwljLT5waHlzX3Byb2NfaWQgPj49IGJpdHM7IAogCiAjaWZkZWYgQ09ORklHX05VTUEKICAg
CW5vZGUgPSBjLT5waHlzX3Byb2NfaWQ7CiAgCWlmIChhcGljaWRfdG9fbm9kZVthcGljaWRdICE9
IE5VTUFfTk9fTk9ERSkKICAJCW5vZGUgPSBhcGljaWRfdG9fbm9kZVthcGljaWRdOwogIAlpZiAo
IW5vZGVfb25saW5lKG5vZGUpKSB7Ci0gCQkvKiBUd28gcG9zc2liaWxpdGllcyBoZXJlOgotIAkJ
ICAgLSBUaGUgQ1BVIGlzIG1pc3NpbmcgbWVtb3J5IGFuZCBubyBub2RlIHdhcyBjcmVhdGVkLgot
IAkJICAgSW4gdGhhdCBjYXNlIHRyeSBwaWNraW5nIG9uZSBmcm9tIGEgbmVhcmJ5IENQVQotIAkJ
ICAgLSBUaGUgQVBJQyBJRHMgZGlmZmVyIGZyb20gdGhlIEh5cGVyVHJhbnNwb3J0IG5vZGUgSURz
Ci0gCQkgICB3aGljaCB0aGUgSzggbm9ydGhicmlkZ2UgcGFyc2luZyBmaWxscyBpbi4KLSAJCSAg
IEFzc3VtZSB0aGV5IGFyZSBhbGwgaW5jcmVhc2VkIGJ5IGEgY29uc3RhbnQgb2Zmc2V0LAotIAkJ
ICAgYnV0IGluIHRoZSBzYW1lIG9yZGVyIGFzIHRoZSBIVCBub2RlaWRzLgotIAkJICAgSWYgdGhh
dCBkb2Vzbid0IHJlc3VsdCBpbiBhIHVzYWJsZSBub2RlIGZhbGwgYmFjayB0byB0aGUKLSAJCSAg
IHBhdGggZm9yIHRoZSBwcmV2aW91cyBjYXNlLiAgKi8KLSAJCWludCBodF9ub2RlaWQgPSBhcGlj
aWQgLSAoY3B1X2RhdGFbMF0ucGh5c19wcm9jX2lkIDw8IGJpdHMpOwotIAkJaWYgKGh0X25vZGVp
ZCA+PSAwICYmCi0gCQkgICAgYXBpY2lkX3RvX25vZGVbaHRfbm9kZWlkXSAhPSBOVU1BX05PX05P
REUpCi0gCQkJbm9kZSA9IGFwaWNpZF90b19ub2RlW2h0X25vZGVpZF07CiAgCQkvKiBQaWNrIGEg
bmVhcmJ5IG5vZGUgKi8KLSAJCWlmICghbm9kZV9vbmxpbmUobm9kZSkpCi0gCQkJbm9kZSA9IG5l
YXJieV9ub2RlKGFwaWNpZCk7CisJCW5vZGUgPSBuZWFyYnlfbm9kZShhcGljaWQpOwogIAl9CiAJ
bnVtYV9zZXRfbm9kZShjcHUsIG5vZGUpOwogCi0JcHJpbnRrKEtFUk5fSU5GTyAiQ1BVICVkLyV4
IC0+IE5vZGUgJWRcbiIsIGNwdSwgYXBpY2lkLCBub2RlKTsKKwlwcmludGsoS0VSTl9JTkZPICJD
UFUgJWQvMHglMDJ4IC0+IE5vZGUgJWRcbiIsIGNwdSwgYXBpY2lkLCBub2RlKTsKICNlbmRpZgog
I2VuZGlmCiB9CkBAIC05MjgsNyArOTE0LDcgQEAgdm9pZCBfX2NwdWluaXQgZWFybHlfaWRlbnRp
ZnlfY3B1KHN0cnVjdAogCX0KIAogI2lmZGVmIENPTkZJR19TTVAKLQljLT5waHlzX3Byb2NfaWQg
PSAoY3B1aWRfZWJ4KDEpID4+IDI0KSAmIDB4ZmY7CisJYy0+cGh5c19wcm9jX2lkID0gKGNwdWlk
X2VieCgxKSA+PiAyNCkgJiAweGZmOyAvKiBpbml0aWFsIEFQSUMgSUQgKi8KICNlbmRpZgogfQog
CkBAIC0xMTM2LDYgKzExMjIsNyBAQCAjZW5kaWYKICNpZmRlZiBDT05GSUdfU01QCiAJaWYgKHNt
cF9udW1fc2libGluZ3MgKiBjLT54ODZfbWF4X2NvcmVzID4gMSkgewogCQlpbnQgY3B1ID0gYyAt
IGNwdV9kYXRhOworCQlzZXFfcHJpbnRmKG0sICJhcGljIGlkXHRcdDogMHglMDJ4XG4iLCB4ODZf
Y3B1X3RvX2FwaWNpZFtjcHVdKTsKIAkJc2VxX3ByaW50ZihtLCAicGh5c2ljYWwgaWRcdDogJWRc
biIsIGMtPnBoeXNfcHJvY19pZCk7CiAJCXNlcV9wcmludGYobSwgInNpYmxpbmdzXHQ6ICVkXG4i
LCBjcHVzX3dlaWdodChjcHVfY29yZV9tYXBbY3B1XSkpOwogCQlzZXFfcHJpbnRmKG0sICJjb3Jl
IGlkXHRcdDogJWRcbiIsIGMtPmNwdV9jb3JlX2lkKTsK
------=_Part_98416_30282581.1161099287030--
