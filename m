Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWIUWle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWIUWle (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWIUWle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:41:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932087AbWIUWla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:41:30 -0400
Date: Thu, 21 Sep 2006 15:41:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mike Waychison <mikew@google.com>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
Message-Id: <20060921154105.904313f7.akpm@osdl.org>
In-Reply-To: <1158876304.26347.129.camel@localhost.localdomain>
References: <1158274508.14473.88.camel@localhost.localdomain>
	<20060915001151.75f9a71b.akpm@osdl.org>
	<45107ECE.5040603@google.com>
	<1158709835.6002.203.camel@localhost.localdomain>
	<1158710712.6002.216.camel@localhost.localdomain>
	<20060919172105.bad4a89e.akpm@osdl.org>
	<1158717429.6002.231.camel@localhost.localdomain>
	<20060919200533.2874ce36.akpm@osdl.org>
	<1158728665.6002.262.camel@localhost.localdomain>
	<20060919222656.52fadf3c.akpm@osdl.org>
	<1158735299.6002.273.camel@localhost.localdomain>
	<20060920105317.7c3eb5f4.akpm@osdl.org>
	<1158876304.26347.129.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 08:05:04 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > So I think there's a nasty DoS here if we permit infinite retries.  But
> > it's not just that - there might be other situations under really heavy
> > memory pressure where livelocks like this can occur.  It's just a general
> > robustness-of-implementation issue.
> 
> Got it. Now, changing args to no_page() will be a pretty big task....
> 

Not as big as removing the pt_regs arg from every interrupt handler ;)

But pretty mechanical.  Problem is, I don't think we have our mechanic.
