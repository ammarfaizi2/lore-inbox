Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbVJGQmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbVJGQmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbVJGQmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:42:21 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:9228 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S1030502AbVJGQmV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:42:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Fix hotplug cpu on x86_64
Date: Fri, 7 Oct 2005 11:42:13 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D9E@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix hotplug cpu on x86_64
Thread-Index: AcXLW6UodDBLoWAWSX+zV2HuL5ahCgAAExwQ
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Brian Gerst" <bgerst@didntduck.org>,
       "lkml" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 07 Oct 2005 16:42:13.0553 (UTC) FILETIME=[11C6C210:01C5CB5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > sure convenient. I though at the time it would be great if
> > alloc_percpu() mechanism was able to dynamically re-create all the 
> > per_cpu's for new processors, that way cpu_possible_map woun't 
> > probably even be needed. Or is it too much trouble for too 
> little gain...
> 
> The problem is to tell all subsystems to reinitialize the 
> data for possible CPUs (essentially the concept of "possible" 
> CPUs would need to go)  It would need an reaudit of a lot of 
> code. Probably quite some work.

You know Andi, I was imagining something like bitmap or linked list of
all per_cpu vars (dynamically updated) and just going through this
list... Or something like that (maybe some registration mechanism).
There are not too many of them - about two dozens, mostly all sorts of
accounting.

> I think it is better to try to figure out how many hotplug 
> CPUs are supported, otherwise use a small default.

Exactly - such as on ES7000, it can support 32, 64, 128 etc. processors
depending on what configuration the customer actually ordered :)... it
should be something for that, then NR_CPUS could be either defined as
boot parameter or belong to subarchs.
Thanks,
--Natalie
  
> My 
> current code uses disabled CPUs as a heuristic, otherwise 
> half of available CPUs and it can be overwritten by the user.
> 
> -Andi
> 
