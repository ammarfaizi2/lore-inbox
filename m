Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbSKOCfD>; Thu, 14 Nov 2002 21:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbSKOCfD>; Thu, 14 Nov 2002 21:35:03 -0500
Received: from packet.digeo.com ([12.110.80.53]:30956 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265612AbSKOCfD>;
	Thu, 14 Nov 2002 21:35:03 -0500
Message-ID: <3DD45EEB.4E4F170@digeo.com>
Date: Thu, 14 Nov 2002 18:41:47 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Tim Hockin <thockin@sun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
References: <3DD44E39.4703C2DA@digeo.com> from "Andrew Morton" at Nov 14, 2002 05:30:33 PM <200211150233.gAF2XQv15588@www.hockin.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 02:41:51.0454 (UTC) FILETIME=[8D3B47E0:01C28C50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> 
> > 10,000 bits isn't much.  Maybe:
> 
> That's 10000 USED bits.  Remember groups are non-contiguously allocated.  If
> a task is a member of just groups 32767 and 65535, you'll get one bit per
> page used, and when they call getgroups() you need to pull it apart and
> return an array of gid_t.
> 

Well that's what I was asking.

What is the maximum group ID?  0xffffffff?

In that case a radix tree _might_ suit.  All you need to put in the
node is a (void *)1 or (void *)0.  But it won't be very space-efficient
for really sparse groups.
