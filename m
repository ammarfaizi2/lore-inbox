Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263068AbTCLAuD>; Tue, 11 Mar 2003 19:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263069AbTCLAuD>; Tue, 11 Mar 2003 19:50:03 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:6554 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S263068AbTCLAuC>; Tue, 11 Mar 2003 19:50:02 -0500
Date: Wed, 12 Mar 2003 13:50:18 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Free pages leaking in 2.5.64?
In-reply-to: <20030311162552.7f78e764.akpm@digeo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1047430217.2288.7.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1047376995.1692.23.camel@laptop-linux.cunninghams>
 <20030311162552.7f78e764.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Thanks for the reply. I hadn't looked at the hot/cold stuff before. I
sussed it out this morning and added a condition to the test for
refilling the pcp arrays, stopping them from being refilled during a
suspend/resume cycle. Now everything works fine in that area for me.
I'll check that there aren't any other calls to refill the pcp arrays,
so I can be sure it will work with interrupts enabled and whenever smp
support is added to swsusp.

Now I just have to get the image written and read back and switch from
using page flags to dynamically allocated bitmaps, as I said I would.

Thanks again for the reply and regards,

Nigel

On Wed, 2003-03-12 at 13:25, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@clear.net.nz> wrote:
> >
> > Hi all.
> > 
> > I've come across the following problem in 2.5.64. Here's example output.
> > The header is one page - all messages only have a single call to
> > get_zeroed_page between the printings and the same code works as
> 
> nr_free_pages() does not account for the pages in the per-cpu head arrays. 
> 
> You can make the numbers look right via drain_local_pages(), but that is only
> 100% reliable on uniprocessor with interrupts disabled.
> 

