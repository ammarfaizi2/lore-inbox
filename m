Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269272AbUIHSSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269272AbUIHSSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269284AbUIHSSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:18:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38559 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269272AbUIHSSI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:18:08 -0400
Date: Wed, 8 Sep 2004 13:54:12 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-ID: <20040908165412.GB4284@logos.cnet>
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet> <413F1518.7050608@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413F1518.7050608@sgi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 09:20:08AM -0500, Ray Bryant wrote:
> 
> 
> Marcelo Tosatti wrote:
> 
> >
> >Andrew, dirty_ratio and dirty_background_ratio (as low as 5% each) did not 
> >significantly affect the amount of swapped out data, only a small effect 
> >on _how soon_ anonymous memory was swapped out.
> >
> 
> I looked at the get_dirty_limits() code and for the test cases I was 
> running,
> we have mapped > 90% of memory.  So what will happen is that dirty_ratio 
> will be thresholded at 5%, and background_ratio will be 1%.  Changing 
> values in /proc won't modify this at all (well, you could force 
> background_ratio to 0%.)
> 
> It seems to me that the 5% number in there is more or less arbitrary.  If 
> we are on a big memory Altix (4 TB), 5% of memory would be 200 GB. That is 
> a lot of page cache.

On such huge memory machines I guess you have no choice but scale down the 
dirty limits for them to be "equivalent" with reference to IO device speed.

And as Martin says it depends on the workload also.

> It seems get_dirty_limits() would be a lot simpler (and automatically scale 
> as memory is mapped) if the limits were interpreted as being in terms of 
> the amount of unmapped memory.  A patch that implements this idea is 
> attached.
> (Andrew -- if it comes to that I can submit this patch inline -- this is 
> just for talking at the moment).
> 
> I'll run a few of the tests with this modified kernel and see if they are 
> any different.

Huh, that changes the meaning of the dirty limits. Dont think its suitable
for mainline.

> >And finally, Ray, the difference you see between 2.6.6 and 2.6.7 can be 
> >explained, as noted by others in this thread, to vmscan.c changes (page 
> >replacement/scanning policy
> >changes were made).
> 
> Yep.  I can probably live with those minor differences though.  I would be 
> happier if the system didn't swap anything at all for low values of 
> swappiness, though.

Now that must work - if its not we have a problem.
