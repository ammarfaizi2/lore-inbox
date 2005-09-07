Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVIGFpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVIGFpQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 01:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVIGFpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 01:45:16 -0400
Received: from smtp.istop.com ([66.11.167.126]:23188 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1750706AbVIGFpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 01:45:14 -0400
From: Daniel Phillips <phillips@istop.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Wed, 7 Sep 2005 01:48:18 -0400
User-Agent: KMail/1.8
Cc: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <431E497A.4080303@rtr.ca> <200509070016.42121.phillips@istop.com>
In-Reply-To: <200509070016.42121.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509070148.18822.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 September 2005 00:16, Daniel Phillips wrote:
> ...as long as ->task and ->previous_esp are initialized,
> staying on the bigger stack looks fine (previous_esp is apparently used
> only for backtrace) ... just like do_IRQ.

Ahem, but let me note before somebody else does: it isn't interrupt context, 
it is normal process context - while an interrupt can ignore most of the 
thread_info fields, a normal process has to worry about all 9.  To be on the 
safe side, the first 8 need to be copied into and out of the ndis stack, with 
preempt disabled until after the stack switch.

Regards,

Daniel
