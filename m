Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbULRRQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbULRRQn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 12:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbULRRQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 12:16:43 -0500
Received: from zeus.kernel.org ([204.152.189.113]:38650 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261157AbULRRQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 12:16:41 -0500
From: Mike Werner <werner@sgi.com>
Reply-To: werner@sgi.com
To: Christoph Hellwig <hch@infradead.org>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: [patch 2.6.10-rc3 1/4] agpgart: allow multiple backends to be initialized
Date: Sat, 18 Dec 2004 09:17:14 -0800
User-Agent: KMail/1.6.2
References: <200412171255.59390.werner@sgi.com> <20041218144813.GA7635@infradead.org>
In-Reply-To: <20041218144813.GA7635@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412180917.14255.werner@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 December 2004 06:48, Christoph Hellwig wrote:
> On Fri, Dec 17, 2004 at 12:55:59PM -0800, Mike Werner wrote:
> > This new version reduces the number of changes required by users of the agpgart
> > such as drm to support the new api for multiple agp bridges. 
> > The first patch doesn't touch any platform specific files and all current platform
> > gart drivers will just work the same as they do now since the global 
> > agp_bridge is still supported as the default bridge.
> 
> The agp_bridge_find function pointer is bogus, that way you can only support
> one backend at a time. 
Obviously you mean one type of backend here.
I have tried to simplify this patch as much as possible so that it only tries to do one thing
and that is just the api change. I think the searching for valid bridges is a separate issue
since none of the currently supported hardware needs it. The only possible platform
that I assumed might is amd64 and Andi Kleen specifically told me it doesn't.

> 
> Most other bits of the patch are fine, but in either case you first need to
> change the agp bridge driver API to take a struct agp_bridge_data in every
> method, else all these changes don't make sense at all.
> 
> 
I don't agree that you *must* pass the agp_bridge_data pointer for every method.
You don't need it for bind/unbind/free if you associate each memory region
allocated using agp_allocate_memory(bridge,...) with a particular bridge 
which is what the patch does. That is, agp_memory knows which bridge it belongs to.
