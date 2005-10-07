Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVJGIZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVJGIZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 04:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVJGIZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 04:25:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42380 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750937AbVJGIZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 04:25:27 -0400
Subject: Re: [RFC] add sysfs to dynamically control blk request tag
	maintenance
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051007080620.GQ2889@suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB5086AEC2E@scsmsx401.amr.corp.intel.com>
	 <20051007074138.GP2889@suse.de>
	 <1128671408.2921.12.camel@laptopd505.fenrus.org>
	 <20051007080620.GQ2889@suse.de>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 10:25:20 +0200
Message-Id: <1128673521.4145.1.camel@laptopd505.fenrus.org>
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



> The request itself has been
> touched by scsi_end_request() already, so unless the layout is really
> bad we shouldn't need to fetch a lot of cache lines there. That leaves
> __test_and_clear_bit(), I guess that must be it.

__test_and_clear_bit() is cheap; it's a single non-locked instruction.
Arguably it should be converted into a C variant so that the compiler
can pick the best code sequence (I'm not so sure the asm we picked for
this is optimal for all processors, I bet it'll be microcoded) but I'd
be surprised if it'd be more than a handful of cycles no matter what.


