Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWB0Im0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWB0Im0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWB0Im0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:42:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50387 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932313AbWB0ImZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:42:25 -0500
Subject: Re: [Patch 4/7] Add sysctl for delay accounting
From: Arjan van de Ven <arjan@infradead.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <4402BA93.5010302@watson.ibm.com>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141028322.5785.60.camel@elinux04.optonline.net>
	 <1141028784.2992.58.camel@laptopd505.fenrus.org>
	 <4402BA93.5010302@watson.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 09:42:23 +0100
Message-Id: <1141029743.2992.71.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 03:38 -0500, Shailabh Nagar wrote:
> Arjan van de Ven wrote:
> 
> >>+/* Allocate task_delay_info for all tasks without one */
> >>+static int alloc_delays(void)
> >>    
> >>
> >
> >I'm sorry but this function seems to be highly horrible
> >  
> >
> Could you be more specific ? Is it the way its coded or the design 
> (preallocate, then assign)
> itself ?
> 
> The function needs to allocate task_delay_info structs for all tasks 
> that might
> have been forked since the last time delay accounting was turned off.
> Either we have to count how many such tasks there are, or preallocate
> nr_tasks (as an upper bound) and then use as many as needed.

it generally feels really fragile, especially with the task enumeration
going to RCU soon. (eg you'd lose the ability to lock out new task
creation)

On first sight it looks a lot better to allocate these things on demand,
but I'm not sure how the sleeping-allocation would interact with the
places it'd need to be called...


