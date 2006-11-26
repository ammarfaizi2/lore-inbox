Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757955AbWKZU0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757955AbWKZU0N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 15:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757965AbWKZU0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 15:26:13 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:28424 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1757955AbWKZU0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 15:26:12 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       tom@opengridcomputing.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
X-Message-Flag: Warning: May contain useful information
References: <adazmag5bk1.fsf@cisco.com>
	<20061124.220746.57445336.davem@davemloft.net>
	<adaodqv5e5l.fsf@cisco.com>
	<20061125.150500.14841768.davem@davemloft.net>
	<adak61j5djh.fsf@cisco.com> <20061125164118.de53d1cf.akpm@osdl.org>
	<ada64d23ty8.fsf@cisco.com> <20061126111703.33247a84.akpm@osdl.org>
	<Pine.LNX.4.64.0611261208550.3483@woody.osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 26 Nov 2006 12:26:08 -0800
In-Reply-To: <Pine.LNX.4.64.0611261208550.3483@woody.osdl.org> (Linus Torvalds's message of "Sun, 26 Nov 2006 12:11:29 -0800 (PST)")
Message-ID: <adapsba2bvj.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Nov 2006 20:26:08.0935 (UTC) FILETIME=[1B519B70:01C71199]
Authentication-Results: sj-dkim-5; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim5002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +#define ALIGN(x,a)		__ALIGN_MASK(x,(typeof(x))(a)-1)
 > +#define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))

Fine by me, but it loses the extra (typeof(x)) cast that Al wanted to
make sure that the result of ALIGN() is not wider than x.

 - R.
