Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751995AbWCBQIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbWCBQIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbWCBQIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:08:22 -0500
Received: from fsmlabs.com ([168.103.115.128]:19083 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751995AbWCBQIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:08:18 -0500
X-ASG-Debug-ID: 1141315696-30442-40-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 2 Mar 2006 08:12:42 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Edgar Hucek <hostmaster@ed-soft.at>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: [PATCH 1/1] EFI: Fix gdt load
Subject: Re: [PATCH 1/1] EFI: Fix gdt load
In-Reply-To: <4406F0C2.7090002@ed-soft.at>
Message-ID: <Pine.LNX.4.64.0603020755090.28074@montezuma.fsmlabs.com>
References: <4406F0C2.7090002@ed-soft.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.9345
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006, Edgar Hucek wrote:

> This patch makes the kernel bootable again on ia32 EFI systems.
> 
> Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>
> 

 	spin_lock(&efi_rt_lock);
 	local_irq_save(efi_rt_eflags);

That looks like a race, not to mention that efi_rt_eflags is a global 
variable. The same strange ordering occurs on unlock, i presume this code 
'works' because it's done early during boot?
