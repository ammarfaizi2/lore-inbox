Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268000AbUJDTHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbUJDTHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUJDTGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:06:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50636 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267633AbUJDTE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:04:28 -0400
Date: Mon, 4 Oct 2004 14:29:48 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, haveblue@us.ibm.com,
       akpm@osdl.org, linux-mm@kvack.org, piggin@cyberone.com.au,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
Message-ID: <20041004172948.GM16374@logos.cnet>
References: <20041001190430.GA4372@logos.cnet> <1096667823.3684.1299.camel@localhost> <20041001234200.GA4635@logos.cnet> <20041002.183015.41630389.taka@valinux.co.jp> <20041002183349.GA7986@logos.cnet> <20041004040910.DCE4470A2D@sv1.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004040910.DCE4470A2D@sv1.valinux.co.jp>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 01:09:10PM +0900, IWAMOTO Toshihiro wrote:
> At Sat, 2 Oct 2004 15:33:49 -0300,
> Marcelo Tosatti wrote:
> > 
> > On Sat, Oct 02, 2004 at 06:30:15PM +0900, Hirokazu Takahashi wrote:
> > 3) At migrate_page_common you assume additional page references 
> > (page_migratable returning -EAGAIN) means the code should try to writeout 
> > the page.
> > 
> > Is that assumption always valid?
> > 
> > In theory there is no need to writeout pages when migrating them to 
> > other zones - they will be copied and the dirty information retained (either
> > in the PageDirty bit or radix tree tag). 
> 
> It's true only when page->private is NULL.  Otherwise writeback is
> necessary to free buffer_head.

You can move the buffer_head's also cant you? Adjusting bh->b_page etc.

Thats what migrate_page_buffer does, no?

Writting pages which contain buffer_head's on memory migration
is really, very bad. 

Imagine gigabytes of pages with buffer_head's. 

> > I just noticed you do that on further patches (migrate_page_buffer), but AFAICS 
> > the writeout remains. Why arent you using migrate_page_buffer yet?
> > 
> > I think the final aim should be to remove the need for "pageout()" 
> > completly.
> 
> Are you going to implement migrate_page_buffer for every file system?
> I don't think it's worthwhile.
> 
> > Questions: are there any documents on the memory hotplug userspace tools? 
> > Where can I find them?
> > 
> > Are Iwamoto's test programs available?
> 
> I've put them at the following URL, but I doubt they are useful for
> you; there are no documentation for them.
> 
> http://people.valinux.co.jp/~iwamoto/mh/tests/

I'll take a look thanks.
