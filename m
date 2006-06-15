Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030760AbWFOQHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030760AbWFOQHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030761AbWFOQHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:07:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10894 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030760AbWFOQHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:07:03 -0400
Date: Thu, 15 Jun 2006 09:06:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: light weight counters: race free through local_t?
In-Reply-To: <44915110.2050100@bull.net>
Message-ID: <Pine.LNX.4.64.0606150858350.9193@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606092212200.4875@schroedinger.engr.sgi.com>
 <449033B0.1020206@bull.net> <Pine.LNX.4.64.0606140928500.4030@schroedinger.engr.sgi.com>
 <44915110.2050100@bull.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm... What about side effects such as pipeline stalls? fetchadd is 
semaphore operation. Typically we use acquire semantics for volatiles. 
Here the fetchadd has release semantics.

If we would use release semantics then the fetchadd would require all 
prior accesses to be complete.

Acquire semantics may be easier. But the best would be a fetchadd without 
any serialization that would be like the inc/dec memory on i386, which 
does not exist in the IA64 instruction set.

