Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275409AbTHNRnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275411AbTHNRnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:43:04 -0400
Received: from fmr03.intel.com ([143.183.121.5]:41462 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S275409AbTHNRnA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:43:00 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
Date: Thu, 14 Aug 2003 10:42:52 -0700
Message-ID: <DD755978BA8283409FB0087C39132BD101B01074@fmsmsx404.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [PATCH] Make modules work in Linus' tree on ARM
Thread-Index: AcNii3zB73/EApMeQKW+0by+kdjj+A==
From: "Luck, Tony" <tony.luck@intel.com>
To: <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Aug 2003 17:42:53.0363 (UTC) FILETIME=[7CFFF030:01C3628B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Thu, 14 Aug 2003, Russell King wrote:
> 
>>After reviewing the /proc/kcore and kclist issues, I've decided that I'm
>>no longer prepared to even _think_ about supporting /proc/kcore on ARM -
> 
> 
> I suspect we should just remove it altogether.
> 
> Does anybody actually _use_ /proc/kcore? It was one of those "cool 
> feature" things, but I certainly haven't ever used it myself except for 
> testing, and it's historically often been broken after various kernel 
> infrastructure updates, and people haven't complained..

I only fixed it up because someone at SGI complained that
my ia64 kernel virtual space re-arrangements had broken it
(even more ... it had never been right for ia64).

Even now, it's still full of races (e.g. if you start gdb to
look at /proc/kcore, then load or unload modules).

Plus gdb doesn't really understand that kcore is a special
file, so it caches values (read "jiffies" twice and notice
that it doesn't change ... because gdb cached the read).

So don't mistake my recent activity fixing kcore for interest
in its continued existence.

-Tony Luck
