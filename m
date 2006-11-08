Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422626AbWKHT2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422626AbWKHT2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161721AbWKHT2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:28:23 -0500
Received: from mga05.intel.com ([192.55.52.89]:53766 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161694AbWKHT2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:28:21 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="13405789:sNHT19614699"
Subject: Re: 2.6.19-rc1: Volanomark slowdown
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Olaf Kirch <okir@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       davem@sunset.davemloft.net, kuznet@ms2.inr.ac.ru,
       netdev@vger.kernel.org
In-Reply-To: <20061108162955.GA4364@suse.de>
References: <1162924354.10806.172.camel@localhost.localdomain>
	 <1163001318.3138.346.camel@laptopd505.fenrus.org>
	 <20061108162955.GA4364@suse.de>
Content-Type: text/plain
Organization: Intel
Date: Wed, 08 Nov 2006 10:38:52 -0800
Message-Id: <1163011132.10806.189.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 17:29 +0100, Olaf Kirch wrote:

> Is it proven that the number of ACKs actually cause bandwidth problems?
> I found Volanomark to exercise the scheduler more than anything else,
> so maybe the slowdown, while triggered by an increased number of ACKs,
> is caused by something else entirely.
> 

The patch in question affects purely TCP and not the scheduler.  I don't
think the scheduler has anything to do with the slowdown seen after
the patch is applied.

The total number of messages being exchanged around the chatrooms in 
Volanomark remain unchanged.  But ACKS increase by 3.5 times and
segments received increase by 38% from netstat.  

ACK is comparable in size to the actual Volanomark messages as 
those are  pretty small (<100 byte).

So I think it is reasonable to conclude that the increase in TCP traffic
reduce the bandwidth and throughput in Volanomark.

However, Volanomark is just a benchmark to alert us to changes.  
If in real applications with small segment, this patch is 
needed to fix congestion window adjustment as Dave pointed 
out, and impact on bandwidth not as important, so be it.

Tim
