Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVKTRgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVKTRgs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 12:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVKTRgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 12:36:48 -0500
Received: from ns2.suse.de ([195.135.220.15]:22717 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751297AbVKTRgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 12:36:47 -0500
Date: Fri, 18 Nov 2005 17:05:07 +0100
From: "Andi Kleen" <ak@suse.de>
To: virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       bunk@stusta.de
Message-ID: <437DFBB3.mailLJC11TKEB@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sender: ak@brahms.suse.de
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
References: <20051118014055.GK11494@stusta.de>
From: Andi Kleen <ak@suse.de>
Date: 18 Nov 2005 17:05:07 +0100
In-Reply-To: <20051118014055.GK11494@stusta.de>
Message-ID: <p73lkzmhrgs.fsf@brahms.suse.de>
Lines: 17
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Adrian Bunk <bunk@stusta.de> writes:

> virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
> on i386.

I don't think you can do that. We still need these functions in low 
level architecture code at least.

Using __pa/__va doesn't cut it because it won't work on Xen guests
which have different views on bus vs physical addresses. The Xen
code is (hopefully) in the process of being merged, so intentionally
breaking them isn't a good idea.

So if anything there would need to be replacement functions for it
first that do the same thing. But why not just keep the old ones?

-Andi
