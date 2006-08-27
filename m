Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWH0QCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWH0QCe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWH0QCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:02:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:12984 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932149AbWH0QCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:02:05 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC 6/6] Implement "current" with the PDA.
Date: Sun, 27 Aug 2006 18:01:16 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <20060827084417.918992193@goop.org> <20060827084453.452516832@goop.org>
In-Reply-To: <20060827084453.452516832@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608271801.16406.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 August 2006 10:44, Jeremy Fitzhardinge wrote:
> Use the pcurrent field in the PDA to implement the "current" macro.
> This ends up compiling down to a single instruction to get the current
> task.
> 
> The slightly tricky part about this patch is that cpu_init() uses
> current very early, before the PDA has been set up.  In this instance,
> it uses current_thread_info()->task to get the current task.
> 
> Also, the very early PDA set up for the boot cpu contains the initial
> task pointer so current works from a very early stage.

With that you could remove the code in do_IRQ now that setups up a fake thread_info
for interrupt stacks.

-Andi
