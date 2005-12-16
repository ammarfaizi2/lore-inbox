Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVLPIUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVLPIUJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 03:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVLPIUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 03:20:09 -0500
Received: from mailgate.hob.de ([62.91.19.101]:3730 "EHLO mailgate.hob.de")
	by vger.kernel.org with ESMTP id S932178AbVLPIUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 03:20:07 -0500
Message-ID: <43A278B0.3000105@hob.de>
Date: Fri, 16 Dec 2005 09:20:00 +0100
From: Christian Hildner <christian.hildner@hob.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: de-de, de
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
Cc: hawkes@sgi.com, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Keith Owens <kaos@sgi.com>, Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH] ia64: disable preemption in udelay()
References: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com> <20051215225040.GA9086@agluck-lia64.sc.intel.com> <20051216010440.GA9886@agluck-lia64.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony schrieb:

>Moving the current slim-line udelay() out of line would save 41 Kbytes
>of text in the generic vmlinux, plus making any modules that use
>udelay smaller too. Savings run from a 128-160 bytes for drivers
>with just one call to a max of 9 Kbytes for qla2xxx.ko.
>
Tony,

we should really take the chance to make the kernel smaller since we 
don't have to become active to make it bigger. This happens every day by 
itself. Furthermore I'd guess that for the current and future IA64 
implementations we might even win performance by having functions out of 
line since we have a really fast call mechanism here. Of course any 
difference heavily depends on the cache utilization so there would be 
some benchmark needed. At least for the udelay the answer is easy and 
must be "do it out of line".

Did anyone already run a benchmark for comparison of inline vs. out of 
line for IA64? Or does anybody want to do it?

Christian

