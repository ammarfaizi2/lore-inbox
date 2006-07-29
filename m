Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWG2BZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWG2BZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 21:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbWG2BZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 21:25:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22181 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161150AbWG2BZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 21:25:09 -0400
Date: Fri, 28 Jul 2006 18:24:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       ebiederm@xmission.com
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
Message-Id: <20060728182450.8f5cbf76.akpm@osdl.org>
In-Reply-To: <1154135792.2557.7.camel@localhost.localdomain>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<1154112276.3530.3.camel@amdx2.microgate.com>
	<20060728144854.44c4f557.akpm@osdl.org>
	<20060728233851.GA35643@muc.de>
	<1154132126.3349.8.camel@localhost.localdomain>
	<1154135792.2557.7.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 20:16:32 -0500
Paul Fulghum <paulkf@microgate.com> wrote:

> On Fri, 2006-07-28 at 19:15 -0500, Paul Fulghum wrote:
> > I'm doing a build on my home machine now to see if it
> > happens there also.
> 
> Well, the timer int 0 problem does not happen on my home machine.
> However, it still crashes in early boot for a different reason.
> 
> 2.6.18-rc2 works fine with same config.
> 
> In this case the error is:
> 
> No per-cpu room for modules

yeah, sorry, that's a known problem which nobody appears to be doing
anything about.  The expansion of NR_IRQS gobbles all the percpu memory in
the kstat structure.

I assume you have a large NR_CPUS?  Decreasing it should help.
