Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422804AbWJSIA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbWJSIA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422858AbWJSIA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:00:56 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:2987 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1422804AbWJSIAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:00:55 -0400
Message-ID: <453730B7.3040906@vmware.com>
Date: Thu, 19 Oct 2006 01:00:55 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: caglar@pardus.org.tr, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix potential interrupts during alternative patching [was
 Re: [RFC] Avoid PIT SMP lockups]
References: <1160170736.6140.31.camel@localhost.localdomain> <453404F6.5040202@vmware.com> <200610170121.51492.caglar@pardus.org.tr> <200610171505.53576.caglar@pardus.org.tr>
In-Reply-To: <200610171505.53576.caglar@pardus.org.tr>
Content-Type: multipart/mixed;
 boundary="------------010003010107080908020307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010003010107080908020307
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

S.Çağlar Onur wrote:
> 17 Eki 2006 Sal 01:21 tarihinde, S.Çağlar Onur şunları yazmıştı: 
>   
>> 17 Eki 2006 Sal 01:17 tarihinde, Zachary Amsden şunları yazmıştı:
>>     
>>> My nasty quick patch might not apply - the only tree I've got is a very
>>> hacked 2.6.18-rc6-mm1+local-patches thing, but the fix should be obvious
>>> enough.
>>>       
>> Ok, I'll test and report back...
>>     
>
> Both 2.6.18 and 2.6.18.1 boots without any problem (and of course without 
> noreplacement workarund) with that patch.
>
> Cheers
>   

So this patch is an obvious bugfix - please apply, and to stable as 
well. I'm not sure when this broke, but taking interrupts in the middle 
of self modifying code is not a pretty sight.

Zach

--------------010003010107080908020307
Content-Type: text/plain;
 name="hotfix-alternative-irq-safety.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hotfix-alternative-irq-safety.patch"

SW50ZXJydXB0cyBtdXN0IGJlIGRpc2FibGVkIGR1cmluZyBhbHRlcm5hdGl2ZSBpbnN0cnVj
dGlvbiBwYXRjaGluZy4KT24gc3lzdGVtcyB3aXRoIGhpZ2ggdGltZXIgSVJRIHJhdGVzLCBv
ciB3aGVuIHJ1bm5pbmcgaW4gYW4gZW11bGF0b3IsCnRpbWluZyBkaWZmZXJlbmNlcyBjYW4g
cmVzdWx0IGluIHJhbmRvbSBrZXJuZWwgcGFuaWNzIGJlY2F1c2Ugb2YKcnVubmluZyBwYXJ0
aWFsbHkgcGF0Y2hlZCBpbnN0cnVjdGlvbnMuICBUaGlzIGRvZXNuJ3QgeWV0IGZpeCBOTUlz
LAp3aGljaCByZXF1aXJlcyBleHRyaWNhdGluZyB0aGUgcGF0Y2ggY29kZSBmcm9tIHRoZSBs
YXRlIGJ1ZyBjaGVja2luZwphbmQgaXMgbG9naWNhbGx5IHNlcGFyYXRlIChhbmQgYWxzbyBs
ZXNzIGxpa2VseSB0byBjYXVzZSBwcm9ibGVtcykuCgpTaWduZWQtb2ZmLWJ5OiBaYWNoYXJ5
IEFtc2RlbiA8emFjaEB2bXdhcmUuY29tPgoKCmRpZmYgLXIgNzczYWMwZWJmZWI0IGFyY2gv
aTM4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYwotLS0gYS9hcmNoL2kzODYva2VybmVsL2FsdGVy
bmF0aXZlLmMJV2VkIE9jdCAxOCAwNjowMzo1NiAyMDA2IC0wNzAwCisrKyBiL2FyY2gvaTM4
Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYwlXZWQgT2N0IDE4IDA2OjA3OjAzIDIwMDYgLTA3MDAK
QEAgLTM0NCw2ICszNDQsNyBAQCB2b2lkIGFsdGVybmF0aXZlc19zbXBfc3dpdGNoKGludCBz
bXApCiAKIHZvaWQgX19pbml0IGFsdGVybmF0aXZlX2luc3RydWN0aW9ucyh2b2lkKQogewor
CXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJaWYgKG5vX3JlcGxhY2VtZW50KSB7CiAJCXByaW50
ayhLRVJOX0lORk8gIihTTVAtKWFsdGVybmF0aXZlcyB0dXJuZWQgb2ZmXG4iKTsKIAkJZnJl
ZV9pbml0X3BhZ2VzKCJTTVAgYWx0ZXJuYXRpdmVzIiwKQEAgLTM1MSw2ICszNTIsOCBAQCB2
b2lkIF9faW5pdCBhbHRlcm5hdGl2ZV9pbnN0cnVjdGlvbnModm9pCiAJCQkJKHVuc2lnbmVk
IGxvbmcpX19zbXBfYWx0X2VuZCk7CiAJCXJldHVybjsKIAl9CisKKwlsb2NhbF9pcnFfc2F2
ZShmbGFncyk7CiAJYXBwbHlfYWx0ZXJuYXRpdmVzKF9fYWx0X2luc3RydWN0aW9ucywgX19h
bHRfaW5zdHJ1Y3Rpb25zX2VuZCk7CiAKIAkvKiBzd2l0Y2ggdG8gcGF0Y2gtb25jZS1hdC1i
b290dGltZS1vbmx5IG1vZGUgYW5kIGZyZWUgdGhlCkBAIC0zODYsNCArMzg5LDUgQEAgdm9p
ZCBfX2luaXQgYWx0ZXJuYXRpdmVfaW5zdHJ1Y3Rpb25zKHZvaQogCQlhbHRlcm5hdGl2ZXNf
c21wX3N3aXRjaCgwKTsKIAl9CiAjZW5kaWYKLX0KKwlsb2NhbF9pcnFfcmVzdG9yZShmbGFn
cyk7Cit9Cg==
--------------010003010107080908020307--
