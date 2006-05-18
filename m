Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWERVXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWERVXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 17:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWERVXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 17:23:10 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:44673 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751344AbWERVXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 17:23:09 -0400
Date: Thu, 18 May 2006 14:26:07 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
Message-ID: <20060518212607.GY23243@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085154.802230000@sous-sol.org> <446CD6FF.30409@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446CD6FF.30409@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Chris Wright wrote:
> >1. We clear FS/GS before changing TLS entries and switching LDT, as
> >otherwise the hypervisor will fail to restore thread-local values on
> >return to the guest kernel and we take a slow exception path.
> 
> >@@ -647,6 +647,8 @@ struct task_struct fastcall * __switch_t
> > 	 */
> > 	savesegment(fs, prev->fs);
> > 	savesegment(gs, prev->gs);
> >+	clearsegment(fs);
> >+	clearsegment(gs);
> >  
> 
> Really not needed.  Think about it.  You can even speed up Xen.

Please describe how.  I'm afraid I'm missing your point, as I don't see
the improvement.

> I'm glad the native operation here is a nop, but it should be 
> hypervisor_clearsegment or xen_clearsegment if you really want to keep it.

Yeah, Andi had similar naming concern.
