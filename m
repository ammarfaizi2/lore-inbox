Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVEITWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVEITWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 15:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVEITWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 15:22:19 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:6865 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261478AbVEITWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 15:22:16 -0400
Subject: Re: [PATCH] Priority Lists for the RT mutex
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: linux-kernel@vger.kernel.org,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1115662430.16016.4.camel@dhcp153.mvista.com>
References: <F989B1573A3A644BAB3920FBECA4D25A0331776B@orsmsx407>
	 <427C6D7D.878935F1@tv-sign.ru> <20050509073043.GA12976@elte.hu>
	 <427F1A99.58BCCB88@tv-sign.ru>  <20050509091133.GA25959@elte.hu>
	 <1115662430.16016.4.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 09 May 2005 15:21:46 -0400
Message-Id: <1115666506.15027.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 11:13 -0700, Daniel Walker wrote:
> On Mon, 2005-05-09 at 02:11, Ingo Molnar wrote:
> 
> > What would be nice to achieve are [low-cost] reductions of the size of 
> > struct rt_mutex (in include/linux/rt_lock.h), upon which all other 
> > PI-aware locking objects are based. Right now it's 9 words, of which 
> > struct plist is 5 words. Would be nice to trim this to 8 words - which 
> > would give a nice round size of 32 bytes on 32-bit.
> 
> Why not make rt_mutex->wait_lock a pointer ? Set it to NULL and handle
> it in rt.c .

That may make the rt_mutex structure smaller but this increases the size
of the kernel by the size of that pointer (times every rt_mutex in the
kernel!). You still need to allocate the size of the raw spin lock,
although now you just point to it. Is rounding worth that much overhead?

-- Steve

