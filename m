Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268728AbUHTUbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268728AbUHTUbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268727AbUHTU3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:29:37 -0400
Received: from smtp.virgilio.it ([212.216.176.142]:33427 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S268722AbUHTU2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:28:52 -0400
Message-ID: <41265EF2.3000703@crocetta.org>
Date: Fri, 20 Aug 2004 22:28:34 +0200
From: sandr8 <sandr8@crocetta.org>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       kernel@gentoo.org, lartc@mailman.ds9a.nl, netdev@oss.sgi.com
Subject: Re: [PATCH] bio_uncopy_user mem leak
References: <1092909598.8364.5.camel@localhost>	<412489E5.7000806@kolivas.org>	<1092923494.12138.1667.camel@watt.suse.com>	<20040819195521.GC12363@tpkurt.garloff.de>	<41256DC9.7070500@kolivas.org> <20040819233155.68c1411e.akpm@osdl.org>
In-Reply-To: <20040819233155.68c1411e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Con Kolivas <kernel@kolivas.org> wrote:
>
>Uh, I guess that depends on how rested Linus feels when he returns.  I
>think there's a fairly significant networking fix too.  As I said: we'll see
>
is that the one related to the qdisc private data alignment? if not, 
that one would be a urgent one too imho...
i got many oops from the ext3 commit and this because all of the 
schedulers in the 2.6.8 and 2.6.8.1 traffic control suite are accessing 
data at slightly wrong positions.
this because if any discipline different from pfifo fast is used, the 
kmalloc()ed memory is aligned in the old way, but then it is used in the 
new one.
the results could be catastrophic whenever the accessed data is a 
pointer and the memory referenced is written to. :-\

Alessandro Salvatori
