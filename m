Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVJGHuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVJGHuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 03:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVJGHuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 03:50:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21938 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750743AbVJGHuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 03:50:16 -0400
Subject: Re: [RFC] add sysfs to dynamically control blk request tag
	maintenance
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051007074138.GP2889@suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB5086AEC2E@scsmsx401.amr.corp.intel.com>
	 <20051007074138.GP2889@suse.de>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 09:50:07 +0200
Message-Id: <1128671408.2921.12.camel@laptopd505.fenrus.org>
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

On Fri, 2005-10-07 at 09:41 +0200, Jens Axboe wrote:
> Ok that makes more sense! But it's a little worrying that
> blk_queue_end_tag() would show up as hot in the profile, it is actually
> quite lean.

it probably just is the first one to touch the IO structures after the
completion, and thus gets the penalty for the cachemiss. Something has
to have that after io completion (the io started usually > 10 msec ago
after all, and usually on another cpu at that) and my experience is that
it's one of those jello elephants; you can only move it around but not
really avoid it.


