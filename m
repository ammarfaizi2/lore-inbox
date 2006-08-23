Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWHWITh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWHWITh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWHWITf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:19:35 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:64505 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932418AbWHWITM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:19:12 -0400
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: Nicholas Miell <nmiell@comcast.net>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, johnpol@2ka.mipt.ru, sundell.software@gmail.com,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
In-Reply-To: <20060823.003516.30182824.davem@davemloft.net>
References: <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com>
	 <20060823065659.GC24787@2ka.mipt.ru>
	 <20060823000758.5ebed7dd.akpm@osdl.org>
	 <20060823.003516.30182824.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 01:18:50 -0700
Message-Id: <1156321130.2476.275.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 00:35 -0700, David Miller wrote:
> From: Andrew Morton <akpm@osdl.org>
> Date: Wed, 23 Aug 2006 00:07:58 -0700
> 
> > I wonder whether designing-in a millisecond granularity is the right thing
> > to do.  If in a few years the kernel is running tickless with high-res clock
> > interrupt sources, that might look a bit lumpy.
> > 
> > Switching it to a __u64 nanosecond counter would be basically free on
> > 64-bit machines, and not very expensive on 32-bit, no?
> 
> If it ends up in a structure we'll need to use the "aligned_u64" type
> in order to avoid problems with 32-bit x86 binaries running on 64-bit
> kernels.

Perhaps

struct timespec64
{
	uint64_t tv_sec __attribute__((aligned(8)));
	uint32_t tv_nsec;
}

with a snide remark about gcc in the comments?

-- 
Nicholas Miell <nmiell@comcast.net>

