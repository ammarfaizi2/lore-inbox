Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbWIMB3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWIMB3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbWIMB3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:29:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30099 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030477AbWIMB3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:29:54 -0400
Message-ID: <45075F09.5010708@redhat.com>
Date: Tue, 12 Sep 2006 21:29:45 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       rhim@cc.gateh.edu
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com> <45074BD0.3060400@watson.ibm.com>
In-Reply-To: <45074BD0.3060400@watson.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> Rik van Riel wrote:

>> Easy enough to pass a vector of pages to the hypervisor.
> 
> Rik, I thought that what we did.
> Martin, I see the code actually does it when the page goes into the 
> hot/cold
> list. I can't remember conciously moving to that.
> I thought we had a decent hit on the hot/cold, so that bulking makes sense.
> 
> Then the interface of bulking could be introduced and for s390 it could 
> internally be implemented as a sequence of ESSA instruction.

Note that the transition _to_ volatile can also be batched
and done somewhat lazily.  For frequently mmaped pages that
could end up saving us the transition the other way, too...

That could make page hinting very acceptable performance wise,
even without a millicode implementation.

-- 
What is important?  What you want to be true, or what is true?
