Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVCQXGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVCQXGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVCQXG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:06:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:17362 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261340AbVCQXG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:06:27 -0500
Date: Thu, 17 Mar 2005 15:06:21 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nish Aravamudan <nish.aravamudan@gmail.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
In-Reply-To: <29495f1d05031714596de3b335@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0503171505260.10205@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
 <29495f1d05031714596de3b335@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Nish Aravamudan wrote:

> > +       if (system_state != SYSTEM_RUNNING)
> > +               return;
> > +
> > +        while (avenrun[0] >= ((unsigned long)sysctl_scrub_load << FSHIFT))
> > +               schedule_timeout(30*HZ);
>
> This is a busy-loop, unless you set the state before you call
> schedule_timeout(). Additionally, you really want to sleep 30 seconds

Ahh. Missed that thanks.

> at a time? Please use msleep() or msleep_interruptible(), unless you
> expect wait-queue events.

I want to sleep 30 seconds because the system load is unlikely to change
frequently.
