Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVC2KKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVC2KKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVC2KKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:10:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40611 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262321AbVC2KKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:10:34 -0500
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jens Axboe <axboe@suse.de>, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <42491DBE.6020303@yahoo.com.au>
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com>
	 <20050329080646.GE16636@suse.de>  <42491DBE.6020303@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 12:10:25 +0200
Message-Id: <1112091026.6282.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
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
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 19:19 +1000, Nick Piggin wrote:
> - removes the relock/retry merge mechanism in __make_request if we
>    aren't able to get the GFP_ATOMIC allocation. Just fall through
>    and assume the chances of getting a merge will be small (is this
>    a valid assumption? Should measure it I guess).

this may have a potential problem; if the vm gets in trouble, you
suddenly start to generate worse IO patterns, which means IO performance
goes down right when it's most needed.....

of course we need to figure if this actually ever hits in practice,
because if it doesn't I'm all for simpler code.


