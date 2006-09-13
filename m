Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWIMO7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWIMO7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWIMO7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:59:08 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:31657 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750908AbWIMO7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:59:06 -0400
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Rik van Riel <riel@redhat.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       rhim@cc.gatech.edu
In-Reply-To: <4508198E.10707@redhat.com>
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>
	 <45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com>
	 <1158137786.2560.3.camel@localhost>  <4507F453.1040809@watson.ibm.com>
	 <1158151535.2560.20.camel@localhost> <45080262.8050009@watson.ibm.com>
	 <4508198E.10707@redhat.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 13 Sep 2006 16:59:03 +0200
Message-Id: <1158159543.2560.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 10:45 -0400, Rik van Riel wrote:
> > But another trouble you have not mentioned is what happens to pages
> > with pending make-volatile that need to and/or have been made stable
> > in the meantime. They too need to be removed from this pending list.
> 
> At the time where you walk the set of pages (pagevec?) to make
> volatile, you can check whether the page flags are still right.

A make volatile can be done anytime as long as the page is in page
cache. Before a page can be made stable the caller needs to make sure
that one of the conditions that prevent a make volatile becomes true.
So a page in the pending make-volatile array does not have to be removed
because a make stable has been done. It only has to be removed if it
gets freed.

> A page that was set to be marked volatile with the hypervisor,
> but later turned stable again would have that indicated in its
> page flags, right?

Several page flag bits and some other conditions like "has a mapping"
and "reference count is map count + 1". Most of the checks that need to
be done for make volatile are on page flags.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


