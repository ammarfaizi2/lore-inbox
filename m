Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWGEDYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWGEDYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 23:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWGEDYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 23:24:40 -0400
Received: from mxl145v69.mxlogic.net ([208.65.145.69]:3237 "EHLO
	p02c11o146.mxlogic.net") by vger.kernel.org with ESMTP
	id S932345AbWGEDYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 23:24:39 -0400
Date: Wed, 5 Jul 2006 06:07:45 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Cc: Zach Brown <zach.brown@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [openib-general] [PATCH] mthca: initialize send and receive queue locks separately
Message-ID: <20060705030745.GA20709@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <adairmd9kah.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adairmd9kah.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 05 Jul 2006 03:12:27.0453 (UTC) FILETIME=[D8267ED0:01C69FE0]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [63.251.237.3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Roland Dreier <rdreier@cisco.com>:
> I think that is actually a very minor bug you've found.  If someone
> were posting a work request at the same time as they transitioned a QP
> to reset (which is a legitimate if not sensible thing to do), then the
> spinlock could get reinitialized while it was held.  Which would be
> bad.

I think you can't post work requests to a QP in reset state, since IB spec
forbids this. If you do, it seems bad things will happen anyway, for example
head/tail pointers may get out of sync as mthca_wq_init clears these.

-- 
MST
