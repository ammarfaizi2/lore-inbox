Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWBBQrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWBBQrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWBBQrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:47:45 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:29144 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932158AbWBBQro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:47:44 -0500
Subject: Re: [PATCH] Dynamically allocated pageflags
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200602021431.30194.ak@suse.de>
References: <200602022111.32930.ncunningham@cyclades.com>
	 <200602021431.30194.ak@suse.de>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 08:47:06 -0800
Message-Id: <1138898826.29030.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 14:31 +0100, Andi Kleen wrote:
> On Thursday 02 February 2006 12:11, Nigel Cunningham wrote:
> > This is my latest revision of the dynamically allocated pageflags patch.
> > 
> > The patch is useful for kernel space applications that sometimes need to flag
> > pages for some purpose, but don't otherwise need the retain the state. A prime
> > example is suspend-to-disk, which needs to flag pages as unsaveable, allocated
> > by suspend-to-disk and the like while it is working, but doesn't need to
> > retain any of this state between cycles.
> 
> It looks like total overkill for a simple problem to me. And is there really
> any other user of this other than swsusp?

We'll probably end up needing a similar mechanism for memory hotplug.
What I need is a mechanism that is exceedingly quick during normal
runtime, any maybe marginally slower during a memory remove operation.

We basically put three or so hooks into some crucial parts of the page
allocator to grab out pages which we want to remove so that they never
make it back into the allocator or out to the system.

Those hooks have to be _really_ fast at runtime, obviously.  In my
testing code, I always just added a page flag, but that's only because I
was being lazy when I coded it up.

-- Dave

