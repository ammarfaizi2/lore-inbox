Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTIWSGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTIWSGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:06:30 -0400
Received: from verein.lst.de ([212.34.189.10]:56758 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262221AbTIWSG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:06:28 -0400
Date: Tue, 23 Sep 2003 20:06:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] softirq_pending()
Message-ID: <20030923180621.GA18794@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	"David S. Miller" <davem@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030923144847.GA16139@lst.de> <20030923105841.27809d11.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923105841.27809d11.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 10:58:41AM -0700, David S. Miller wrote:
> The problem is that, on some of the platforms that don't ignore
> the argument, the code generation is much better.
> 
> GCC doesn't consider smp_processor_id() like some const local
> variable, so multiple invocations are assumed to return different
> values because in many cases 'current_thread_info()' is obscured.
> 
> Your patch is going to make a lot of new code get generated on
> x86 for example, so I don't think it should be applied even though
> my own platforms are not effected by this issue.

Okay, thanks forthe explanation.  I don't think it matters in this
case because there's exactly one case where we pass an variable into
softirq_pending() instead of a direct, uncached smp_processor_id() -
and that is in arch/cris/ which is UP only.

I'll try to remember the hint so I know what do to this pops up
the next time, though :)
