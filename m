Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWBKAb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWBKAb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 19:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWBKAb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 19:31:56 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:680 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932271AbWBKAbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 19:31:52 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43ED3046.6020407@s5r6.in-berlin.de>
Date: Sat, 11 Feb 2006 01:31:02 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-mm1 -- BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()
References: <a44ae5cd0602101207s4b2d61d7nc6705067b7913322@mail.gmail.com> <20060210122131.4b98cfb4.akpm@osdl.org>
In-Reply-To: <20060210122131.4b98cfb4.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.516) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Miles Lane <miles.lane@gmail.com> wrote:
>>BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()
> 
> That's a -mm-only warning telling you that get_phy_reg() is doing a
> one-millisecond-or-more busywait while local interrupts are disabled.

Same with set_phy_reg, ohci_soft_reset, ohci_hw_csr_reg. At least the 
callers of ohci_hw_csr_reg (in particular, csr_highlevel.host_reset, 
furthermore csr_highlevel.add_host) could fairly easily be converted to 
a workqueue job or perhaps moved to the nodemgr thread. I have not 
checked the other offending functions yet.
-- 
Stefan Richter
-=====-=-==- --=- -=-==
http://arcgraph.de/sr/
