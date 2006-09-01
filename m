Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWIASDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWIASDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 14:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWIASDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 14:03:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:39053 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750696AbWIASDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 14:03:15 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Dave Hansen <haveblue@us.ibm.com>
To: schwidefsky@de.ibm.com
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com
In-Reply-To: <1157132520.21733.78.camel@localhost>
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
Content-Type: text/plain
Date: Fri, 01 Sep 2006 11:03:00 -0700
Message-Id: <1157133780.18728.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 19:42 +0200, Martin Schwidefsky wrote: 
> The problem of page discard vs. normal page remove is that the page can
> be remove and discarded at the same time. Both sides are writers in the
> sense that they want to remove the page from page cache. RCU doesn't not
> help with that kind of race. 

OK.  It comes down to a race between 

	__remove_from_page_cache()/__delete_from_swap_cache()

and

	__page_discard()

running on the same page at the same time.  Right?

-- Dave

