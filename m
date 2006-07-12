Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWGLTGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWGLTGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWGLTGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:06:41 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:58811 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1750794AbWGLTGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:06:40 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Zach Brown <zach.brown@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [openib-general] ipoib lockdep warning
X-Message-Flag: Warning: May contain useful information
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
	<20060712093820.GA9218@elte.hu>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 12 Jul 2006 12:06:37 -0700
Message-ID: <adamzbewsle.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Jul 2006 19:06:39.0512 (UTC) FILETIME=[4DEDA980:01C6A5E6]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > i agree that the IDR subsystem should be irq-safe if GFP_ATOMIC is 
 > passed in. So the _irqsave()/_irqrestore() fix should be done.

OK, I will send the idr change to Andrew.

 > But i also think that you should avoid using GFP_ATOMIC for any sort of 
 > reliable IO path and push as much work into process context as possible. 
 > Is it acceptable for your infiniband IO model to fail with -ENOMEM if 
 > GFP_ATOMIC happens to fail, and is the IO retried transparently?

Yes, I think it's OK.  This idr use is in an inherently unreliable
path.  With that said, as Michael pointed out, we can change things to
use GFP_ATOMIC less.

Thanks,
  Roland
