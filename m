Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWGFR6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWGFR6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWGFR6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:58:14 -0400
Received: from unn-206.superhosting.cz ([82.208.4.206]:5019 "EHLO
	mail.aiken.cz") by vger.kernel.org with ESMTP id S1030374AbWGFR6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:58:14 -0400
Message-ID: <44AD4F34.1080307@kernel-api.org>
Date: Thu, 06 Jul 2006 19:58:12 +0200
From: Lukas Jelinek <info@kernel-api.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; cs-CZ; rv:1.7.12) Gecko/20050915
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: moreau francis <francis_moreau2000@yahoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: __pa() versus virt_to_phys()
References: <20060706164107.89250.qmail@web25806.mail.ukl.yahoo.com>
In-Reply-To: <20060706164107.89250.qmail@web25806.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could anybody tell me the difference between these two symbols ?
> 
> I know that one is a macro and the other one is an inline function,
> so the latter performs type checkings but I don't see anything else.
> 
> thanks
> 
> Francis
> 

Here is the answer (by Dave Hansen, 2004):

__pa() is simply supposed to be the addr-PAGE_OFFSET calculation.
virt_to_phys() will be guaranteed to take care of any layout changes if
kernel addresses ever fail to be mapped flat, and 1:1 with the physical
address layout.

So, let's say that someone is working on ... say ... memory hotplug.
They will be modifying the virt_to_phys() function to make up for any
weird mappings that are going on.  But, they'll leave __{v,p}a alone,
because those are used for stuff that occurs very early, even at compile
time.

More virt_to_phys() and less __pa() will save me lots of auditing later
on :)  If you're not in early boot, or really know what you're doing,
use virt_to_phys() and cousins.

Plus, it's more type safe.



Lukas Jelinek
