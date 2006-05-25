Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWEYEfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWEYEfT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWEYEfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:35:19 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:152 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964992AbWEYEfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:35:17 -0400
Message-ID: <447533FB.1080400@garzik.org>
Date: Thu, 25 May 2006 00:35:07 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jon Mason <jdmason@us.ibm.com>
CC: Andi Kleen <ak@suse.de>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/4] x86-64: Calgary IOMMU - move valid_dma_direction
 into the callers
References: <20060525033550.GD7720@us.ibm.com>
In-Reply-To: <20060525033550.GD7720@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Mason wrote:
>>From Andi Kleen's comments on the original Calgary patch, move
> valid_dma_direction into the calling functions.
> 
> Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
> Signed-off-by: Jon Mason <jdmason@us.ibm.com>

Even though BUG_ON() includes unlikely(), this introduces additional 
tests in very hot paths.

_Why_ do we need this at all?

I would prefer to NAK the patch, and fix the odd user that gets it 
wrong.  It becomes REALLY obvious that a driver has gotten this wrong, 
REALLY quickly.

I see no need to burden critical hot paths with dumb checks like this.

	Jeff



