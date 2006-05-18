Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWERUXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWERUXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWERUXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:23:17 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:25092 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751389AbWERUXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:23:17 -0400
Message-ID: <446CD6FF.30409@vmware.com>
Date: Thu, 18 May 2006 13:20:15 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
References: <20060509084945.373541000@sous-sol.org> <20060509085154.802230000@sous-sol.org>
In-Reply-To: <20060509085154.802230000@sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> 1. We clear FS/GS before changing TLS entries and switching LDT, as
> otherwise the hypervisor will fail to restore thread-local values on
> return to the guest kernel and we take a slow exception path.

> @@ -647,6 +647,8 @@ struct task_struct fastcall * __switch_t
>  	 */
>  	savesegment(fs, prev->fs);
>  	savesegment(gs, prev->gs);
> +	clearsegment(fs);
> +	clearsegment(gs);
>   

Really not needed.  Think about it.  You can even speed up Xen.  I'm 
glad the native operation here is a nop, but it should be 
hypervisor_clearsegment or xen_clearsegment if you really want to keep it.

Zach
