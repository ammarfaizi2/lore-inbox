Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTETH4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 03:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263630AbTETH4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 03:56:40 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:42037 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263628AbTETH4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 03:56:39 -0400
Date: Tue, 20 May 2003 01:11:57 -0700
From: Andrew Morton <akpm@digeo.com>
To: paulmck@us.ibm.com
Cc: phillips@arcor.de, hch@infradead.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] vm_operation to avoid pagefault/inval race
Message-Id: <20030520011157.3f6b73a6.akpm@digeo.com>
In-Reply-To: <20030519182305.C1813@us.ibm.com>
References: <200305172021.56773.phillips@arcor.de>
	<20030517124948.6394ded6.akpm@digeo.com>
	<20030519182305.C1813@us.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2003 08:09:33.0672 (UTC) FILETIME=[25A92680:01C31EA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>
> So the general idea is to do something as follows, right?

It sounds reasonable.  A matter of putting together the appropriate
library functions and refactoring a few things.

> 
> o	Make a function, perhaps named something like
> 	install_new_page(), that does the PTE-installation
> 	and RSS-adjustment tasks currently performed by
> 	both do_no_page() and by do_anonymous_page().

That's similar to mm/fremap.c:install_page().  (Which forgets to call
update_mmu_cache().  Debatably a buglet.)

However there is not a lot of commonality between the various nopage()s and
there may not be a lot to be gained from all this.  There is subtle code in
there and it is performance-critical.  I'd be inclined to try to minimise
overall code churn in this work.


