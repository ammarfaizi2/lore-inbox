Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132545AbRDATxO>; Sun, 1 Apr 2001 15:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132546AbRDATxD>; Sun, 1 Apr 2001 15:53:03 -0400
Received: from laurin.munich.netsurf.de ([194.64.166.1]:19136 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S132545AbRDATw4>; Sun, 1 Apr 2001 15:52:56 -0400
Date: Sun, 1 Apr 2001 18:41:31 +0200
To: Jerry Hong <jhong001@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how mmap() works?
Message-ID: <20010401184131.A2474@storm.local>
Mail-Followup-To: Jerry Hong <jhong001@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010329221451.27582.qmail@web4303.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010329221451.27582.qmail@web4303.mail.yahoo.com>; from jhong001@yahoo.com on Thu, Mar 29, 2001 at 02:14:51PM -0800
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2001 at 02:14:51PM -0800, Jerry Hong wrote:
> Hi, 
>   mmap() creates a mmaped memory associated with a
> physical file. If a process updates the mmaped memory,
> Linux will updates the file "automatically". If this
> is the case, why do we need msync()?

For the same reason you might need fsync() or fdatasync().  To force
changes to be written now, without having to munmap() the area, so that
you have a gurantee that current data is on disk and will not be lost.

> If this is not
> the case, what is the interval between 2 "WRITE" (IO
> request operation) request to the physical file
> because it really updates the physical file somehow
> even without msync().

Without syncing, Linux writes whenever it thinks it's appropriate, e.g.
when pages have to be freed (I think also when the bdflush writes back
data, i.e. every 30 seconds by default).

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
