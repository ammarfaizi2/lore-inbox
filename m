Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUHRHbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUHRHbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 03:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUHRHbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 03:31:45 -0400
Received: from holomorphy.com ([207.189.100.168]:15797 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261638AbUHRHbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 03:31:43 -0400
Date: Wed, 18 Aug 2004 00:31:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian McGrew <Brian@doubledimension.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help with mapping memory into kernel space?
Message-ID: <20040818073141.GV11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Brian McGrew <Brian@doubledimension.com>,
	linux-kernel@vger.kernel.org
References: <E6456D527ABC5B4DBD1119A9FB461E3501E00B@constellation.doubledimension.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E6456D527ABC5B4DBD1119A9FB461E3501E00B@constellation.doubledimension.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 10:39:38PM -0700, Brian McGrew wrote:
> The overall problem is that the more system memory we install,
> the fewer IBB's we can use.  For instance, 256MB lets us use
> four IBB's; 512MB lets us use three IBB's and so on.  Basicly,
> the kernel blows up trying to map memory.  Each IBB has two
> banks of 64MB of RAM on them which we try and memmap to system
> memory for speed of addressing.  So essentaily, we're sending
> out four camera systems with only 256MB of memory which is only
> about one quarter of what we need.
> I can't think of any better way to explain it other than it's
> almost like adding system memory subtracts from kernel memory.
> Does that make any sense?  We've tried building the kernel with
> the 4GB memory model and the 64GB memory model and had no success.

You appear to be trying to ioremap() vast areas. ia32 has limited
address space, so you need to do one of two things:
(a) subdivide into portions mapped into different address spaces
(b) map portions on demand

There is no support for (a) in Linux.


-- wli
