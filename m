Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285458AbRLNS7X>; Fri, 14 Dec 2001 13:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285459AbRLNS7N>; Fri, 14 Dec 2001 13:59:13 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:19472 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285458AbRLNS7D>; Fri, 14 Dec 2001 13:59:03 -0500
Message-ID: <3C1A4BB4.EA8C4B45@zip.com.au>
Date: Fri, 14 Dec 2001 10:57:56 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Chris Mason <mason@suse.com>, Johan Ekenberg <johan@ekenberg.se>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, jack@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.14 and 2.4.16
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE> <000a01c1829f$75daf7a0$050010ac@FUTURE> <3825380000.1008348567@tiny> <3C1A3652.52B989E4@zip.com.au> <3845670000.1008352380@tiny>,
		<3845670000.1008352380@tiny>; from mason@suse.com on Fri, Dec 14, 2001 at 12:53:00PM -0500 <20011214193217.H2431@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Fri, Dec 14, 2001 at 12:53:00PM -0500, Chris Mason wrote:
> > I'll try this, and also add kinoded so we can avoid using keventd.  I'm wary
> 
> using keventd for that doesn't look too bad to me. Just like we do with
> the dirty inode flushing. keventd doesn't do anything 99.9% of the time,
> so it sounds a bit wasteful to add yet another daemon that will remain
> idle 99% of the time too... :)

Well heck, let's use ksoftirqd then :)

keventd is used for real-time things - deferred interrupt
actions.  It should be SCHED_FIFO.

Actually, kupdated almost does what's needed already.  I
suspect a wakeup_kupdate() would suffice.

-
