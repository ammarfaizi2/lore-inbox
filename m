Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVCRFnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVCRFnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 00:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVCRFnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 00:43:24 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:38211 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261438AbVCRFnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 00:43:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oorC7K55IzbnxfRvTFCBsluVguzNZHwJLkHzo+Pt0heyp3bh8EtjAB3LlzNTfE9wBfA3EZbdX2HSS15ndp9Tsl0B+OsoC5rMqa6lQmTrK4W7Zb4ko/7MqhY2bdC3x2snF047rusuWoSsbQTODw11Rk7i3APFhF+7hVoWy25qzRs=
Message-ID: <29495f1d050317214315f6da3d@mail.gmail.com>
Date: Thu, 17 Mar 2005 21:43:17 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] Prezeroing V8 + free_hot_zeroed_page + free_cold_zeroed page
Cc: Jason Uhlenkott <jasonuhl@sgi.com>, Andrew Morton <akpm@osdl.org>,
       holt@sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0503171808540.11258@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
	 <20050317140831.414b73bb.akpm@osdl.org>
	 <Pine.LNX.4.58.0503171459310.10205@schroedinger.engr.sgi.com>
	 <20050318020645.GC156968@dragonfly.engr.sgi.com>
	 <Pine.LNX.4.58.0503171808540.11258@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005 18:09:11 -0800 (PST), Christoph Lameter
<clameter@sgi.com> wrote:
> On Thu, 17 Mar 2005, Jason Uhlenkott wrote:
> 
> > On Thu, Mar 17, 2005 at 05:36:50PM -0800, Christoph Lameter wrote:
> > > +        while (avenrun[0] >= ((unsigned long)sysctl_scrub_load << FSHIFT)) {
> > > +           set_current_state(TASK_UNINTERRUPTIBLE);
> > > +           schedule_timeout(30*HZ);
> > > +   }
> >
> > This should probably be TASK_INTERRUPTIBLE.  It'll never actually get
> > interrupted either way since kernel threads block all signals, but
> > sleeping uninterruptibly contributes to the load average.
> 
> Correct. .... I just do not seem to be able to get this right.

I think msleep_interruptible(30000) would be your best choice, then. 
Maybe with a comment that you don't actually expect signals, but are
using TASK_INTERRUPTIBLE to avoid contributing to load average (that
way, if the loadavg calculation changes someday, somebody will be able
to change your sleep over appropriately).

Thanks,
Nish
