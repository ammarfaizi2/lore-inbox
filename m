Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVJDOdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVJDOdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVJDOdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:33:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28291 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932503AbVJDOdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:33:33 -0400
Subject: Re: Using DMA in read/write, setting block size for I/O
From: Arjan van de Ven <arjan@infradead.org>
To: Karthik Sarangan <karthiks@cdac.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <434288E9.3090108@cdac.in>
References: <434288E9.3090108@cdac.in>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 16:33:20 +0200
Message-Id: <1128436401.2922.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Will the underlying block device read a single 256KB block from the hdd 
> into pcBuffer
> or will it read 256KB as a set of smaller blocks?

that depends, not all pieces of hardware can do transfers that big (or
at least advertise to the kernel that they can); if that's the case the
kernel will chop it up. Note:t he kernel will not *guarantee* that it'll
be one io either way. So don't depend on it for correctness!
Yet of course the kernel will try to optimize as good as possible


> Since the buffer is memory aligned will it enable DMA?

doesn't matter; DMA will always happen if the HW is capable of it. Since
you use O_DIRECT there will also not be a copy (which would happen if
you didn't use O_DIRECT)

