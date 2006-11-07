Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752249AbWKGTXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbWKGTXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbWKGTXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:23:05 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40927 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751798AbWKGTXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:23:02 -0500
Date: Tue, 7 Nov 2006 11:22:49 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org, mm-commits@vger.kernel.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
In-Reply-To: <20061107095049.B3262@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0611071118010.4614@schroedinger.engr.sgi.com>
References: <200611032205.kA3M5wmJ003178@shell0.pdx.osdl.net>
 <20061107073248.GB5148@elte.hu> <Pine.LNX.4.64.0611070943160.3791@schroedinger.engr.sgi.com>
 <20061107093112.A3262@unix-os.sc.intel.com> <Pine.LNX.4.64.0611070954210.3791@schroedinger.engr.sgi.com>
 <20061107095049.B3262@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006, Siddha, Suresh B wrote:

> tasklet_schedule doesn't schedule if there is already one scheduled.

Correct. The effect of this is to only allow load balancing on one cpu at a 
time. Subsequent attempts to schedule load balancing on other cpus are 
ignored until the cpu that is load balancing has finished. Then the 
others (hopefully) get a turn.

A pretty interesting unintended effect. It certainly solves the concurrent 
load balancing scalability issues and would avoid the need to stagger 
load balancing. Wonder how fair it would be?

