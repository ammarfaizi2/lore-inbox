Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWGDQiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWGDQiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWGDQiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:38:52 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:25992 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932277AbWGDQiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:38:51 -0400
Message-ID: <44AA9999.3060308@oracle.com>
Date: Tue, 04 Jul 2006 09:38:49 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [openib-general] [PATCH] mthca: initialize send and receive queue
 locks separately
References: <20060703225019.7379.96075.sendpatchset@tetsuo.zabbo.net> <20060704070328.GG21049@mellanox.co.il>
In-Reply-To: <20060704070328.GG21049@mellanox.co.il>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This moves code out of a common function and so results in code duplication
> and has memory cost.

Of course.  I don't care which trade-offs you prefer to maintain as long
as the driver stops yelling at me as the machine boots.  That patch was
what Arjan suggested as the simplest.

Also, while looking at this I saw that the locks are being
re-initialized from mthca_modify_qp().  Is that just a side-effect of
relying on mthca_wq_init() to reset the non-lock members?  If you're
concerned about microoptimization it seems like this could be avoided.

- z
