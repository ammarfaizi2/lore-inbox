Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbTAXVDS>; Fri, 24 Jan 2003 16:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbTAXVDS>; Fri, 24 Jan 2003 16:03:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:50394 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265643AbTAXVDR>;
	Fri, 24 Jan 2003 16:03:17 -0500
Date: Fri, 24 Jan 2003 13:31:31 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm5
Message-Id: <20030124133131.05a223ff.akpm@digeo.com>
In-Reply-To: <DD755978BA8283409FB0087C39132BD1A07BDE@fmsmsx404.fm.intel.com>
References: <DD755978BA8283409FB0087C39132BD1A07BDE@fmsmsx404.fm.intel.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 21:12:24.0267 (UTC) FILETIME=[4A6629B0:01C2C3ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> wrote:
>
> Andrew Morton wrote:
> 
>   So what anticipatory scheduling does is very simple: if an application
>   has performed a read, do *nothing at all* for a few milliseconds.  Just
>   return to userspace (or to the filesystem) in the expectation that the
>   application or filesystem will quickly submit another read which is
>   closeby.
> 
> Do you need to give a process being woken from the read an extra priority
> boost to make sure that it actually gets run in your "few milliseconds"
> window.  It would be a shame to leave the disk idle for the interval, and
> then discover that the process scheduler had been running other stuff, so
> that the reader didn't get a chance to issue the next read.
> 

Indeed.  I have experimented with giving the to-be-woken task a boost in the
CPU scheduler, and was not able to observe much difference.  At the very
least, one would expect to be able to decrease the anticipation timeout with
that in place.

Maybe it just needs more testing to find the usage patterns which need this
change.

It could be that the woken task is getting sufficient boost from the
effective_prio() logic that no change will be needed.  I don't know yet.

