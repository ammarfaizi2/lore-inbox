Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272837AbTHKREX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272840AbTHKRBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:01:40 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:51218 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S272844AbTHKRBM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:01:12 -0400
Subject: Re: Warnings building 2.4.22rc2 with gcc 3.3
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Willy Tarreau <willy@w.ods.org>
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030811155023.GB2868@alpha.home.local>
References: <20030811085453.71881.qmail@web40509.mail.yahoo.com>
	 <20030811155023.GB2868@alpha.home.local>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1060621144.6452.40.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 13:59:05 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy,

Em Seg, 2003-08-11 às 12:50, Willy Tarreau escreveu:
> On Mon, Aug 11, 2003 at 01:54:53AM -0700, Alex Davis wrote:
> > When I build 2.4.22rc2 with gcc 3.3, I get the following warnings
> > 
> > 
> > vt.c:166: warning: comparison is always false due to limited range of data type
> > vt.c:283: warning: comparison is always false due to limited range of data type
> > keyboard.c:644: warning: comparison is always true due to limited range of data type
> > 
> > It seems an unsigned char is being compared with 256, which always returns false.
> 
> For keyboard.c, the test is :
> 
>         if (value < SIZE(func_table)) {
> 
> so it's reassuring that any value is contained in the table. We could hide
> the warning with a cast of value to (int).

 I'm getting it in 2.6.0-test3(-mm1) too. The problem (I think) is 
that the ''if'' is aways true because ''value'' never will be > than
''SIZE(func_table)''.
 
 The cast does not solve the problem, because ''value'' have just
8 bits (unsigned char) used, in other words, with the cast
the ''if'' will continue to be true.

-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

