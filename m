Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269158AbUIHU4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269158AbUIHU4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 16:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269151AbUIHUzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 16:55:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34730 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269153AbUIHUza
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 16:55:30 -0400
Date: Wed, 8 Sep 2004 16:30:36 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-ID: <20040908193036.GH4284@logos.cnet>
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet> <413F1518.7050608@sgi.com> <20040908165412.GB4284@logos.cnet> <413F5EE7.6050705@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413F5EE7.6050705@sgi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 02:35:03PM -0500, Ray Bryant wrote:
> 
> 
> Marcelo Tosatti wrote:
> 
> >
> >
> >Huh, that changes the meaning of the dirty limits. Dont think its suitable
> >for mainline.
> >
> >
> 
> The change is, in fact, not much different from what is already actually 
> there.  The code in get_dirty_limits() adjusts the value of the user 
> supplied parameters in /proc/sys/vm depending on how much mapped memory 
> there is.  If you undo the convoluted arithmetic that is in there, one 
> finds that if you are using the default dirty_ratio of 40%, then if the 
> unmapped_ratio is between 80% and 10%, then
> 
>    dirty_ratio = unmapped_ratio / 2;
> 
> and, a little bit of algebra later:
> 
>    dirty = (total_pages - wbs->nr_mapped)/2
> 
> and
> 
>    background = dirty_background_ratio/vm_background_ratio * (total_pages
> 	- wbs->nr_mapped)
> 
> That is, for a wide range of memory usage, you are really running with an
> dirty ratio of 50% stated in terms of the number of unmapped pages, and 
> there is no direct way to override this.

OK I see, yes. 

> Of course, at the edges, the code changes these calculations.  It just 
> seems to me that rather than continue the convoluted calculation that is in
> get_dirty_limits(), we just make the outcome more explicit and tell the user
> what is really going on.
> 
> We'd still have to figure out how to encourage a minimum page cache size of
> some kind, which is what I understand the 5% min value for dirty_ratio is 
> in there for.
 
For the user "dirty_ratio" and "dirty_background_ratio" means "percentage
of total memory" (thats how it has been traditionally in Linux). And right now,
 as you noted, we dont do that way.

There's probably a good reason for the "no more than half of unmapped memory".
Andrew ?
