Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTGYCWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 22:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269354AbTGYCWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 22:22:46 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:5385 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S265531AbTGYCWp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 22:22:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fredrik Tolf <fredrik@dolda2000.cjb.net>
To: Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Net device byte statistics
Date: Fri, 25 Jul 2003 04:37:50 +0200
User-Agent: KMail/1.4.3
References: <E19fqMF-0007me-00@calista.inka.de>
In-Reply-To: <E19fqMF-0007me-00@calista.inka.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307250437.50928.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 July 2003 02.22, Bernd Eckenfels wrote:
> it is for performance reasons. You can

I almost thought that would be it. I do understand that that code needs to be 
really clean, but, correct me if I'm wrong, but isn't GCC's long long 
implementation efficient enough to only add minimal overhead to that? On 
IA32, it shouldn't take more than one or two more instructions (per counter), 
and it seems to me that net_device_stats should still be small enough to 
avoid any more cache misses.
I'm no expert, of course, so if I'm wrong, please tell me.

> a) collect your numbers more often and asume wrap/reboot  if numbers
> decrease
> b) use iptables counters instead

Currently, I'm sampling once a day, and although sampling more often could, of 
course, solve the problem, it's just that I don't think that it should be 
necessary.
Do the iptables counters take the whole packet into account, or do they ignore 
the ethernet header?

> BTW: it is a very often discussed topic, personally (as net tools
> maintainer) I would love to see 64bit counters here, but this still means
> you have to sample often enough, so you do not lose numbers on crash.

While that is true in theory, I'm just using it to estimate my home net usage, 
and my router hasn't crashed this far, so I'm not very worried about that.

Thank you very much for your input. For now, I'm just going to implement 64 
bit counters in my kernel.

Fredrik Tolf

