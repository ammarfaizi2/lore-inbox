Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbRE2FCE>; Tue, 29 May 2001 01:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263213AbRE2FBy>; Tue, 29 May 2001 01:01:54 -0400
Received: from smtp7vepub.gte.net ([206.46.170.28]:19314 "EHLO
	smtp7ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S263212AbRE2FBn>; Tue, 29 May 2001 01:01:43 -0400
From: George France <france@handhelds.org>
Date: Tue, 29 May 2001 01:00:56 -0400
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  charset="us-ascii";
  boundary="------------Boundary-00=_K9Z2BDND6KIOQG0U6064"
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jay Thorne <Yohimbe@userfriendly.org>
To: Keith Owens <kaos@ocs.com.au>
In-Reply-To: <4172.991093202@ocs3.ocs-net>
In-Reply-To: <4172.991093202@ocs3.ocs-net>
Subject: Re: PATCH - ksymoops on Alpha - 2.4.5-ac3
MIME-Version: 1.0
Message-Id: <01052901005607.17841@shadowfax.middleearth>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_K9Z2BDND6KIOQG0U6064
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

> George France <france@handhelds.org> wrote:
> >Here is a trivial patch that will make ksymoops work again on Alpha.

Cleaner patch.

diff -urN linux-2.4.5-ac3-orig/arch/alpha/kernel/traps.c 
linux-2.4.5/arch/alpha/kernel/traps.c
--- linux-2.4.5-ac3-orig/arch/alpha/kernel/traps.c	Thu May 24 17:24:37 2001
+++ linux-2.4.5/arch/alpha/kernel/traps.c	Tue May 29 00:42:40 2001
@@ -286,17 +286,11 @@
 			continue;
 		if (tmp >= (unsigned long) &_etext)
 			continue;
-		/*
-		 * Assume that only the low 24-bits of a kernel text address
-		 * is interesting.
-		 */
-		printk("%6x%c", (int)tmp & 0xffffff, (++i % 11) ? ' ' : '\n');
-#if 0
+		printk("%lx%c", tmp, ' ');
 		if (i > 40) {
 			printk(" ...");
 			break;
 		}
-#endif
 	}
 	printk("\n");
 }


>
> Thanks for that.  Now if you can just persuade the Alpha people to
> print the 'Code:' line in the same format as other architectures then
> ksymoops can decode the instructions as well.  If Alpha wants to
> include its own instruction decoder as well then that is up to them but
> I would appreciate a standard 'Code:' line being printed first.

Could you send me an oops with the standard 'Code:' line? 

Best Regards,


--George
--------------Boundary-00=_K9Z2BDND6KIOQG0U6064
Content-Type: text/english;
  name="patch-ksymoops"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-ksymoops"

ZGlmZiAtdXJOIGxpbnV4LTIuNC41LWFjMy1vcmlnL2FyY2gvYWxwaGEva2VybmVsL3RyYXBzLmMg
bGludXgtMi40LjUvYXJjaC9hbHBoYS9rZXJuZWwvdHJhcHMuYwotLS0gbGludXgtMi40LjUtYWMz
LW9yaWcvYXJjaC9hbHBoYS9rZXJuZWwvdHJhcHMuYwlUaHUgTWF5IDI0IDE3OjI0OjM3IDIwMDEK
KysrIGxpbnV4LTIuNC41L2FyY2gvYWxwaGEva2VybmVsL3RyYXBzLmMJVHVlIE1heSAyOSAwMDo0
Mjo0MCAyMDAxCkBAIC0yODYsMTcgKzI4NiwxMSBAQAogCQkJY29udGludWU7CiAJCWlmICh0bXAg
Pj0gKHVuc2lnbmVkIGxvbmcpICZfZXRleHQpCiAJCQljb250aW51ZTsKLQkJLyoKLQkJICogQXNz
dW1lIHRoYXQgb25seSB0aGUgbG93IDI0LWJpdHMgb2YgYSBrZXJuZWwgdGV4dCBhZGRyZXNzCi0J
CSAqIGlzIGludGVyZXN0aW5nLgotCQkgKi8KLQkJcHJpbnRrKCIlNnglYyIsIChpbnQpdG1wICYg
MHhmZmZmZmYsICgrK2kgJSAxMSkgPyAnICcgOiAnXG4nKTsKLSNpZiAwCisJCXByaW50aygiJWx4
JWMiLCB0bXAsICcgJyk7CiAJCWlmIChpID4gNDApIHsKIAkJCXByaW50aygiIC4uLiIpOwogCQkJ
YnJlYWs7CiAJCX0KLSNlbmRpZgogCX0KIAlwcmludGsoIlxuIik7CiB9Cg==

--------------Boundary-00=_K9Z2BDND6KIOQG0U6064--
