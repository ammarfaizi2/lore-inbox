Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTEMPYj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTEMPYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:24:39 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:5927 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261489AbTEMPYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:24:33 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com
In-Reply-To: <Pine.LNX.4.44L0.0305131117240.3274-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305131117240.3274-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052840106.2255.24.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 May 2003 10:35:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 10:26, Alan Stern wrote:

> Putting in a sanity check for the global suspend state will be very easy.  
> But I would like to point out that this "global suspend" does not refer to
> the entire system, only the USB bus.

That is a problem then, because the delay can still
occur during normal system operation.

> I'm not sure under what
> circumstances the bus is placed in global suspend; I think it's just when
> there are no devices attached (or the last remaining device is detached).
> 
> However, there have been cases on my own system where turning off the only
> USB peripheral caused the driver to bounce between suspend_hc() and
> wakeup_hc() several times without any apparent explanation -- possibly as
> a result of transient electrical signals on the bus (?).  So perhaps
> moving that delay out of the ISR isn't such a bad idea.

Agreed. If this can happen on functional USB controllers
when no devices are attached, then it is a serious problem.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


