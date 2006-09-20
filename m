Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWITGzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWITGzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 02:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWITGzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 02:55:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:2523 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750894AbWITGzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 02:55:32 -0400
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Waychison <mikew@google.com>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060919222656.52fadf3c.akpm@osdl.org>
References: <1158274508.14473.88.camel@localhost.localdomain>
	 <20060915001151.75f9a71b.akpm@osdl.org> <45107ECE.5040603@google.com>
	 <1158709835.6002.203.camel@localhost.localdomain>
	 <1158710712.6002.216.camel@localhost.localdomain>
	 <20060919172105.bad4a89e.akpm@osdl.org>
	 <1158717429.6002.231.camel@localhost.localdomain>
	 <20060919200533.2874ce36.akpm@osdl.org>
	 <1158728665.6002.262.camel@localhost.localdomain>
	 <20060919222656.52fadf3c.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 16:54:59 +1000
Message-Id: <1158735299.6002.273.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's a choice between two behaviours:
> 
> a) get stuck in the kernel until someone kills you and
> 
> b) fault the page in and proceed as expected.
> 
> Option b) is better, no?

That's what I don't understand... where is the actual race that can
cause the livelock you are mentioning. Is this that TryLock always
fails, we wait, the lock gets available but since we have dropped the
semaphore around the wait, it might get stolen again by the time we are
taking the mmap_sem back and that going on ever and ever again while
lock_page() would get precedence since we have the mmap_sem ?

Ben.


