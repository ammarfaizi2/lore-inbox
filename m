Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVGEUyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVGEUyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 16:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGEUyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 16:54:39 -0400
Received: from [194.90.237.34] ([194.90.237.34]:44746 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261877AbVGEUxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 16:53:22 -0400
Date: Tue, 5 Jul 2005 23:53:51 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rolandd@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 11/16] IB uverbs: add mthca mmap support
Message-ID: <20050705205351.GB28064@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <2005628163.o84QGfsM7oMSy0oU@cisco.com> <2005628163.gtJFW6uLUrGQteys@cisco.com> <20050628170553.00a14a29.akpm@osdl.org> <52mzp1oy91.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52mzp1oy91.fsf@topspin.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Roland Dreier <rolandd@cisco.com>:
> Subject: Re: [PATCH 11/16] IB uverbs: add mthca mmap support
> 
>     Andrew> What's the thinking behind the VM_DONTCOPY there?
> 
> As I said before, I don't think the thinking behind VM_DONTCOPY was
> correct thinking.  Let's take it out.

Roland, I think VM_DONTCOPY is needed here.

If a process forks, we must prevent the child from accessing
the parent's hardware page. Otherwise the child can corrupt
the parent's queues since the hardware wont be able to distinguish
between parent and child.

Does this make sense?

-- 
MST
