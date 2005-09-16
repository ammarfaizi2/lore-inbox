Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVIPX7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVIPX7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVIPX7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:59:55 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:52654 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750751AbVIPX7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:59:54 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 16 Sep 2005 16:56:53 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Fix epoll delayed initialization bug ...
In-Reply-To: <20050916165053.2dec0a6b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0509161655240.6125@localhost.localdomain>
References: <Pine.LNX.4.63.0509161621050.6125@localhost.localdomain>
 <20050916165053.2dec0a6b.akpm@osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1689195616-1126915013=:6125"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1689195616-1126915013=:6125
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Fri, 16 Sep 2005, Andrew Morton wrote:

> Davide Libenzi <davidel@xmailserver.org> wrote:
>>
>> diff -Nru linux-2.6.13.vanilla/fs/eventpoll.c linux-2.6.13/fs/eventpoll.c
>>  --- linux-2.6.13.vanilla/fs/eventpoll.c	2005-09-16 15:20:46.000000000 -0700
>>  +++ linux-2.6.13/fs/eventpoll.c	2005-09-16 15:21:08.000000000 -0700
>>  @@ -231,8 +231,9 @@
>>
>>    static void ep_poll_safewake_init(struct poll_safewake *psw);
>>    static void ep_poll_safewake(struct poll_safewake *psw, wait_queue_head_t *wq);
>>  -static int ep_getfd(int *efd, struct inode **einode, struct file **efile);
>>  -static int ep_file_init(struct file *file);
>>  +static int ep_getfd(int *efd, struct inode **einode, struct file **efile,
>>  +		    struct eventpoll *ep);
>>  +static int ep_alloc(struct eventpoll **pep);
>
> Sigh.  Space-stuffing strikes again.  Please resend as an attachment.
>
> The number of whitespace-buggered patches which are coming in is just
> getting out of control lately.
>
> Even `patch -l' tossed four rejects, so there may be something else wrong
> in this one.

My side or your side? Anyway, see if the one attached merges cleanly ...


- Davide

--8323328-1689195616-1126915013=:6125
Content-Type: TEXT/plain; charset=US-ASCII; name=epoll-viromatic-presetup-fix.diff
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=epoll-viromatic-presetup-fix.diff

ZGlmZiAtTnJ1IGxpbnV4LTIuNi4xMy52YW5pbGxhL2ZzL2V2ZW50cG9sbC5j
IGxpbnV4LTIuNi4xMy9mcy9ldmVudHBvbGwuYw0KLS0tIGxpbnV4LTIuNi4x
My52YW5pbGxhL2ZzL2V2ZW50cG9sbC5jCTIwMDUtMDktMTYgMTU6MjA6NDYu
MDAwMDAwMDAwIC0wNzAwDQorKysgbGludXgtMi42LjEzL2ZzL2V2ZW50cG9s
bC5jCTIwMDUtMDktMTYgMTU6MjE6MDguMDAwMDAwMDAwIC0wNzAwDQpAQCAt
MjMxLDggKzIzMSw5IEBADQogDQogc3RhdGljIHZvaWQgZXBfcG9sbF9zYWZl
d2FrZV9pbml0KHN0cnVjdCBwb2xsX3NhZmV3YWtlICpwc3cpOw0KIHN0YXRp
YyB2b2lkIGVwX3BvbGxfc2FmZXdha2Uoc3RydWN0IHBvbGxfc2FmZXdha2Ug
KnBzdywgd2FpdF9xdWV1ZV9oZWFkX3QgKndxKTsNCi1zdGF0aWMgaW50IGVw
X2dldGZkKGludCAqZWZkLCBzdHJ1Y3QgaW5vZGUgKiplaW5vZGUsIHN0cnVj
dCBmaWxlICoqZWZpbGUpOw0KLXN0YXRpYyBpbnQgZXBfZmlsZV9pbml0KHN0
cnVjdCBmaWxlICpmaWxlKTsNCitzdGF0aWMgaW50IGVwX2dldGZkKGludCAq
ZWZkLCBzdHJ1Y3QgaW5vZGUgKiplaW5vZGUsIHN0cnVjdCBmaWxlICoqZWZp
bGUsDQorCQkgICAgc3RydWN0IGV2ZW50cG9sbCAqZXApOw0KK3N0YXRpYyBp
bnQgZXBfYWxsb2Moc3RydWN0IGV2ZW50cG9sbCAqKnBlcCk7DQogc3RhdGlj
IHZvaWQgZXBfZnJlZShzdHJ1Y3QgZXZlbnRwb2xsICplcCk7DQogc3RhdGlj
IHN0cnVjdCBlcGl0ZW0gKmVwX2ZpbmQoc3RydWN0IGV2ZW50cG9sbCAqZXAs
IHN0cnVjdCBmaWxlICpmaWxlLCBpbnQgZmQpOw0KIHN0YXRpYyB2b2lkIGVw
X3VzZV9lcGl0ZW0oc3RydWN0IGVwaXRlbSAqZXBpKTsNCkBAIC01MDEsMzgg
KzUwMiwzNyBAQA0KIGFzbWxpbmthZ2UgbG9uZyBzeXNfZXBvbGxfY3JlYXRl
KGludCBzaXplKQ0KIHsNCiAJaW50IGVycm9yLCBmZDsNCisJc3RydWN0IGV2
ZW50cG9sbCAqZXA7DQogCXN0cnVjdCBpbm9kZSAqaW5vZGU7DQogCXN0cnVj
dCBmaWxlICpmaWxlOw0KIA0KIAlETlBSSU5USygzLCAoS0VSTl9JTkZPICJb
JXBdIGV2ZW50cG9sbDogc3lzX2Vwb2xsX2NyZWF0ZSglZClcbiIsDQogCQkg
ICAgIGN1cnJlbnQsIHNpemUpKTsNCiANCi0JLyogU2FuaXR5IGNoZWNrIG9u
IHRoZSBzaXplIHBhcmFtZXRlciAqLw0KKwkvKg0KKwkgKiBTYW5pdHkgY2hl
Y2sgb24gdGhlIHNpemUgcGFyYW1ldGVyLCBhbmQgY3JlYXRlIHRoZSBpbnRl
cm5hbCBkYXRhDQorCSAqIHN0cnVjdHVyZSAoICJzdHJ1Y3QgZXZlbnRwb2xs
IiApLg0KKwkgKi8NCiAJZXJyb3IgPSAtRUlOVkFMOw0KLQlpZiAoc2l6ZSA8
PSAwKQ0KKwlpZiAoc2l6ZSA8PSAwIHx8IChlcnJvciA9IGVwX2FsbG9jKCZl
cCkpICE9IDApDQogCQlnb3RvIGVleGl0XzE7DQogDQogCS8qDQogCSAqIENy
ZWF0ZXMgYWxsIHRoZSBpdGVtcyBuZWVkZWQgdG8gc2V0dXAgYW4gZXZlbnRw
b2xsIGZpbGUuIFRoYXQgaXMsDQogCSAqIGEgZmlsZSBzdHJ1Y3R1cmUsIGFu
ZCBpbm9kZSBhbmQgYSBmcmVlIGZpbGUgZGVzY3JpcHRvci4NCiAJICovDQot
CWVycm9yID0gZXBfZ2V0ZmQoJmZkLCAmaW5vZGUsICZmaWxlKTsNCi0JaWYg
KGVycm9yKQ0KLQkJZ290byBlZXhpdF8xOw0KLQ0KLQkvKiBTZXR1cCB0aGUg
ZmlsZSBpbnRlcm5hbCBkYXRhIHN0cnVjdHVyZSAoICJzdHJ1Y3QgZXZlbnRw
b2xsIiApICovDQotCWVycm9yID0gZXBfZmlsZV9pbml0KGZpbGUpOw0KKwll
cnJvciA9IGVwX2dldGZkKCZmZCwgJmlub2RlLCAmZmlsZSwgZXApOw0KIAlp
ZiAoZXJyb3IpDQogCQlnb3RvIGVleGl0XzI7DQogDQotDQogCUROUFJJTlRL
KDMsIChLRVJOX0lORk8gIlslcF0gZXZlbnRwb2xsOiBzeXNfZXBvbGxfY3Jl
YXRlKCVkKSA9ICVkXG4iLA0KIAkJICAgICBjdXJyZW50LCBzaXplLCBmZCkp
Ow0KIA0KIAlyZXR1cm4gZmQ7DQogDQogZWV4aXRfMjoNCi0Jc3lzX2Nsb3Nl
KGZkKTsNCisJZXBfZnJlZShlcCk7DQorCWtmcmVlKGVwKTsNCiBlZXhpdF8x
Og0KIAlETlBSSU5USygzLCAoS0VSTl9JTkZPICJbJXBdIGV2ZW50cG9sbDog
c3lzX2Vwb2xsX2NyZWF0ZSglZCkgPSAlZFxuIiwNCiAJCSAgICAgY3VycmVu
dCwgc2l6ZSwgZXJyb3IpKTsNCkBAIC03MDYsNyArNzA2LDggQEANCiAvKg0K
ICAqIENyZWF0ZXMgdGhlIGZpbGUgZGVzY3JpcHRvciB0byBiZSB1c2VkIGJ5
IHRoZSBlcG9sbCBpbnRlcmZhY2UuDQogICovDQotc3RhdGljIGludCBlcF9n
ZXRmZChpbnQgKmVmZCwgc3RydWN0IGlub2RlICoqZWlub2RlLCBzdHJ1Y3Qg
ZmlsZSAqKmVmaWxlKQ0KK3N0YXRpYyBpbnQgZXBfZ2V0ZmQoaW50ICplZmQs
IHN0cnVjdCBpbm9kZSAqKmVpbm9kZSwgc3RydWN0IGZpbGUgKiplZmlsZSwN
CisJCSAgICBzdHJ1Y3QgZXZlbnRwb2xsICplcCkNCiB7DQogCXN0cnVjdCBx
c3RyIHRoaXM7DQogCWNoYXIgbmFtZVszMl07DQpAQCAtNzU2LDcgKzc1Nyw3
IEBADQogCWZpbGUtPmZfb3AgPSAmZXZlbnRwb2xsX2ZvcHM7DQogCWZpbGUt
PmZfbW9kZSA9IEZNT0RFX1JFQUQ7DQogCWZpbGUtPmZfdmVyc2lvbiA9IDA7
DQotCWZpbGUtPnByaXZhdGVfZGF0YSA9IE5VTEw7DQorCWZpbGUtPnByaXZh
dGVfZGF0YSA9IGVwOw0KIA0KIAkvKiBJbnN0YWxsIHRoZSBuZXcgc2V0dXAg
ZmlsZSBpbnRvIHRoZSBhbGxvY2F0ZWQgZmQuICovDQogCWZkX2luc3RhbGwo
ZmQsIGZpbGUpOw0KQEAgLTc3Nyw3ICs3NzgsNyBAQA0KIH0NCiANCiANCi1z
dGF0aWMgaW50IGVwX2ZpbGVfaW5pdChzdHJ1Y3QgZmlsZSAqZmlsZSkNCitz
dGF0aWMgaW50IGVwX2FsbG9jKHN0cnVjdCBldmVudHBvbGwgKipwZXApDQog
ew0KIAlzdHJ1Y3QgZXZlbnRwb2xsICplcDsNCiANCkBAIC03OTIsOSArNzkz
LDkgQEANCiAJSU5JVF9MSVNUX0hFQUQoJmVwLT5yZGxsaXN0KTsNCiAJZXAt
PnJiciA9IFJCX1JPT1Q7DQogDQotCWZpbGUtPnByaXZhdGVfZGF0YSA9IGVw
Ow0KKwkqcGVwID0gZXA7DQogDQotCUROUFJJTlRLKDMsIChLRVJOX0lORk8g
IlslcF0gZXZlbnRwb2xsOiBlcF9maWxlX2luaXQoKSBlcD0lcFxuIiwNCisJ
RE5QUklOVEsoMywgKEtFUk5fSU5GTyAiWyVwXSBldmVudHBvbGw6IGVwX2Fs
bG9jKCkgZXA9JXBcbiIsDQogCQkgICAgIGN1cnJlbnQsIGVwKSk7DQogCXJl
dHVybiAwOw0KIH0NCg==

--8323328-1689195616-1126915013=:6125--
