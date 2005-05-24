Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVEXLHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVEXLHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 07:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVEXJZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:25:14 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:39361 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261876AbVEXJR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:17:29 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091726.71E33F9E5@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:17:26 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id CCC3BFB6B

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:39 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261367AbVEXGnN (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:43:13 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVEXGnD

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:43:03 -0400

Received: from pentafluge.infradead.org ([213.146.154.40]:38285 "EHLO

	pentafluge.infradead.org") by vger.kernel.org with ESMTP

	id S261367AbVEXGkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:40:51 -0400

Received: from g133107.upc-g.chello.nl ([80.57.133.107] helo=[172.31.3.43])

	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))

	id 1DaT5s-0001rg-46; Tue, 24 May 2005 07:40:48 +0100

Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()

From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: davem@davemloft.net
In-Reply-To: <200505232300.j4NN07lE012726@hera.kernel.org>

References: <200505232300.j4NN07lE012726@hera.kernel.org>

Content-Type: text/plain

Date:	Tue, 24 May 2005 08:40:45 +0200

Message-Id: <1116916845.6280.8.camel@laptopd505.fenrus.org>

Mime-Version: 1.0

X-Mailer: Evolution 2.0.4 (2.0.4-4) 

Content-Transfer-Encoding: 7bit

X-Spam-Score: 3.7 (+++)

X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:

	Content analysis details:   (3.7 points, 5.0 required)

	pts rule name              description

	---- ---------------------- --------------------------------------------------

	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org

	[<http://dsbl.org/listing?80.57.133.107>]

	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address

	[80.57.133.107 listed in dnsbl.sorbs.net]

	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS

	[80.57.133.107 listed in dnsbl.sorbs.net]

X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org

	See http://www.infradead.org/rpr.html

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org




> -	if (!in_softirq())
> +	if (!in_atomic())
>  		cond_resched();

this looks wrong. in_atomic() isn't doing what I think you think it
does; for one it doesn't get set inside spinlock regions (unless preempt
is enabled) 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

