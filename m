Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWFMN5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWFMN5R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 09:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWFMN5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 09:57:17 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:44234 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751132AbWFMN5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 09:57:17 -0400
Message-ID: <448EC436.6060008@de.ibm.com>
Date: Tue, 13 Jun 2006 15:57:10 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [RFC] Light weight event counters (V2) instead of page state
References: <Pine.LNX.4.64.0606121420150.21448@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606121420150.21448@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> We would like to have some solution that reduces the
> overhead for these counters. VM counters currently require interrupt disabling
> in order to work. Maybe we can avoid that by using the local_t which provides
> an increment operation that is not atomic vs other processors but atomic vs
> interrupts on this same processor.
 >
 > The patchset also adds an off switch for embedded systems that allows a
 > building of linux kernels without these counters.

Did you consider using the statistics infrastructure available in -mm?
(lib/statistic.c, include/linux/statistic.h, Documentation/statistics.txt)

It's a ready-to-use statistics library that comes with similar characteristics
as you have described above.

 > The remaining counters in page_state after the zoned VM counter patch has
 > been applied are all just for show in /proc/vmstat.  They have no essential
 > function for the VM.

To me that looks like a good application for the statistics infrastructure,
which shows statistics through debugfs instead of procfs. Btw., it completely
unburdens exploiting kernel code from the delivery of statistics to users.

	Martin

