Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288655AbSANCNy>; Sun, 13 Jan 2002 21:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288643AbSANCNk>; Sun, 13 Jan 2002 21:13:40 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:13585 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288639AbSANCNX>; Sun, 13 Jan 2002 21:13:23 -0500
Date: Sun, 13 Jan 2002 21:13:21 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18pre3-ac1
Message-ID: <20020113211321.C32700@redhat.com>
In-Reply-To: <028b01c19c90$87300760$02c8a8c0@kroptech.com> <E16PvI2-0008WI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16PvI2-0008WI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 14, 2002 at 12:47:54AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 12:47:54AM +0000, Alan Cox wrote:
> That is very useful information actually. That does rather imply that some
> of the performance hit came from the block I/O elevator differences in the
> old ac tree (the ones Linus hated ;)). Now the question (and part of the
> reason Linus didnt like them) - is why ?

Iirc, Linus just didn't like the low/high watermarks for starting & stopping 
io.  Personally, I liked it and wanted to use that mechanism for deciding 
when to submit additional blocks from the buffer cache for the device (it 
provides a nice means of encouraging batching).  The problem that started 
this whole mess was a combination of the missing wake_up in the block layer 
that I found, plus the horrendous io latency that we hit with a long io queue 
and no priorities.  The critical pages for swap in and program loading, as 
well as background write outs need to have a priority boost so that 
interactive feel is better.  Of course, with quite a few improvements in 
when we wait on ios going into the vm between 2.4.7 and 2.4.17, we don't 
wait as indiscriminately on io as we did back then.  But write out latency 
can still harm us.

In effect, it is a latency vs thruput tradeoff.

		-ben
