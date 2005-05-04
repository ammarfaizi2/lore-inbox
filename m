Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVEDRzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVEDRzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVEDRzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:55:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26810 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261228AbVEDRyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:54:54 -0400
Date: Wed, 4 May 2005 13:54:48 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Nikita Danilov <nikita@clusterfs.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] cleanup of use-once
In-Reply-To: <17015.26421.403622.767581@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.61.0505041351440.18390@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0505030037100.27756@chimarrao.boston.redhat.com>
 <17015.26421.403622.767581@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2005, Nikita Danilov wrote:

> So file system pages never get to the active list? Hmm... this doesn't
> sound right.

Yes they will, I changed vmscan.c to compensate.

>  > +		if (referenced) {
>  > +			/* New page. Let's see if it'll get used again... */
>  > +			if (TestClearPageNew(page))
>  > +				goto keep_locked;
>  >  			goto activate_locked;
>  > +		}
> 
> This will screw scanning most likely: no referenced page is ever
> reclaimed unless lowest scanning priority is reached---this looks like
> sure way to oom and has capacity to increase CPU consumption
> significantly.

Doubtful, the VM always manages to clear the referenced bits
faster than they can be set, especially on pages that aren't
even mapped!

The problem you describe should be a lot worse for mapped
pages, where we already do not run into the problem, despite
the VM taking no precautions.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
