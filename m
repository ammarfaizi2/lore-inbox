Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWGDUjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWGDUjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 16:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWGDUjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 16:39:36 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:2402 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932396AbWGDUjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 16:39:35 -0400
X-IronPort-AV: i="4.06,205,1149490800"; 
   d="scan'208"; a="1835063569:sNHT33508076"
To: "Zach Brown" <zach.brown@oracle.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, "Andrew Morton" <akpm@osdl.org>,
       "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [openib-general] [PATCH] mthca: initialize send and receive queue locks separately
X-Message-Flag: Warning: May contain useful information
References: <20060703225019.7379.96075.sendpatchset@tetsuo.zabbo.net>
	<20060704070328.GG21049@mellanox.co.il> <44AA9999.3060308@oracle.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 04 Jul 2006 13:39:34 -0700
In-Reply-To: <44AA9999.3060308@oracle.com> (Zach Brown's message of "Tue, 04 Jul 2006 09:38:49 -0700")
Message-ID: <adairmd9kah.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Jul 2006 20:39:34.0141 (UTC) FILETIME=[F55C8AD0:01C69FA9]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Zach> Also, while looking at this I saw that the locks are being
    Zach> re-initialized from mthca_modify_qp().  Is that just a
    Zach> side-effect of relying on mthca_wq_init() to reset the
    Zach> non-lock members?  If you're concerned about
    Zach> microoptimization it seems like this could be avoided.

I think that is actually a very minor bug you've found.  If someone
were posting a work request at the same time as they transitioned a QP
to reset (which is a legitimate if not sensible thing to do), then the
spinlock could get reinitialized while it was held.  Which would be
bad.  So I think I like your original patch the best.

 - R.
