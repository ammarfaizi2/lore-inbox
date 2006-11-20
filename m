Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966377AbWKTSdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966377AbWKTSdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966373AbWKTSdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:33:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966377AbWKTSdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:33:14 -0500
Date: Mon, 20 Nov 2006 10:32:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] WorkStruct: Separate delayable and non-delayable
 events.
In-Reply-To: <4561CB33.2060502@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0611201030400.3692@woody.osdl.org>
References: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
 <20061120142716.12685.47219.stgit@warthog.cambridge.redhat.com>
 <4561CB33.2060502@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Nov 2006, Stefan Richter wrote:

> David Howells wrote:
> > Separate delayable work items from non-delayable work items be splitting them
> > into a separate structure (dwork_struct), which incorporates a work_struct and
> > the timer_list removed from work_struct.
> ...
> >  	if (!delay)
> > -		rc = queue_work(ata_wq, &ap->port_task);
> > +		rc = queue_dwork(ata_wq, &ap->port_task);
> >  	else
> >  		rc = queue_delayed_work(ata_wq, &ap->port_task, delay);
> ...
> 
> A consequent (if somewhat silly) name for queue_delayed_work would be
> queue_delayed_dwork, since it requires a struct dwork_struct.

Yes. Please don't use "dwork" as a name AT ALL. Not in "dwork_struct" and 
not in "queue_dwork()".

"dwork" just sounds d[w]orky. More importantly, we don't use short-hand 
that isn't obvious, unless there is some industry-standard and old meaning 
to it that everybody understands. "delayed_work" may be more typing, but 
anybody who needs to type things that fast had better slow down anyway to 
_think_.

No excuses for short and unreadable names.

		Linus
