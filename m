Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWGBOKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWGBOKU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 10:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWGBOKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 10:10:20 -0400
Received: from www346.sakura.ne.jp ([202.181.99.66]:49931 "EHLO
	www346.sakura.ne.jp") by vger.kernel.org with ESMTP
	id S1750724AbWGBOKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 10:10:19 -0400
Message-ID: <44A7D349.4040705@ak.jp.nec.com>
Date: Sun, 02 Jul 2006 23:08:09 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, Adrian Bunk <bunk@stusta.de>,
       jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: Re: unused fs/jffs2/acl.c:jffs2_clear_acl()
References: <20060629130133.GC29056@stusta.de> <1151586970.16413.16.camel@pmac.infradead.org> <44A3E354.6050001@ak.jp.nec.com>
In-Reply-To: <44A3E354.6050001@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------080700000005090906070101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080700000005090906070101
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

[JFFS2][XATTR] Fix memory leak in POSIX-ACL support

* jffs2-xattr-v6.2-02-fix-posix_acl-memory-leak.patch

jffs2_clear_acl() which releases acl caches allocated by kmalloc()
was defined but it was never called. Thus, we faced to the risk
of memory leaking.

This patch plugs jffs2_clear_acl() into jffs2_do_clear_inode().
It ensures to release acl cache when inode is cleared.

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

Thanks,

KaiGai Kohei wrote:
> David Woodhouse wrote:
> 
>>On Thu, 2006-06-29 at 15:01 +0200, Adrian Bunk wrote:
>>
>>
>>>it might not have been intended that jffs2_clear_acl() in Linus' tree
>>>is unused?
>>
>>
>>I suspect you're right -- thanks for pointing it out.
>>
>>Kaigai-san?
> 
> 
> I'm sorry, it's a serious BUG.
> When an inode is cleared, jffs2_clear_acl() should be called
> to release on-memory ACL. Because the current implementation
> didn't care about this cleaning-up, we have memory-leaking.
> 
> Please wait a patch for a while.
> 
> Thanks,

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------080700000005090906070101
Content-Type: text/plain;
 name="jffs2-xattr-v6.2-02-fix-posix_acl-memory-leak.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="jffs2-xattr-v6.2-02-fix-posix_acl-memory-leak.patch"

ZGlmZiAtLWdpdCBhL2ZzL2pmZnMyL2FjbC5jIGIvZnMvamZmczIvYWNsLmMKaW5kZXggOWMy
MDc3ZS4uMGFlM2NkMSAxMDA2NDQKLS0tIGEvZnMvamZmczIvYWNsLmMKKysrIGIvZnMvamZm
czIvYWNsLmMKQEAgLTM0NSwxMCArMzQ1LDggQEAgaW50IGpmZnMyX2luaXRfYWNsKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIAogCXJldHVybiByYzsKIH0KIAotdm9pZCBqZmZzMl9jbGVhcl9h
Y2woc3RydWN0IGlub2RlICppbm9kZSkKK3ZvaWQgamZmczJfY2xlYXJfYWNsKHN0cnVjdCBq
ZmZzMl9pbm9kZV9pbmZvICpmKQogewotCXN0cnVjdCBqZmZzMl9pbm9kZV9pbmZvICpmID0g
SkZGUzJfSU5PREVfSU5GTyhpbm9kZSk7Ci0KIAlpZiAoZi0+aV9hY2xfYWNjZXNzICYmIGYt
PmlfYWNsX2FjY2VzcyAhPSBKRkZTMl9BQ0xfTk9UX0NBQ0hFRCkgewogCQlwb3NpeF9hY2xf
cmVsZWFzZShmLT5pX2FjbF9hY2Nlc3MpOwogCQlmLT5pX2FjbF9hY2Nlc3MgPSBKRkZTMl9B
Q0xfTk9UX0NBQ0hFRDsKZGlmZiAtLWdpdCBhL2ZzL2pmZnMyL2FjbC5oIGIvZnMvamZmczIv
YWNsLmgKaW5kZXggODg5M2JkMS4uZmEzMjdkYiAxMDA2NDQKLS0tIGEvZnMvamZmczIvYWNs
LmgKKysrIGIvZnMvamZmczIvYWNsLmgKQEAgLTMwLDcgKzMwLDcgQEAgI2RlZmluZSBKRkZT
Ml9BQ0xfTk9UX0NBQ0hFRCAoKHZvaWQgKiktMQogZXh0ZXJuIGludCBqZmZzMl9wZXJtaXNz
aW9uKHN0cnVjdCBpbm9kZSAqLCBpbnQsIHN0cnVjdCBuYW1laWRhdGEgKik7CiBleHRlcm4g
aW50IGpmZnMyX2FjbF9jaG1vZChzdHJ1Y3QgaW5vZGUgKik7CiBleHRlcm4gaW50IGpmZnMy
X2luaXRfYWNsKHN0cnVjdCBpbm9kZSAqLCBzdHJ1Y3QgaW5vZGUgKik7Ci1leHRlcm4gdm9p
ZCBqZmZzMl9jbGVhcl9hY2woc3RydWN0IGlub2RlICopOworZXh0ZXJuIHZvaWQgamZmczJf
Y2xlYXJfYWNsKHN0cnVjdCBqZmZzMl9pbm9kZV9pbmZvICopOwogCiBleHRlcm4gc3RydWN0
IHhhdHRyX2hhbmRsZXIgamZmczJfYWNsX2FjY2Vzc194YXR0cl9oYW5kbGVyOwogZXh0ZXJu
IHN0cnVjdCB4YXR0cl9oYW5kbGVyIGpmZnMyX2FjbF9kZWZhdWx0X3hhdHRyX2hhbmRsZXI7
CkBAIC00MCw2ICs0MCw2IEBAICNlbHNlCiAjZGVmaW5lIGpmZnMyX3Blcm1pc3Npb24gTlVM
TAogI2RlZmluZSBqZmZzMl9hY2xfY2htb2QoaW5vZGUpCQkoMCkKICNkZWZpbmUgamZmczJf
aW5pdF9hY2woaW5vZGUsZGlyKQkoMCkKLSNkZWZpbmUgamZmczJfY2xlYXJfYWNsKGlub2Rl
KQorI2RlZmluZSBqZmZzMl9jbGVhcl9hY2woZikKIAogI2VuZGlmCS8qIENPTkZJR19KRkZT
Ml9GU19QT1NJWF9BQ0wgKi8KZGlmZiAtLWdpdCBhL2ZzL2pmZnMyL3JlYWRpbm9kZS5jIGIv
ZnMvamZmczIvcmVhZGlub2RlLmMKaW5kZXggY2MxODk5Mi4uMjY2NDIzYiAxMDA2NDQKLS0t
IGEvZnMvamZmczIvcmVhZGlub2RlLmMKKysrIGIvZnMvamZmczIvcmVhZGlub2RlLmMKQEAg
LTk2OCw2ICs5NjgsNyBAQCB2b2lkIGpmZnMyX2RvX2NsZWFyX2lub2RlKHN0cnVjdCBqZmZz
Ml9zCiAJc3RydWN0IGpmZnMyX2Z1bGxfZGlyZW50ICpmZCwgKmZkczsKIAlpbnQgZGVsZXRl
ZDsKIAorCWpmZnMyX2NsZWFyX2FjbChmKTsKIAlqZmZzMl94YXR0cl9kZWxldGVfaW5vZGUo
YywgZi0+aW5vY2FjaGUpOwogCWRvd24oJmYtPnNlbSk7CiAJZGVsZXRlZCA9IGYtPmlub2Nh
Y2hlICYmICFmLT5pbm9jYWNoZS0+bmxpbms7Cg==
--------------080700000005090906070101--
