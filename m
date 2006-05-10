Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWEJHzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWEJHzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWEJHzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:55:39 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:48175
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932301AbWEJHzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:55:38 -0400
Message-Id: <4461B8B0.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 10 May 2006 09:56:00 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "mao bibo" <bibo_mao@linux.intel.com>
Cc: "Anil S Keshavamurthy" <anil.s.keshavamurthy@intel.com>,
       "mao bibo" <bibo.mao@intel.com>, <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]x86_64 debug_stack nested patch
References: <44618C0D.6020604@intel.com> <4461AD97.76E4.0078.0@novell.com> <446199CA.2030706@linux.intel.com>
In-Reply-To: <446199CA.2030706@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>in_exception_stack() function is to judge which IST stack by parameter 
>stack value, if DEBUG_STKSZ value is set as 8K. The original function 
>can not judge whether it is within DEBUG_STACK space.

I rather think that the new code can't work properly. Since the pointer in the TSS gets decreased while the handler is
running, using that value is not going to tell you the end of the stack, but you'd rather get the end of the stack the
next (nested) invocation of the handler would use. Further, treating the entire DEBUG_STKSZ range as a single piece is
wrong, too, because it is not being used as a contiguous stack (but rather as 2 stacks EXCEPTION_STKSZ in size); the new
code shouldn't be able to properly deal with nested invocations because of this.

Jan
