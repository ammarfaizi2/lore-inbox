Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319296AbSH2TKq>; Thu, 29 Aug 2002 15:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319299AbSH2TKq>; Thu, 29 Aug 2002 15:10:46 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:2322
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319296AbSH2TKq>; Thu, 29 Aug 2002 15:10:46 -0400
Subject: Re: Kernel Stack Limit...
From: Robert Love <rml@tech9.net>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
In-Reply-To: <8A9A5F4E6576D511B98F00508B68C20A0C84D1CC@orsmsx106.jf.intel.com>
References: <8A9A5F4E6576D511B98F00508B68C20A0C84D1CC@orsmsx106.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 15:15:13 -0400
Message-Id: <1030648513.978.2601.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 15:07, Raj, Ashok wrote:

> Please reply to me, since i dont have this email id on the list. 
> 
> Could someone tell me at what the kernel stack size limit is? 

It depends on the architecture.  8KB for x86 and most others.  Some
(all?) 64-bit platforms have 16KB stacks.

Note the effective size is actually (8KB - sizeof(task_struct)) in 2.4
and (8KB - sizeof(thread_info)) in 2.5 since those structures are stored
at the top of the stack.

Also note interrupts share the stack.

> Is there a gcc option for x86 that can warn if too large variables are
> specified in the stack?

I believe 2.4-ac has a stack overflow check in it... as does the RedHat
kernel - check it out.

Also kgdb (or at least our copy here at MontaVista) has a stack overflow
check.

	Robert Love

