Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVEXVXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVEXVXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 17:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVEXVXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 17:23:54 -0400
Received: from ftp.ardi.com ([207.188.170.178]:51729 "EHLO www.ardi.com")
	by vger.kernel.org with ESMTP id S262195AbVEXVXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 17:23:25 -0400
From: "Clifford T. Matthews" <ctm@ardi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17043.39755.573568.293067@newbie.ardi.com>
Date: Tue, 24 May 2005 15:23:23 -0600
To: Chris Wright <chrisw@osdl.org>
Cc: "Clifford T. Matthews" <ctm@ardi.com>, linux-kernel@vger.kernel.org
Subject: Re: trouble trapping SEGV on 2.6.11.2 & 2.6.12-rc4
In-Reply-To: <20050524204310.GJ23013@shell0.pdx.osdl.net>
References: <17043.36668.164277.860295@newbie.ardi.com>
	<20050524204310.GJ23013@shell0.pdx.osdl.net>
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Chris" == Chris Wright <chrisw@osdl.org> writes:

    Chris> 2.6 has been fixed...  So your program (which happens to be
    Chris> slightly buggy) no longer works as you expected.  See
    Chris> below.

Thanks for the quick response.  Using sigsetjmp and siglongjmp makes
the program print two lines.

I read the setjmp / sigsetjmp documentation and misunderstood it.

I had already seen that if I inserted "signal (SIGSEGV, segv_handler)"
before the second setjmp (not sigsetjmp), the program (under 2.6
kernels) still would die.

I guess what happens there is that after coming back from the longjmp,
the error handler is still segv_handler, but the receipt of the SEGV
signal itself is blocked and if you take a SEGV when the receipt of
SEGV is blocked a program dies with a SEGV, even if you have a SEGV
handler.

--Cliff Matthews <ctm@ardi.com>
