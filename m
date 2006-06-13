Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWFMPYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWFMPYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 11:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWFMPYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 11:24:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:48036 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932137AbWFMPYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 11:24:03 -0400
Date: Tue, 13 Jun 2006 08:23:51 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Peschke <mp3@de.ibm.com>
cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [RFC] Light weight event counters (V2) instead of page state
In-Reply-To: <448EC436.6060008@de.ibm.com>
Message-ID: <Pine.LNX.4.64.0606130817460.28793@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606121420150.21448@schroedinger.engr.sgi.com>
 <448EC436.6060008@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006, Martin Peschke wrote:

> Did you consider using the statistics infrastructure available in -mm?
> (lib/statistic.c, include/linux/statistic.h, Documentation/statistics.txt)

No its not in Linus tree and has even more overhead than the existing 
counters since it always checks if a certain counters is on or off and it 
also does indirect calls to an update function.

It does not use local_t at all and takes an smp_processor_id() parameter 
to various functions which makes the future use of cpu_local_* functions 
not possible (should that implementation get fixed).

> To me that looks like a good application for the statistics infrastructure,
> which shows statistics through debugfs instead of procfs. Btw., it completely
> unburdens exploiting kernel code from the delivery of statistics to users.

The light weight counter implementation here provides the output of 
/proc/vmstat. That is a fixed interface.

