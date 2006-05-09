Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWEIPwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWEIPwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWEIPwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:52:03 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:58535 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751157AbWEIPwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:52:02 -0400
Date: Tue, 9 May 2006 16:51:53 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
Message-ID: <20060509155153.GJ7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085154.095325000@sous-sol.org> <4460AC06.4000303@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4460AC06.4000303@mbligh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 07:49:42AM -0700, Martin J. Bligh wrote:
> >+#define __cli()							 \
> >+do {									\
> >+	struct vcpu_info *_vcpu;					\
> >+	preempt_disable();						\
> >+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
> >+	_vcpu->evtchn_upcall_mask = 1;					\
> >+	preempt_enable_no_resched();					\
> >+	barrier();							\
> >+} while (0)
> 
> Should be a real function

Yes, except it's not trivially done because if __cli was an inline
function, you need to have everything that is used in the declaration
defined when the function is declared as opposed to when the #define
gets used.  I'll give it another try, but it very quickly becomes
#include hell.

Anybody want to comment on the performance impact of making
local_irq_* non-inline functions?

    christian

