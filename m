Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277068AbRKNRgg>; Wed, 14 Nov 2001 12:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276988AbRKNRg1>; Wed, 14 Nov 2001 12:36:27 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:6062 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S277143AbRKNRgQ>; Wed, 14 Nov 2001 12:36:16 -0500
Date: Wed, 14 Nov 2001 12:52:16 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.15-pre4 fails to build in setup.c
In-Reply-To: <Pine.LNX.4.40.0111141136540.88-200000@rc.priv.hereintown.net>
Message-ID: <Pine.LNX.4.40.0111141246470.88-200000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463805697-1359099639-1005760336=:88"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463805697-1359099639-1005760336=:88
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 14 Nov 2001, Chris Meadors wrote:

> I don't think I've seen this yet.
>
> Build failed with this error:
>
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c
> -o setup.o setup.c
> setup.c: In function `c_start':
> setup.c:2791: subscripted value is neither array nor pointer
> setup.c:2792: warning: control reaches end of non-void function
> make[1]: *** [setup.o] Error 1
> make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2
>
> My "grep ^CONFIG .config" is attatched.
>
> -Chris
>

I'm replying to my own post because I've received serveral off list
replies.  None of them quite correct.  It seems there are two files that
need to be patched.

I'm attaching the patch that finally allowed my kernel to compile.  It is
mostly the one that Horst von Brand sent me (which he said Linus
prescribed), but with a correction to the first hunk.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks


---1463805697-1359099639-1005760336=:88
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="setup.c.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.40.0111141252160.88@rc.priv.hereintown.net>
Content-Description: 
Content-Disposition: attachment; filename="setup.c.patch"

LS0tIGxpbnV4LTIuNC9hcmNoL2kzODYva2VybmVsL3NldHVwLmN+CVdlZCBO
b3YgMTQgMTM6MTk6NDMgMjAwMQ0KKysrIGxpbnV4LTIuNC9hcmNoL2kzODYv
a2VybmVsL3NldHVwLmMJV2VkIE5vdiAxNCAxMzoxOTo1MyAyMDAxDQpAQCAt
Mjc4OCw3ICsyNzg4LDcgQEANCiANCiBzdGF0aWMgdm9pZCAqY19zdGFydChz
dHJ1Y3Qgc2VxX2ZpbGUgKm0sIGxvZmZfdCAqcG9zKQ0KIHsNCi0JcmV0dXJu
ICpwb3MgPCBOUl9DUFVTID8gJmNwdV9kYXRhWypwb3NdIDogTlVMTDsNCisJ
cmV0dXJuICpwb3MgPCBOUl9DUFVTID8gY3B1X2RhdGEgKyAqcG9zIDogTlVM
TDsNCiB9DQogc3RhdGljIHZvaWQgKmNfbmV4dChzdHJ1Y3Qgc2VxX2ZpbGUg
Km0sIHZvaWQgKnYsIGxvZmZfdCAqcG9zKQ0KIHsNCi0tLSBsaW51eC0yLjQv
aW5jbHVkZS9hc20taTM4Ni9wcm9jZXNzb3IuaH4JV2VkIE5vdiAxNCAxMTo1
MjozOSAyMDAxDQorKysgbGludXgtMi40L2luY2x1ZGUvYXNtLWkzODYvcHJv
Y2Vzc29yLmgJV2VkIE5vdiAxNCAxMzoxODo0NyAyMDAxDQpAQCAtNzYsNyAr
NzYsNyBAQA0KIGV4dGVybiBzdHJ1Y3QgY3B1aW5mb194ODYgY3B1X2RhdGFb
XTsNCiAjZGVmaW5lIGN1cnJlbnRfY3B1X2RhdGEgY3B1X2RhdGFbc21wX3By
b2Nlc3Nvcl9pZCgpXQ0KICNlbHNlDQotI2RlZmluZSBjcHVfZGF0YSAmYm9v
dF9jcHVfZGF0YQ0KKyNkZWZpbmUgY3B1X2RhdGEgKCZib290X2NwdV9kYXRh
KQ0KICNkZWZpbmUgY3VycmVudF9jcHVfZGF0YSBib290X2NwdV9kYXRhDQog
I2VuZGlmDQo=
---1463805697-1359099639-1005760336=:88--
