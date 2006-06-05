Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750714AbWFEH7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWFEH7l (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 03:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWFEH7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 03:59:41 -0400
Received: from gw.goop.org ([64.81.55.164]:51675 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750714AbWFEH7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 03:59:41 -0400
Message-ID: <4483E467.8000504@goop.org>
Date: Mon, 05 Jun 2006 00:59:35 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, dzickus@redhat.com, ak@suse.de,
        Miles Lane <miles.lane@gmail.com>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
References: <4480C102.3060400@goop.org>	<4483DF32.4090608@goop.org> <20060605004823.566b266c.akpm@osdl.org>
In-Reply-To: <20060605004823.566b266c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=6647 has details.
>
> Do you think the suspend breakage is related to that patch?
>   

Yes.  I haven't really worked out what's going on in there, but it looks 
like it's losing track of what it has allocated and running out of timer 
MSRs.  Possibly because the CPUs are reinitialized on resume: it "thaws 
the CPUs", which prints the same CPU information as at boot time - caps, 
bogomips, etc - so I presume it actually redoes those things.  I wonder 
if this makes the performance counter reservation loose track of things?

    J
