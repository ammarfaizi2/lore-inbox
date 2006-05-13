Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWEMWda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWEMWda (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWEMWda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 18:33:30 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:50648 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932388AbWEMWda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 18:33:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Date: Sun, 14 May 2006 00:33:14 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
References: <200605021200.37424.rjw@sisk.pl> <200605120949.47046.ncunningham@cyclades.com> <20060512103013.GG28232@elf.ucw.cz>
In-Reply-To: <20060512103013.GG28232@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605140033.14967.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the slow response, I've had a lot of work to do recently.

On Friday 12 May 2006 12:30, Pavel Machek wrote:
> > > Too much uncertainity for 10% speedup, I'm afraid. Yes, it was really
> > > clever to get this fundamental change down to few hundred lines, but
> > > design complexity remains. Could we drop that patch?

I think the main problem with the patch was that the criterion by which
the pages were included in the image without copying appeared to be too simple
and therefore too general.  It well might be correct, but that's yet to be
shown.  OTOH it probably is possible to use a criterion that everybody will
agree with.  For example, we could chose pages that would be reclaimed if
there were memory pressure (the pages with I/O operations pending should
not belong to this class).
 
> > Could you provide justification for your claim that the speedup is
> > only 10%?
> 
> 10% was number Rafael provided, IIRC.

That's true, but I only measured the short-time effect of the suspend on the
system responsiveness.

Apart from this without the patch swsusp tends to leave quite o lot
of data in the swap and IMO this effect should not be neglected.  Currently we
only have a very general idea about what these data are and why it happens
actually and there's no warranty it wouldn't hamper performance in the
long run.

> > Please also remember that you are introducing complexity in other ways, with 
> > that swap prefetching code and so on. Any comparison in speed should include 
> > the time to fault back in pages that have been discarded.
> 
> Well, swap prefetching is useful for other workloads, too; so it gets
> developed/tested outside swsusp.

Still my experience indicates that it doesn't play very nice with swsusp and
unfortunately it hogs the I/O.

Greetings,
Rafael
