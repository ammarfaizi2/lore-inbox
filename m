Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUHRLRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUHRLRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 07:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUHRLRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 07:17:07 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:51671 "EHLO
	texas.encore.com") by vger.kernel.org with ESMTP id S265847AbUHRLQz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 07:16:55 -0400
Message-ID: <41233AA3.47834A14@compro.net>
Date: Wed, 18 Aug 2004 07:16:51 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.26-ert i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Brian McGrew <Brian@doubledimension.com>, linux-kernel@vger.kernel.org
Subject: Re: Help with mapping memory into kernel space?
References: <E6456D527ABC5B4DBD1119A9FB461E3501E00B@constellation.doubledimension.com> <20040818073141.GV11200@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Tue, Aug 17, 2004 at 10:39:38PM -0700, Brian McGrew wrote:
> > The overall problem is that the more system memory we install,
> > the fewer IBB's we can use.  For instance, 256MB lets us use
> > four IBB's; 512MB lets us use three IBB's and so on.  Basicly,
> > the kernel blows up trying to map memory.  Each IBB has two
> > banks of 64MB of RAM on them which we try and memmap to system
> > memory for speed of addressing.  So essentaily, we're sending
> > out four camera systems with only 256MB of memory which is only
> > about one quarter of what we need.
> > I can't think of any better way to explain it other than it's
> > almost like adding system memory subtracts from kernel memory.
> > Does that make any sense?  We've tried building the kernel with
> > the 4GB memory model and the 64GB memory model and had no success.
> 
> You appear to be trying to ioremap() vast areas. ia32 has limited
> address space, so you need to do one of two things:
> (a) subdivide into portions mapped into different address spaces
> (b) map portions on demand
> 
> There is no support for (a) in Linux.
> 

You might try the bigphysarea patch. We have basically the same problem
with hardware not capabile of hardware scatter/gather in DMA mode.
Bigphysarea was our solution. It does not appear to be available for the
2.6 kernel however

Mark
