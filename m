Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVAGXVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVAGXVH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVAGXU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:20:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:25306 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbVAGXP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:15:57 -0500
Date: Fri, 7 Jan 2005 15:15:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Diego Calleja <diegocg@gmail.com>
cc: alan@lxorguk.ukuu.org.uk, oleg@tv-sign.ru, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <20050107235327.788ee7a8.diegocg@gmail.com>
Message-ID: <Pine.LNX.4.58.0501071511050.2272@ppc970.osdl.org>
References: <41DE9D10.B33ED5E4@tv-sign.ru> <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
 <1105113998.24187.361.camel@localhost.localdomain>
 <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org>
 <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org>
 <Pine.LNX.4.58.0501071349320.2272@ppc970.osdl.org> <20050107235327.788ee7a8.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jan 2005, Diego Calleja wrote:
> 
> I've tried it in a 2xPIII, 512 MB of ram. I've done kernel compiles...yeah
> yeah I know kernel compiles are not a good benchmark but since linux uses
> -pipe for gcc...I though it may try it to see if it makes a difference
> (suggestions about better methods to test this are accepted :). The results
> could be very well stadistical noise (it looks like it only takes a second less
> on average), but I though it may be interesting.

Hmm.. I'm gratified, but a bit suspicious. I'd not have expected it to be
noticeable on a kernel compile (that's a 1%+ change in total system time,
which considering all the file ops etc that a compile does means that it
would have to have made quite a big difference for the pipe case).

So your data is intriguing, but it looks a bit _too_ good to be true ;)

Random things like page cache placement (and thus cache effects) might 
also account for it. But hey, if true, that's quite an improvement.

(Of course, anything the kernel does tends to be totally drowned out by 
allt eh actual user-level work gcc does, so in the _big_ picture the 1% 
change in system time means almost nothing. So even "good news" doesn't 
actually matter in this case).

		Linus
