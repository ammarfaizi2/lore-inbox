Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUFPMM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUFPMM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266259AbUFPMM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:12:56 -0400
Received: from ns.tasking.nl ([195.193.207.2]:8208 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S266257AbUFPMMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:12:42 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <20040615161646.S21045@build.pdx.osdl.net> <20040615161646.S21045@build.pdx.osdl.net> <Pine.LNX.4.58.0406151946220.4142@ppc970.osdl.org>
From: spam@altium.nl (Dick Streefland)
Subject: Re: [PATCH] security_sk_free void return fixup
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <d69.40d038fd.d9853@altium.nl>
Date: Wed, 16 Jun 2004 12:11:41 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
| I'm going to remove this warning from sparse. Apparently it is valid C99, 
| and somebody (I think Richard Henderson) made the excellent point that it 
| allows for type-independent code where you do something like
| 
| 	mytype myfunc1(xxx);
| 
| 	mytype myfunc2(xxx)
| 	{
| 		...
| 		return myfunc1(...);
| 	}
| 
| and it just works regardless of what type it is. 

It may work in gcc, but it is invalid according to ISO C99. First
sentence from section 6.8.6.4:

  A return statement with an expression shall not appear in a
  function whose return type is void.

Now, a function call is obviously an expression.

| sparse will obviously warn about expressions with non-void types being 
| returned from a void function, but the case where the expression exists 
| and has the right type should be ok.
| 
| I'm not sure it's wonderful C in general, but I certainly can't claim it 
| is actively offensive, and since gcc accepts it and we have these things 
| in the kernel, why complain? 

Gcc warns about this with the -pedantic option:

  $ gcc-3.3 -pedantic -c return.c
  return.c: In function `myfunc2':
  return.c:5: warning: `return' with a value, in function returning void

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

