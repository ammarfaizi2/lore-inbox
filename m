Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbWG1KOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWG1KOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 06:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWG1KOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 06:14:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8069 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932613AbWG1KOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 06:14:14 -0400
Message-ID: <44C9E369.7070703@pobox.com>
Date: Fri, 28 Jul 2006 06:14:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jesse Huang <jesse@icplus.com.tw>
CC: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Create IP100A Driver
References: <1154030065.5967.15.camel@localhost.localdomain> <20060727125421.GB22935@tuxdriver.com> <044901c6b1ec$d0f5b680$4964a8c0@icplus.com.tw>
In-Reply-To: <044901c6b1ec$d0f5b680$4964a8c0@icplus.com.tw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang wrote:
> Hi John:
> 
> I will try mutt or mail when i want to send next patch. Most different of
> ip100a.c
> and sundance.c are almost same only fix some bugs. The different of ip100a
> and ip100 is in phy. We can use one driver to support those two device, I
> want
> to know what is better for kernel:
> 
> 1. Only updata sundance.c to support IP100A
> 2. Release ip100a.c which support ip100(sundance) to kernel 2.6.x and ask to
> remove sundance.c.
> 3. Release ip100a.c with sundance.c both to kernel 2.6.x
> 
> We hope to use IP100a.c as our product driver, so 2. and 3. will better for
> IC Plus. But we will still follow your suggestion, if you feel 1. was better
> for kernel.

Although it is occasionally OK to duplicate a driver, I do not see a 
compelling case with ip100a.

The stronger case for a single codebase is won on the strengths of lower 
long-term maintenance costs, increased strength of review, doesn't break 
existing sundance driver uses, and re-use of existing testing benefits.

If you feel strongly about not showing "sundance" to your users, you can 
always submit a one-line MODULE_ALIAS() change which permits users to 
load "ip100a" (really sundance.c).  Using MODULE_ALIAS() seems quite 
reasonable, given that IC Plus appears to be taking the lead in future 
Sundance-like chip development.

So, please resubmit as changes to the existing sundance.c.  This is 
better for the standard Linux kernel engineering process.

Thanks,

	Jeff


