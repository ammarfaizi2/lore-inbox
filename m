Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSFCUSk>; Mon, 3 Jun 2002 16:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSFCUQj>; Mon, 3 Jun 2002 16:16:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16631 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315483AbSFCUQY>; Mon, 3 Jun 2002 16:16:24 -0400
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Mike Kravetz <kravetz@us.ibm.com>, Andi Kleen <ak@muc.de>,
        linux-kernel@vger.kernel.org, icollinson@imerge.co.uk, andrea@suse.de
In-Reply-To: <3CFBCCB1.A8F7D16B@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Jun 2002 13:13:27 -0700
Message-Id: <1023135208.963.365.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 13:08, Andrew Morton wrote:

> keventd is a "process context bottom half handler".  It's designed
> for use by interrupt handlers for handing off awkward, occasional
> things which need process context.  For example, device hotplugging,
> which was the original reason for its introduction.
> 
> So it makes sense to give keventd SCHED_RR policy and maximum
> priority.  Which should fix this problem as well, yes?

Next to ditching keventd, this is probably the best thing we can do.

I wonder how much code _really_ needs it - that is, what really needs to
be running in process-context?  Obviously device hotplug probably does. 
But for things like that, what about spawning (temporarily) a kernel
thread?

	Robert Love

