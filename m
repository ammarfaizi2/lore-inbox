Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264556AbTDPTcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbTDPTcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:32:31 -0400
Received: from unamed.infotel.bg ([212.39.68.18]:49678 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id S264556AbTDPTc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:32:29 -0400
Date: Wed, 16 Apr 2003 22:43:55 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@l
To: jamal <hadi@cyberus.ca>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Catalin BOIE <util@deuroconsult.ro>,
       Tomas Szepe <szepe@pinerecords.com>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>, <kuznet@ms2.inr.ac.ru>
Subject: Re: [PATCH] qdisc oops fix
In-Reply-To: <20030416142802.E5912@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.44.0304162148520.1938-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Wed, 16 Apr 2003, jamal wrote:

> > >This is a different problem from previous one posted.

	The problem should be the same. This 'lock bh + GFP_KERNEL'
BUG happens only when slab allocates pages, not on each kmalloc.

> > >Theres a small window (exposed given that you are provisioning a lot
> > >of qdiscs  and running traffic at the same time) that an incoming packet
> > >interupt will cause the BUG().

	This should not happen, may be you see another place that violates
the above rule? IMO, the only problem is that it is not good to
hold locks (including bh one) while using GFP_KERNEL.

Regards

--
Julian Anastasov <ja@ssi.bg>

