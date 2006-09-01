Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWIARmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWIARmF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWIARmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:42:04 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:2807 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751401AbWIARmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:42:03 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com
In-Reply-To: <1157130970.28577.150.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
	 <1157127483.28577.117.camel@localhost.localdomain>
	 <1157127943.21733.52.camel@localhost>
	 <1157128634.28577.139.camel@localhost.localdomain>
	 <1157129762.21733.63.camel@localhost>
	 <1157130970.28577.150.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 01 Sep 2006 19:42:00 +0200
Message-Id: <1157132520.21733.78.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 10:16 -0700, Dave Hansen wrote:
> This feels like something that can be done with RCU.  The
> __page_discard() is the write operation, right?  So, take an rcu write
> lock inside of the page discard function, and read locks over the
> current places where PG_discarded is set.
> 
> That should make sure that the discard operation itself can't be done
> concurrently with one of the __remove_from*() operations.  Once the
> write lock has been acquired, you just check page->mapping to see if the
> a __remove_from*() operation has occurred while you waited.

The problem of page discard vs. normal page remove is that the page can
be remove and discarded at the same time. Both sides are writers in the
sense that they want to remove the page from page cache. RCU doesn't not
help with that kind of race.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


