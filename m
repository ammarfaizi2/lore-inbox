Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTENRi6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTENRi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:38:57 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:47925 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263398AbTENRi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:38:56 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030509142828.59552d0a.akpm@digeo.com>
References: <1052323940.2360.7.camel@diemos>
	 <1052336482.2020.8.camel@diemos> <20030507152856.2a71601d.akpm@digeo.com>
	 <1052402187.1995.13.camel@diemos> <20030508122205.7b4b8a02.akpm@digeo.com>
	 <1052503920.2093.5.camel@diemos> <1052512235.2997.8.camel@diemos>
	 <20030509142828.59552d0a.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052934617.2138.4.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 May 2003 12:50:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 16:28, Andrew Morton wrote:
> Paul Fulghum <paulkf@microgate.com> wrote:
> >
> > In the process of eliminating kernel options to isolate
> > the problem, eliminating USB completely appears to fix it.
> > 
> > One machine (server) was using usb-uhci and
> > the other (laptop) was using usb-ohci.
> > 
> > So it looks like something with USB in 2.5.68-bk11

The latency problem seen on the laptop turned out to
be a stupid mistake on my part: I enabled the ALI15XX
IDE controller option as a module instead of in kernel
and so it was not available for using DMA mode. Once
corrected the latency is running at a smooth 20us without
the >5ms spikes associated with PIO IDE.

Final Diagnosis:

server latency problem = USB wakeup_hc() delay added in 2.5.68-bk11
laptop latency problem = user with dain bramage

Thanks,
Paul

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


