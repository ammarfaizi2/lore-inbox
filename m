Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWI3Jkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWI3Jkx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 05:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWI3Jkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 05:40:53 -0400
Received: from mail.aknet.ru ([82.179.72.26]:13069 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751204AbWI3Jkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 05:40:52 -0400
Message-ID: <451E3C0C.10105@aknet.ru>
Date: Sat, 30 Sep 2006 13:42:36 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru>	 <1159106032.11049.12.camel@localhost.localdomain>	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>	 <45198395.4050008@aknet.ru> <1159396436.3086.51.camel@laptopd505.fenrus.org>
In-Reply-To: <1159396436.3086.51.camel@laptopd505.fenrus.org>
Content-Type: multipart/mixed;
 boundary="------------090106030900010708050302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090106030900010708050302
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Arjan van de Ven wrote:
>>/ wants to be able to mark more partitions as noexec,/
> .... and then execute from them!
> that's what is bothering me most about all of this.
Do you mean "execute with ld.so", or "execute with PROT_EXEC mmap"?
I think for ld.so problem to cease existing, it is enought to do
simply "chmod 'go-x' ld.so". For this to work I tried opening the
loader with fsuid=0, like in the attached hack. Chmodding ld.so
also prevents the one from executing the binaries for which he have
no execute permission, which is what an mmap hack doesn't solve.

"execute with PROT_EXEC mmap" argument simply doesn't hold -
MAP_PRIVATE|MAP_ANONYMOUS with read() will always work, as well
as the mprotect it seems.


--------------090106030900010708050302
Content-Type: text/plain;
 name="binfmt_elf.c.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="binfmt_elf.c.diff"

LS0tIGJpbmZtdF9lbGYuYy5vbGQJMjAwNi0wOC0yMCAxNTo0OTo1NS4wMDAwMDAwMDAgKzA0
MDAKKysrIGJpbmZtdF9lbGYuYwkyMDA2LTA5LTMwIDEzOjAxOjI3LjAwMDAwMDAwMCArMDQw
MApAQCAtNjIzLDYgKzYyMyw3IEBACiAKIAlmb3IgKGkgPSAwOyBpIDwgbG9jLT5lbGZfZXgu
ZV9waG51bTsgaSsrKSB7CiAJCWlmIChlbGZfcHBudC0+cF90eXBlID09IFBUX0lOVEVSUCkg
eworCQkJaW50IG9yaWdfZnN1aWQ7CiAJCQkvKiBUaGlzIGlzIHRoZSBwcm9ncmFtIGludGVy
cHJldGVyIHVzZWQgZm9yCiAJCQkgKiBzaGFyZWQgbGlicmFyaWVzIC0gZm9yIG5vdyBhc3N1
bWUgdGhhdCB0aGlzCiAJCQkgKiBpcyBhbiBhLm91dCBmb3JtYXQgYmluYXJ5CkBAIC02ODAs
NyArNjgxLDEwIEBACiAJCQkgKi8KIAkJCVNFVF9QRVJTT05BTElUWShsb2MtPmVsZl9leCwg
aWJjczJfaW50ZXJwcmV0ZXIpOwogCisJCQlvcmlnX2ZzdWlkID0gY3VycmVudC0+ZnN1aWQ7
CisJCQljdXJyZW50LT5mc3VpZCA9IDA7CiAJCQlpbnRlcnByZXRlciA9IG9wZW5fZXhlYyhl
bGZfaW50ZXJwcmV0ZXIpOworCQkJY3VycmVudC0+ZnN1aWQgPSBvcmlnX2ZzdWlkOwogCQkJ
cmV0dmFsID0gUFRSX0VSUihpbnRlcnByZXRlcik7CiAJCQlpZiAoSVNfRVJSKGludGVycHJl
dGVyKSkKIAkJCQlnb3RvIG91dF9mcmVlX2ludGVycDsK
--------------090106030900010708050302--
