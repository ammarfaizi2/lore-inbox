Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWGXN2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWGXN2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWGXN2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:28:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:60346 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932153AbWGXN2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:28:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=BC1OD5jpbxoEWJAWuh5tB76whvQFUJLDx1dKWDACGWSkmk0dPbvIuGGeiLX6PSx7MDmap/P8krV70E8pFY8mrmlt+hOiq7B/i4jZBET81440oEXTo5LWD96WZzwiO923/CFhBNj5EiZhvoXbalMDmtpkk/J117XnsQtl4QHyN5Q=
Message-ID: <b0943d9e0607240628n115deac4x3befe5d39037248f@mail.gmail.com>
Date: Mon, 24 Jul 2006 14:28:03 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060724111554.GA5286@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_156_13927091.1153747683975"
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606240320h1727639cv36a4fe399dddd767@mail.gmail.com>
	 <20060624102248.GA23277@elte.hu> <20060724111554.GA5286@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_156_13927091.1153747683975
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 24/07/06, Ingo Molnar <mingo@elte.hu> wrote:
> update: there's also a neat gcc extension trick suggested by Arjan:
> __builtin_classify_type(). This converts types into integers!

It's not really reliable as it doesn't distinguish well between types.
All the structures, no matter what they contain, have the same id
(which I think only refers to the fact that it is built-in type,
pointer or structure, without differentiation).

The attached code gives the following results:

typeof(a) = 12, sizeof(a) = 136
typeof(b) = 12, sizeof(b) = 8
typeof(c) = 1, sizeof(c) = 4
typeof(d) = 1, sizeof(d) = 4
typeof(e) = 1, sizeof(e) = 4
typeof(f) = 1, sizeof(f) = 1
typeof(g) = 5, sizeof(g) = 4
typeof(h) = 5, sizeof(h) = 4

-- 
Catalin

------=_Part_156_13927091.1153747683975
Content-Type: text/x-csrc; name=builtin_classify_type.c; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eq0vin63
Content-Disposition: attachment; filename="builtin_classify_type.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CgpzdHJ1Y3QgQSB7Cgl2b2lkICphOwoJbG9uZyBiOwoJY2hhciBj
WzEyOF07Cn07CgpzdHJ1Y3QgQiB7Cglsb25nIGE7Cgl2b2lkICpiOwp9OwoKZW51bSBDIHsKCWEs
CgliCn07CgojZGVmaW5lIFBSSU5UX1RZUEUodmFsKQkJCQkJCQlcCglwcmludGYoInR5cGVvZigi
ICN2YWwgIikgPSAlZCwgc2l6ZW9mKCIgI3ZhbCAiKSA9ICVkXG4iLAlcCgkJCV9fYnVpbHRpbl9j
bGFzc2lmeV90eXBlKHZhbCksCQkJXAoJCQlzaXplb2YodmFsKSkKCmludCBtYWluKCkKewoJc3Ry
dWN0IEEgYTsKCXN0cnVjdCBCIGI7CgllbnVtIEMgYzsKCWludCBkOwoJbG9uZyBlOwoJY2hhciBm
OwoJaW50ICpnOwoJY2hhciAqaDsKCglQUklOVF9UWVBFKGEpOwoJUFJJTlRfVFlQRShiKTsKCVBS
SU5UX1RZUEUoYyk7CglQUklOVF9UWVBFKGQpOwoJUFJJTlRfVFlQRShlKTsKCVBSSU5UX1RZUEUo
Zik7CglQUklOVF9UWVBFKGcpOwoJUFJJTlRfVFlQRShoKTsKCglyZXR1cm4gMDsKfQo=
------=_Part_156_13927091.1153747683975--
