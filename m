Return-Path: <linux-kernel-owner+w=401wt.eu-S932332AbXAPFWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbXAPFWn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 00:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbXAPFWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 00:22:43 -0500
Received: from SOUTH-STATION-ANNEX.MIT.EDU ([18.72.1.2]:46387 "EHLO
	south-station-annex.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932332AbXAPFWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 00:22:42 -0500
Subject: Re: allocation failed: out of vmalloc space error treating and
	VIDEO1394 IOC LISTEN CHANNEL ioctl failed problem
From: David Moore <dcm@MIT.EDU>
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@bitplanet.net>
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux1394-devel@lists.sourceforge.net,
       theSeinfeld@users.sourceforge.net, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, libdc1394-devel@lists.sourceforge.net
In-Reply-To: <59ad55d30701151343r6f964475tae799185f05aa579@mail.gmail.com>
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net>
	 <200701100023.39964.theSeinfeld@users.sf.net>
	 <tkrat.c0a43c7c901c438c@s5r6.in-berlin.de>
	 <1168802934.3123.1062.camel@laptopd505.fenrus.org> <45ABC1A2.90109@tmr.com>
	 <1168885223.3122.304.camel@laptopd505.fenrus.org>
	 <1168890881.10136.29.camel@pisces.mit.edu>
	 <59ad55d30701151306q492e07aep9c640afd7b6c442f@mail.gmail.com>
	 <1168896257.3122.577.camel@laptopd505.fenrus.org>
	 <59ad55d30701151343r6f964475tae799185f05aa579@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 16 Jan 2007 00:21:33 -0500
Message-Id: <1168924893.10136.52.camel@pisces.mit.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.599
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 16:43 -0500, Kristian Høgsberg wrote:
> On 1/15/07, Arjan van de Ven <arjan@infradead.org> wrote:
> > again the best way is for you to provide an mmap method... you can then
> > fill in the pages and keep that in some sort of array; this is for
> > example also what the DRI/DRM layer does for textures etc...
> 
> That sounds a lot like what I have now (mmap method, array of pages)
> so I'll just stick with that.

It sounds like the distinction Arjan is getting at is that the buffer
should exist in the process's virtual address space instead of the
kernel's virtual address space so that we have plenty of space available
to us.

Thus, we should use get_user_pages() instead of vmalloc().  I think
get_user_pages() will also automatically pin the memory.  And we'll also
need to call get_user_pages() from a custom mmap() handler so that we
know what process virtual address to assign to the region.

Is that right Arjan?

Thanks,

David

