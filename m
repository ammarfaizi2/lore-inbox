Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVEJHOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVEJHOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 03:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVEJHOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 03:14:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38867 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261552AbVEJHOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 03:14:07 -0400
Date: Tue, 10 May 2005 00:13:27 -0700
From: Paul Jackson <pj@sgi.com>
To: Jim Nance <jlnance@sdf.lonestar.org>
Cc: davidsen@tmr.com, davej@redhat.com, willy@w.ods.org, akpm@osdl.org,
       jfbeam@bluetronic.net, nico-kernel@schottelius.org,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-Id: <20050510001327.5197dd21.pj@sgi.com>
In-Reply-To: <20050510022301.GA13763@SDF.LONESTAR.ORG>
References: <20050508012521.GA24268@SDF.LONESTAR.ORG>
	<427FA876.7000401@tmr.com>
	<20050510022301.GA13763@SDF.LONESTAR.ORG>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim wrote:
> I see two problems with encouraging applications to get involved
> with processor selection.

I suspect you are confusing "application" with "not kernel".

There are basically three layers of software on big systems:

 1) kernel
 2) administration (system services, libraries and utilities)
 3) application

Something like a batch manager is an example in layer (2) that needs
extensive knowledge of a systems hardware, and extensive ability to
manage exactly what runs and allocates where.

Large systems very much expect to manage what threads run where. These
API's are already present - check out sched_setaffinity, mbind,
set_mempolicy, and cpusets.  The details of what hardware is where,
including memory, processor and interconnect, are also there as well, in
various /proc and /sys files.

No - we don't expect the application to know all this.  But we absolutely
require that various admin level programs know this stuff in intimate
detail, and enable the administration of large systems in a variety of
ways.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
