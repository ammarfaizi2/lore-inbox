Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVESSGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVESSGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 14:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVESSGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 14:06:23 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:45732 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261184AbVESSGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 14:06:21 -0400
Subject: Re: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01
	when RT program dumps core]
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dwalker@mvista.com, Linus Torvalds <torvalds@osdl.org>,
       kus Kusche Klaus <kus@keba.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1116524583.21388.299.camel@localhost.localdomain>
References: <AAD6DA242BC63C488511C611BD51F367323212@MAILIT.keba.co.at>
	 <1116503763.15866.9.camel@localhost.localdomain>
	 <1116509820.15866.28.camel@localhost.localdomain>
	 <1116523552.14229.64.camel@dhcp153.mvista.com>
	 <1116524583.21388.299.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 19 May 2005 14:05:53 -0400
Message-Id: <1116525953.4097.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 18:43 +0100, Alan Cox wrote:
> On Iau, 2005-05-19 at 18:25, Daniel Walker wrote:
> > I've seen a RT yield warning on this yield while running the FUSYN
> > tests .. I can't imagine why it's there either.
> 
> Would it not make more sense to kick a task out of hard real time at the
> point it begins dumping core. The core dumping sequence was never
> something that thread intended to execute at real time priority
> 

That's what I recommended in an earlier email.  I figured I'd wait to
see Ingo's response before sending him any patches.  The drop from RT
should probably be after the zap_threads, that way it can kill those
using the same mm right away.  Which also goes to say, we should get rid
of that yield.

-- Steve


