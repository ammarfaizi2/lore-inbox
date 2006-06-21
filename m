Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWFUUir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWFUUir (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWFUUiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:38:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030270AbWFUUiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:38:46 -0400
Date: Wed, 21 Jun 2006 13:38:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: nagar@watson.ibm.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060621133838.12dfa9f8.akpm@osdl.org>
In-Reply-To: <449999D1.7000403@engr.sgi.com>
References: <44892610.6040001@watson.ibm.com>
	<20060609010057.e454a14f.akpm@osdl.org>
	<448952C2.1060708@in.ibm.com>
	<20060609042129.ae97018c.akpm@osdl.org>
	<4489EE7C.3080007@watson.ibm.com>
	<449999D1.7000403@engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 12:11:13 -0700
Jay Lan <jlan@engr.sgi.com> wrote:

> Another observation that i considered bad news is that all
> 10 runs produced 1 to 5 recv() error with errno=105 (ENOBUF).

Well that's rather bad.  AFAICT most of the allocations in there are
GFP_KERNEL, so why is this happening?

Because the kernel is producing netlink messages faster than userspace can
consume them, perhaps?  If so, the sender needs to block, which means we
need to make reception of these stats a privileged operation?
