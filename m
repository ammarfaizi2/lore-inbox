Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbTHUIF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 04:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbTHUIF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 04:05:28 -0400
Received: from ns.suse.de ([195.135.220.2]:25741 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262509AbTHUIFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 04:05:22 -0400
Message-ID: <3F447D40.5020000@suse.de>
Date: Thu, 21 Aug 2003 10:05:20 +0200
From: Hannes Reinecke <Hannes.Reinecke@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: BKL on reboot ?
References: <3F434BD1.9050704@suse.de>	 <20030820112918.0f7ce4fe.akpm@osdl.org>	 <20030820113520.281fe8bb.davem@redhat.com> <1061411024.9371.33.camel@nighthawk>
In-Reply-To: <1061411024.9371.33.camel@nighthawk>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
[ .. ]
> 
> Or, are you saying that a CPU could have the BKL, and have
> stop_this_cpu() called on it?  I guess we could add
> release_kernel_lock() to stop_this_cpu().
Exactly what happened here. CPU#1 entered sys_reboot, got BKL and 
prepared to stop. It will never release BKL, leaving a nice big window 
for CPU#0 to deadlock.

releasing BKL before calling do_machine_restart seems to do the trick, 
though.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Deutschherrnstr. 15-19			+49 911 74053 688
90429 Nürnberg				http://www.suse.de

