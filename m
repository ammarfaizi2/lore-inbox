Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757960AbWK3Gow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757960AbWK3Gow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 01:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758001AbWK3Gow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 01:44:52 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:30922 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1757960AbWK3Gov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 01:44:51 -0500
Message-ID: <456E7DE2.5070808@vmware.com>
Date: Wed, 29 Nov 2006 22:44:50 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: caglar@pardus.org.tr
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Gerd Hoffmann <kraxel@suse.de>, Andrew Morton <akpm@osdl.org>,
       Daniel Hecht <dhecht@vmware.com>, Sahil Rihan <srihan@vmware.com>,
       Trampus Richmond <trampus@vmware.com>, betts@vmware.com
Subject: Fix for OpenSUSE kernel bug (was Re: [Opps] Invalid opcode)
References: <200611051507.37196.caglar@pardus.org.tr> <200611051740.47191.ak@suse.de> <200611051917.56971.caglar@pardus.org.tr>
In-Reply-To: <200611051917.56971.caglar@pardus.org.tr>
Content-Type: multipart/mixed;
 boundary="------------020007030106080109000809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020007030106080109000809
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

S.Çağlar Onur wrote:
> 05 Kas 2006 Paz 18:40 tarihinde, Andi Kleen şunları yazmıştı: 
>   
>> How do you know this?
>>     
>
> Just guessing, if im not wrong panics occur after SMP alternative switching 
> code done its job.
>
>   
>> And does it still happen in 2.6.19-rc4?
>>     
>
> Will try
>
>   
>>> in VmWare and Microsoft Virtual
>>> PC and in order to confirm this bug is not our distro specific i
>>> downloaded and tried latest OpenSuse also [1]  and [2] are screens
>>> captured by vmware but exact same panic occurs in Virtual PC as reported
>>> to us in [3].
>>>       
>> Always the same BUG()?
>>     
>
> Yes, same bug
>
>   
>> There is just some rolling Turkish text there.
>>     
>
> Ah im sorry here is the correct links :(
>
> [1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/panic_on_opensuse.png
> [2] http://cekirdek.pardus.org.tr/~caglar/2.6.18/panic_on_pardus.png
>
> Cheers
>   

I'm proposing this as a fix for your bug. Having tasklets scheduled 
before softirqd gets to run might be somewhat backwards, but there is 
nothing I can find wrong about it from a correctness point of view. 
Better to boot the kernel even when compiled with bug checking on, I think.

This bug started becoming apparent in 2.6.18 because of some rework with 
the CPU hotplug code, but in theory, it exists at least all the way back 
to 2.6.10, which is as far as I looked backwards in time.

Zach

--------------020007030106080109000809
Content-Type: text/plain;
 name="fix-softirq-race"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fix-softirq-race"

SXQgaXMgcG9zc2libGUgdG8gaGF2ZSB0YXNrbGV0cyBnZXQgc2NoZWR1bGVkIGJlZm9yZSBz
b2Z0aXJxZCBoYXMgaGFkCmEgY2hhbmNlIHRvIHNwYXduIG9uIGFsbCBDUFVzLiAgVGhpcyBp
cyB0b3RhbGx5IGhhcm1sZXNzOyBhZnRlciBzdWNjZXNzCmR1cmluZyBhY3Rpb24gQ1BVX1VQ
X1BSRVBBUkUsIGFjdGlvbiBDUFVfT05MSU5FIHdpbGwgYmUgY2FsbGVkLCB3aGljaAppbW1l
ZGlhdGVseSB3YWtlcyBzb2Z0aXJxZCBvbiB0aGUgYXBwcm9wcmlhdGUgQ1BVIHRvIHByb2Nl
c3MgdGhlIGFscmVhZHkKcGVuZGluZyB0YXNrbGV0cy4gIFNvIHRoZXJlIGlzIG5vIGRhbmdl
ciBvZiBoYXZpbmcgYSBtaXNzZWQgd2FrZXVwIGZvcgphbnkgdGFza2xldHMgdGhhdCB3ZXJl
IGFscmVhZHkgcGVuZGluZy4KCkluIHBhcnRpY3VsYXIsIGkzODYgaXMgYWZmZWN0ZWQgYnkg
dGhpcyBkdXJpbmcgc3RhcnR1cCwgYW5kIGlzIHZpc2libGUgd2hlbgp1c2luZyBhIHZlcnkg
bGFyZ2UgaW5pdHJkOyBkdXJpbmcgdGhlIHRpbWUgaXQgdGFrZXMgZm9yIHRoZSBpbml0cmQg
dG8gYmUKZGVjb21wcmVzc2VkLCBhIHRpbWVyIElSUSBjYW4gY29tZSBpbiBhbmQgc2NoZWR1
bGUgUkNVIGNhbGxiYWNrcy4gIEl0IGlzIGFsc28KcG9zc2libGUgdGhhdCByZXNlbmRpbmcg
b2YgYSBoYXJkd2FyZSBJUlEgdmlhIGEgc29mdGlycSB0cmlnZ2VycyB0aGUgc2FtZSBidWcu
CgpCZWNhdXNlIG9mIGRpZmZlcmVudCB0aW1pbmcgY29uZGl0aW9ucywgdGhpcyBzaG93cyB1
cCBpbiBhbGwgZW11bGF0b3JzCmFuZCB2aXJ0dWFsIG1hY2hpbmVzIHRlc3RlZCwgaW5jbHVk
aW5nIFhlbiwgVk13YXJlLCBWaXJ0dWFsIFBDLCBhbmQgUWVtdS4KSXQgaXMgYWxzbyBwb3Nz
aWJsZSB0byB0cmlnZ2VyIG9uIG5hdGl2ZSBoYXJkd2FyZSB3aXRoIGEgbGFyZ2UgZW5vdWdo
IGluaXRyZCwKYWx0aG91Z2ggSSBkb24ndCBoYXZlIGEgcmVsaWFibGUgY2FzZSBkZW1vbnN0
cmF0aW5nIHRoYXQuCgpTaWduZWQtb2ZmLWJ5OiBaYWNoYXJ5IEFtc2RlbiA8emFjaEB2bXdh
cmUuY29tPgoKSW5kZXg6IGxpbnV4LTIuNi4xOC9rZXJuZWwvc29mdGlycS5jCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KLS0tIGxpbnV4LTIuNi4xOC5vcmlnL2tlcm5lbC9zb2Z0aXJxLmMJMjAwNi0xMS0x
MCAxNDo0NDozOS4wMDAwMDAwMDAgLTA4MDAKKysrIGxpbnV4LTIuNi4xOC9rZXJuZWwvc29m
dGlycS5jCTIwMDYtMTEtMjkgMjI6MTk6MzYuMDAwMDAwMDAwIC0wODAwCkBAIC01NzQsOCAr
NTc0LDYgQEAgc3RhdGljIGludCBfX2NwdWluaXQgY3B1X2NhbGxiYWNrKHN0cnVjdAogCiAJ
c3dpdGNoIChhY3Rpb24pIHsKIAljYXNlIENQVV9VUF9QUkVQQVJFOgotCQlCVUdfT04ocGVy
X2NwdSh0YXNrbGV0X3ZlYywgaG90Y3B1KS5saXN0KTsKLQkJQlVHX09OKHBlcl9jcHUodGFz
a2xldF9oaV92ZWMsIGhvdGNwdSkubGlzdCk7CiAJCXAgPSBrdGhyZWFkX2NyZWF0ZShrc29m
dGlycWQsIGhjcHUsICJrc29mdGlycWQvJWQiLCBob3RjcHUpOwogCQlpZiAoSVNfRVJSKHAp
KSB7CiAJCQlwcmludGsoImtzb2Z0aXJxZCBmb3IgJWkgZmFpbGVkXG4iLCBob3RjcHUpOwo=
--------------020007030106080109000809--
