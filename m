Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWIASbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWIASbs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 14:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWIASbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 14:31:48 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:34712 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750744AbWIASbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 14:31:47 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com
In-Reply-To: <1157135024.18728.19.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
	 <1157127483.28577.117.camel@localhost.localdomain>
	 <1157127943.21733.52.camel@localhost>
	 <1157128634.28577.139.camel@localhost.localdomain>
	 <1157129762.21733.63.camel@localhost>
	 <1157130970.28577.150.camel@localhost.localdomain>
	 <1157132520.21733.78.camel@localhost>
	 <1157133780.18728.6.camel@localhost.localdomain>
	 <1157133841.21733.79.camel@localhost>
	 <1157135024.18728.19.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 01 Sep 2006 20:31:44 +0200
Message-Id: <1157135504.21733.83.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 11:23 -0700, Dave Hansen wrote:
> OK, and there's no other workable solution to exclude each other from
> running at the same time than a bit in page->flags?
> 
> It seems like that hashed lock (or lock in mem_map[]) we were talking
> about earlier might be applicable here, too.

The indication which page has already been removed from the page cache
by a discard fault is by definition per-page. The situation is different
compared to the one with PG_state_change which is used to protect
critical sections. After the cpu left the critical section the bit can
be clear again. The discard bit cannot be cleared until the page really
has been freed.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


