Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267197AbUBMXlc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267203AbUBMXlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:41:32 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:58513 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267197AbUBMXl1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:41:27 -0500
Date: Fri, 13 Feb 2004 15:46:47 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>,
       Linux Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: dm core patches
Message-ID: <20040213234647.GB948@beaverton.ibm.com>
Mail-Followup-To: Joe Thornber <thornber@redhat.com>,
	Lars Marowsky-Bree <lmb@suse.de>,
	Linux Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
References: <20040210163548.GC27507@reti> <20040211101659.GF3427@marowsky-bree.de> <20040211103541.GW27507@reti> <20040212185145.GY21298@marowsky-bree.de> <20040212201340.GB1898@reti> <20040213151213.GR21298@marowsky-bree.de> <20040213153936.GF15736@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213153936.GF15736@reti>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber [thornber@redhat.com] wrote:
> > You are missing the obvious answer:
> > 
> > - Periodically checking paths is a user-space issue and doesn't belong
> >   into the kernel. User-space gets to handle this policy.
> 
> Yes, that is obvious, I had wanted to do failback automatically.  But
> pushing it to userland does allow people to write hardware specific
> tests.  I'll try it and see what people think.

Be careful here. Your failback test packet cannot be a media access type
as this could cause volume transition thrashing in some types of
storage units so most likely you will use a test unit ready type packet.
These small size tests are not very good checks on there own for optical
based networks as the laser power needed to send them is really low
(newer vertical cavity lasers have reduced these types of failures, but
they still happens). Auto failback with heuristics and a credit based
model allows the path to be failed back in with a quick ejection and a
increasing time interval to start the whole cycle again. This keeps the
systems from heading into a failover / failback storm.

-andmike
--
Michael Anderson
andmike@us.ibm.com

