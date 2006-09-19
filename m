Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751895AbWISKoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbWISKoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 06:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWISKoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 06:44:03 -0400
Received: from twin.jikos.cz ([213.151.79.26]:13004 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751895AbWISKoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 06:44:02 -0400
Date: Tue, 19 Sep 2006 12:43:29 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: David Brownell <david-b@pacbell.net>
cc: linux-usb-devel@lists.sourceforge.net, dbrownell@users.sourceforge.net,
       weissg@vienna.at, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [linux-usb-devel] [PATCH] USB: consolidate error values from
 EHCI, UHCI and OHCI _suspend()
In-Reply-To: <200609181909.53498.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.64.0609191238030.26418@twin.jikos.cz>
References: <Pine.LNX.4.64.0609190340310.9787@twin.jikos.cz>
 <200609181909.53498.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2006, David Brownell wrote:

> > EHCI, UHCI and OHCI USB host drivers are not consistent when returining 
> > error values from their _suspend() functions, in case that the device is 
> > not in suspended state. This could confuse users, so let all three of them 
> > return -EBUSY.
> Shouldn't you also update uhci_suspend()?  Currently it just ignores 
> hcd->state ...

You are right that the patch is possibly not fully correct. I was trying 
to fix the situation I was getting into with the bug in usb_resume_both() 
(see my "[PATCH] 2.6.18-rc6-mm2 - usb_resume_both() - fix suspend/resume" 
mail from yesterday), but now it is obvious that the EINVAL from UHCI is 
of a "different kind" than EBUSY from OHCI and UHCI (though they are 
triggered in the same situations -- when the previous resume was not done 
correctly).

As far as I can see, the UHCI driver is, strangely enough, not using 
hcd->state at all. 

(by the way, EHCI and OHCI seem to have broken (read: missing) locking 
when accessing the hcd->state. Should I fix it by per-hcd spinlock, or 
does the patch already exist somewhere?)

Thanks,

-- 
Jiri Kosina
