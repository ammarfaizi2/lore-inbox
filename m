Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290181AbSALANW>; Fri, 11 Jan 2002 19:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290182AbSALANQ>; Fri, 11 Jan 2002 19:13:16 -0500
Received: from mail2.mx.voyager.net ([216.93.66.201]:61960 "EHLO
	mail2.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S290181AbSALANC>; Fri, 11 Jan 2002 19:13:02 -0500
Message-ID: <3C3F7FB2.225B6A7E@megsinet.net>
Date: Fri, 11 Jan 2002 18:13:38 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ken Brownfield <brownfld@irridia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C2CD326.100@athlon.maya.org> <20020103142301.C4759@asooo.flowerfire.com> <20020111144117.A1485@asooo.flowerfire.com>
Content-Type: multipart/mixed;
 boundary="------------8A0169405699BAF5647CD72B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8A0169405699BAF5647CD72B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ken Brownfield wrote:
> 
> After more testing, my original observations seem to be holding up,
> except that under heavy VM load (e.g., "make -j bzImage") the machine's
> overall performance seems far lower.  For instance, without the patch
> the -j build finishes in ~10 minutes (2x933P3/256MB) but with the patch
> I haven't had the patience to let it finish after more than an hour.
> 
> This is perhaps because the vmscan patch is too aggressively shrinking
> the caches, or causing thrashing in another area?  I'm also noticing
> that the amount of swap used is nearly an order of magnitude higher,
> which doesn't make sense at first glance...  Also, there are extended
> periods where idle CPU is 50-80%.
> 
> Maybe the patch or at least its intent can be merged with Andrea's work
> if applicable?
> 
> Thanks,
> --
> Ken.
> brownfld@irridia.com
> 


Ken,

Attached is an update to my previous vmscan.patch.2.4.17.c

Version "d" fixes a BUG due to a race in the old code _and_
is much less agressive at cache_shrinkage or conversely more
willing to swap out but not as much as the stock kernel.

It continues to work well wrt to high vm pressure.

Give it a whirl to see if it changes your "-j" symptoms.

If you like you can change the one line in the patch
from "DEF_PRIORITY" which is "6" to progressively smaller
values to "tune" whatever kind of swap_out behaviour you
like.

Martin
--------------8A0169405699BAF5647CD72B
Content-Type: application/octet-stream;
 name="vmscan.patch.2.4.17.d"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="vmscan.patch.2.4.17.d"

LS0tIGxpbnV4LnZpcmdpbi9tbS92bXNjYW4uYwlNb24gRGVjIDMxIDEyOjQ2OjI1IDIwMDEK
KysrIGxpbnV4L21tL3Ztc2Nhbi5jCUZyaSBKYW4gMTEgMTg6MDM6MDUgMjAwMgpAQCAtMzk0
LDkgKzM5NCw5IEBACiAJCWlmIChQYWdlRGlydHkocGFnZSkgJiYgaXNfcGFnZV9jYWNoZV9m
cmVlYWJsZShwYWdlKSAmJiBwYWdlLT5tYXBwaW5nKSB7CiAJCQkvKgogCQkJICogSXQgaXMg
bm90IGNyaXRpY2FsIGhlcmUgdG8gd3JpdGUgaXQgb25seSBpZgotCQkJICogdGhlIHBhZ2Ug
aXMgdW5tYXBwZWQgYmVhdXNlIGFueSBkaXJlY3Qgd3JpdGVyCisJCQkgKiB0aGUgcGFnZSBp
cyB1bm1hcHBlZCBiZWNhdXNlIGFueSBkaXJlY3Qgd3JpdGVyCiAJCQkgKiBsaWtlIE9fRElS
RUNUIHdvdWxkIHNldCB0aGUgUEdfZGlydHkgYml0ZmxhZwotCQkJICogb24gdGhlIHBoaXNp
Y2FsIHBhZ2UgYWZ0ZXIgaGF2aW5nIHN1Y2Nlc3NmdWxseQorCQkJICogb24gdGhlIHBoeXNp
Y2FsIHBhZ2UgYWZ0ZXIgaGF2aW5nIHN1Y2Nlc3NmdWxseQogCQkJICogcGlubmVkIGl0IGFu
ZCBhZnRlciB0aGUgSS9PIHRvIHRoZSBwYWdlIGlzIGZpbmlzaGVkLAogCQkJICogc28gdGhl
IGRpcmVjdCB3cml0ZXMgdG8gdGhlIHBhZ2UgY2Fubm90IGdldCBsb3N0LgogCQkJICovCkBA
IC00ODAsMTEgKzQ4MCwxNCBAQAogCiAJCQkvKgogCQkJICogQWxlcnQhIFdlJ3ZlIGZvdW5k
IHRvbyBtYW55IG1hcHBlZCBwYWdlcyBvbiB0aGUKLQkJCSAqIGluYWN0aXZlIGxpc3QsIHNv
IHdlIHN0YXJ0IHN3YXBwaW5nIG91dCBub3chCisJCQkgKiBpbmFjdGl2ZSBsaXN0LgorCQkJ
ICogTW92ZSByZWZlcmVuY2VkIHBhZ2VzIHRvIHRoZSBhY3RpdmUgbGlzdC4KIAkJCSAqLwot
CQkJc3Bpbl91bmxvY2soJnBhZ2VtYXBfbHJ1X2xvY2spOwotCQkJc3dhcF9vdXQocHJpb3Jp
dHksIGdmcF9tYXNrLCBjbGFzc3pvbmUpOwotCQkJcmV0dXJuIG5yX3BhZ2VzOworCQkJaWYg
KFBhZ2VSZWZlcmVuY2VkKHBhZ2UpICYmICFQYWdlTG9ja2VkKHBhZ2UpKSB7CisJCQkJZGVs
X3BhZ2VfZnJvbV9pbmFjdGl2ZV9saXN0KHBhZ2UpOworCQkJCWFkZF9wYWdlX3RvX2FjdGl2
ZV9saXN0KHBhZ2UpOworCQkJfQorCQkJY29udGludWU7CiAJCX0KIAogCQkvKgpAQCAtNTIx
LDYgKzUyNCw5IEBACiAJfQogCXNwaW5fdW5sb2NrKCZwYWdlbWFwX2xydV9sb2NrKTsKIAor
CWlmIChtYXhfbWFwcGVkIDw9IDAgJiYgKG5yX3BhZ2VzID4gMCB8fCBwcmlvcml0eSA8IERF
Rl9QUklPUklUWSkpCisJCXN3YXBfb3V0KHByaW9yaXR5LCBnZnBfbWFzaywgY2xhc3N6b25l
KTsKKwogCXJldHVybiBucl9wYWdlczsKIH0KIAo=
--------------8A0169405699BAF5647CD72B--

