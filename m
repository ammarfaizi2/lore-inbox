Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWA0KiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWA0KiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWA0KiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:38:12 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:51350 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1030293AbWA0KiM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:38:12 -0500
Message-ID: <43D9F7FD.8010102@cosmosbay.com>
Date: Fri, 27 Jan 2006 11:37:49 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Andrew Morton <akpm@osdl.org>, penberg@cs.helsinki.fi,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org>	<43D785E1.4020708@shadowen.org>	<84144f020601250644h6ca4e407q2e15aa53b50ef509@mail.gmail.com>	<43D7AB49.2010709@shadowen.org>	<1138212981.8595.6.camel@localhost>	<43D7E83D.7040603@shadowen.org>	<84144f020601252303x7e2a75c6rdfe789d3477d9317@mail.gmail.com>	<43D96758.4030808@shadowen.org> <20060126192342.7341f9b2.akpm@osdl.org> <43D9B7AD.2030603@cosmosbay.com> <43D9F20F.1000906@shadowen.org>
In-Reply-To: <43D9F20F.1000906@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 27 Jan 2006 11:37:49 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft a écrit :
> Eric Dumazet wrote:
>> The NULL choice was maybe wrong. We might need more than one page to
>> fully catch all accesses. Something like 32KB.
> 
> The crash behavoir is handy to catch that the problem exists, and is
> very cheap (0 cost) at run time.  However, once its known I think we
> need something more targetted to allow tracking of the cause.  Perhaps
> we could set the offset thingy to -1 or something and simply do
> something like the following in per_cpu():
> 
> 	if (__per_cpu_offset[i] == -1)
> 		BUG();
> 	else
> 		*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu])
> 

Yes we can set __per_cpu_offset[not_possible_cpu] to 0, because 
[__per_cpu_start,__per_cpu_end) is in init section and should be discarded in 
free_initmem(). I'm not sure if the freed virtual space can later be reused.

Eric
