Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284472AbRLXIiY>; Mon, 24 Dec 2001 03:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284477AbRLXIiO>; Mon, 24 Dec 2001 03:38:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46085 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284472AbRLXIh7>; Mon, 24 Dec 2001 03:37:59 -0500
Date: Mon, 24 Dec 2001 08:37:52 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Total system lockup with Alt-SysRQ-L
Message-ID: <20011224083752.A1181@flint.arm.linux.org.uk>
In-Reply-To: <20011223175846.B27993@flint.arm.linux.org.uk> <E16IKwX-0002U3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16IKwX-0002U3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Dec 24, 2001 at 02:34:20AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 02:34:20AM +0000, Alan Cox wrote:
> > When pid1 exits (maybe due to a kill signal), we lockup hard in (iirc)
> > exit_notify.  I don't remember the details I'm afraid.
> 
> pid1 ends up trying to kill pid1 and it goes deeply down the toilet from
> that point onwards. The Unix traditional world reboots when pid 1 dies.

The problem was definitely in the exit_notify code, where it manipulated
the task links indefinitely.  (I think it was cptr never becomes null,
so the loop never terminates).

However, if we're saying that "pid1 must not die" then maybe we should get
rid of the 'killall' sysrq option since it serves no useful purpose, and
add a suitable panic in the do_exit path?

I'll generate a patch for that if there's interest.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

