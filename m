Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268705AbTBZKRg>; Wed, 26 Feb 2003 05:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268706AbTBZKRf>; Wed, 26 Feb 2003 05:17:35 -0500
Received: from packet.digeo.com ([12.110.80.53]:46534 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268705AbTBZKRf>;
	Wed, 26 Feb 2003 05:17:35 -0500
Date: Wed, 26 Feb 2003 02:28:19 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: schlicht@uni-mannheim.de, torvalds@transmeta.com, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
Message-Id: <20030226022819.44e1873a.akpm@digeo.com>
In-Reply-To: <20030226111905.GA32415@suse.de>
References: <200302251908.55097.schlicht@uni-mannheim.de>
	<20030226103742.GA29250@suse.de>
	<20030226015409.78e8e1fb.akpm@digeo.com>
	<20030226111905.GA32415@suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Feb 2003 10:27:44.0616 (UTC) FILETIME=[B3298E80:01C2DD81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> btw, (unrelated) shouldn't smp_call_function be doing magick checks
> with cpu_online() ?

Looks OK?  It sprays the IPI out to all the other CPUs in cpu_online_map,
and waits for num_online_cpus()-1 CPUs to answer.

All very racy in the presence of CPUs going offline, but that's all over
the place.  Depends how the offlining will be done I guess.



