Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTBQCdz>; Sun, 16 Feb 2003 21:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTBQCdz>; Sun, 16 Feb 2003 21:33:55 -0500
Received: from mailhost1-chcgil.chcgil.ameritech.net ([206.141.192.67]:46035
	"EHLO mailhost.chi1.ameritech.net") by vger.kernel.org with ESMTP
	id <S265424AbTBQCdy>; Sun, 16 Feb 2003 21:33:54 -0500
Date: Sun, 16 Feb 2003 20:46:05 -0600
From: Mark J Roberts <mjr@znex.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Annoying /proc/net/dev rollovers.
Message-ID: <20030217024605.GB246@znex>
References: <20030216221616.GA246@znex> <20030217014111.GA2244@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217014111.GA2244@f00f.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood:
> How often does it happen?

When the windows box behind my NAT is using all of my 640kbit/sec
downstream to download movies, it takes a little over 14 hours to
download four gigabytes and roll over the byte counter. This means
ifconfig is mostly useless for getting an idea of how much I've
downloaded, which is something very useful to me.

> > total_rx_bytes += rx_bytes;
> 
> if lval is 64-bit, then this cannot be done reliably on all
> architectures

I'm not sure why. I realize that x86 can't do atomic 64-bit
operations, but what I propose is to leave the 32-bit rx_bytes code
the way it is, and just have some heuristic for updating the 64-bit
value every so often, which can be done under a lock, so there would
be no opportunity for races to corrupt the counter. (This is also an
optimization since there needn't be any locks in the actual packet
handling code.)

But I admit I'm no expert programmer, and I might be suggesting
nonsense. In any case, the bug is real, the ifconfig output is
misleading, and I think it should be fixed one way or another.
