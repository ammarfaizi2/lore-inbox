Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUAXVfd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 16:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUAXVfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 16:35:33 -0500
Received: from gamma.utc.fr ([195.83.155.32]:6075 "EHLO gamma.utc.fr")
	by vger.kernel.org with ESMTP id S262360AbUAXVfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 16:35:25 -0500
Message-ID: <1074979873.4012e421714b1@mailetu.utc.fr>
Date: Sat, 24 Jan 2004 22:31:13 +0100
From: eric.piel@tremplin-utc.net
To: akpm@osdl.org
Cc: Corey Minyard <minyard@acm.org>, George Anzinger <george@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Incorrect value for SIGRTMAX
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ107497987312a0036ac08b8e794fbb216b2a2e3e53"
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Spam-Checked-By: gamma.utc.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ107497987312a0036ac08b8e794fbb216b2a2e3e53
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hello,

Few months ago, Corey Minyard corrected handling of incorrect values of signals.
cf
http://linux.bkbits.net:8080/linux-2.5/cset@1.1267.56.40?nav=index.html%7Csrc/%7Csrc/kernel%7Crelated/kernel/posix-timers.c

Working on the High-Resolution Timers project, I noticed there is an error in
good_sigevent() to catch the case when sigev_signo is 0. In this function, we
want to return NULL when sigev_signo is 0. The one liner attached (used for a
long time in the HRT patch) should do the trick, it's against vanilla 2.6.1 .

Eric


---MOQ107497987312a0036ac08b8e794fbb216b2a2e3e53
Content-Type: text/x-patch; name="good-sigevent-not-handling-null.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="good-sigevent-not-handling-null.patch"

LS0tIGxpbnV4LTIuNi4xL2tlcm5lbC9wb3NpeC10aW1lcnMuYy5vcmlnCTIwMDQtMDEtMjQgMTU6
MTc6MzEuNjQ1MDYwMjQ4ICswMTAwCisrKyBsaW51eC0yLjYuMS9rZXJuZWwvcG9zaXgtdGltZXJz
LmMJMjAwNC0wMS0yNCAxNToyMDo1Ni45Nzc4NDQ5MjAgKzAxMDAKQEAgLTM0NCw4ICszNDQsNyBA
QAogCQlyZXR1cm4gTlVMTDsKIAogCWlmICgoZXZlbnQtPnNpZ2V2X25vdGlmeSAmIH5TSUdFVl9O
T05FICYgTUlQU19TSUdFVikgJiYKLQkJCWV2ZW50LT5zaWdldl9zaWdubyAmJgotCQkJKCh1bnNp
Z25lZCkgKGV2ZW50LT5zaWdldl9zaWdubyA+IFNJR1JUTUFYKSkpCisJICAgICgodW5zaWduZWQp
IChldmVudC0+c2lnZXZfc2lnbm8gPiBTSUdSVE1BWCkgfHwgIWV2ZW50LT5zaWdldl9zaWdubykp
CiAJCXJldHVybiBOVUxMOwogCiAJcmV0dXJuIHJ0bjsK

---MOQ107497987312a0036ac08b8e794fbb216b2a2e3e53--

