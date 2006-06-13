Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932759AbWFMFSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbWFMFSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932888AbWFMFSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:18:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:2201 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932759AbWFMFSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:18:42 -0400
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@sgi.com>
Subject: Re: 2.6.16-rc6-mm2
Date: Tue, 13 Jun 2006 07:18:35 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <10021.1150175320@kao2.melbourne.sgi.com>
In-Reply-To: <10021.1150175320@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606130718.35498.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 07:08, Keith Owens wrote:
> Andi Kleen (on Tue, 13 Jun 2006 06:56:45 +0200) wrote:
> >
> >> I have previously suggested a lightweight solution that pins a process
> >> to a cpu 
> >
> >That is preempt_disable()/preempt_enable() effectively
> >It's also light weight as much as these things can be.
> 
> The difference being that preempt_disable() does not allow the code to
> sleep.  There are some places where we want to use cpu local data 
> and 
> the code can tolerate preemption and even sleeping, as long as the
> process schedules back on the same cpu.

Seems like a pretty obscure case to optimize for.

Anyways if you want to do that you can always do

disable_preempt(); 
set thread affinity mask to current cpu
enable_preempt(); 
do weird stuff and sleep ...  ;
restore affinity mask

Can any of these people proposing "solutions" in this thread
demonstrate this stuff is actually performance critical?

-Andi
