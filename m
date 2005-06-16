Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVFPRji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVFPRji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 13:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVFPRjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 13:39:32 -0400
Received: from mailsrvr2.bull.com ([192.90.162.8]:43402 "EHLO
	mailsrvr2.bull.com") by vger.kernel.org with ESMTP id S261781AbVFPRjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 13:39:19 -0400
In-Reply-To: <42B0FE88.1070404@nortel.com>
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/Patch] robust futexes for 2.6.12-rc6
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OFCABD057D.E46C755F-ON07257022.005C74AE-07257022.0060EDCF@us-phx1.az05.bull.com>
From: Todd.Kneisel@Bull.com
Date: Thu, 16 Jun 2005 10:38:43 -0700
X-MIMETrack: Serialize by Router on US-PHX1/US/BULL(Release 6.5.1|January 21, 2004) at
 06/16/2005 10:38:49 AM,
	Serialize complete at 06/16/2005 10:38:49 AM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortel.com> wrote on 06/15/2005 09:22:32 PM:
> Todd Kneisel wrote:
> > This patch adds robust futex support to the existing sys_futex system 
call.
> > The patch applies to 2.6.12-rc6. I have tested this code on an IA64 
SMP
> > system. Any comments or discussion will be welcome.
> 
> How does this compare to the robust mutexes portion of the stuff that 
> Inaky was working on?
> 
> Chris

It's my understanding that Inaky is redesigning the locking
mechanism that the kernel provides for use by the NPTL thread
library. I'm adding robustness to the existing locking mechanism.

Inaky's code adds five system calls, one for each operation,
where I am adding operations to the existing sys_futex call.

Inaky's code is more complex due to the priority inheritance
features. I'm not doing priority inheritance. The application
that Bull is developing does not require priority inheritance.

The user interface in the NPTL thread library should be the
same. The API is based on the Solaris implementation of robust
mutexes. It's not based on Solaris code, only on the
documentation of the API.

I believe that Inaky's NPTL implementation intends to have two
NPTL libraries on the system. The standard one that uses sys_futex,
and an RTNPTL that uses his new system calls. I hope to get my
changes into the standard NPTL library.

Todd
