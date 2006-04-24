Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWDXHMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWDXHMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 03:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWDXHMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 03:12:47 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:18828 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750977AbWDXHMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 03:12:47 -0400
Date: Mon, 24 Apr 2006 16:12:46 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Kirill Korotaev <dev@openvz.org>
Cc: sekharan@us.ibm.com, akpm@osdl.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Valerie.Clement@bull.net, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
In-Reply-To: <444C7427.6080607@openvz.org>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	<1145630992.3373.6.camel@localhost.localdomain>
	<1145638722.14804.0.camel@linuxchandra>
	<20060421155727.4212c41c.akpm@osdl.org>
	<1145670536.15389.132.camel@linuxchandra>
	<20060421191340.0b218c81.akpm@osdl.org>
	<1145683725.21231.15.camel@linuxchandra>
	<20060424011053.B89707402F@sv1.valinux.co.jp>
	<444C5698.5080503@openvz.org>
	<20060424054103.091757402D@sv1.valinux.co.jp>
	<444C7427.6080607@openvz.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060424071246.450767402D@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006 10:45:59 +0400
Kirill Korotaev <dev@openvz.org> wrote:

> >>>>Yes, it is effective, and the reclamation is O(1) too. It has couple of
> >>>>problems by design, (1) doesn't handle shared pages and (2) doesn't
> >>>>provide support for both min_shares and max_shares.
> >>>
> >>>Right.  I wanted to show proof-of-cencept of the pzone based controller
> >>>and implemented minimal features necessary as the memory controller.
> >>>So, the pzone based controller still needs development and some cleanup.
> >>
> >>Just out of curiosity, how it was meassured that it is effective?
> > 
> > I don't have any benchmark numbers yet, so I can't explain the
> > effectiveness with numbers.  I've been looking for the way to
> > measure the cost of pzones correctly, but I've not found it out yet.
> > 
> >>How does it work when there is a global memory shortage in the system?
> > 
> > I guess you are referring to the situation that global memory is running
> > out but there are free pages in pzones.  These free pages in pzones are
> > handled as reserved for pzone users and not used even in global memory 
> > shortage.
> ok. Let me explain what I mean.
> Imagine the situation with global memory shortage. In kernel, there are 
> threads which do some job behalf the user, e.g. kjournald, loop etc. If 
> the user has some pzone memory, but these threads fail to do their job 
> some nasty things can happen (ext3 problems, deadlocks, OOM etc.)
> If such behaviour is ok for you, then great. But did you consider it?
> 
> Also, I can't understand how it works with OOM killer. If pzones has 
> enough memory, but there is a global shortage, who will be killed?

I understand.
IMHO, only the system processes should use global memory.
User processes that may cause such memory shortage should be 
enclosed in pzones first.

Thanks,

-- 
KUROSAWA, Takahiro
