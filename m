Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135340AbRA0XVq>; Sat, 27 Jan 2001 18:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135355AbRA0XVg>; Sat, 27 Jan 2001 18:21:36 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:13367 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S135340AbRA0XV1>; Sat, 27 Jan 2001 18:21:27 -0500
Message-ID: <3A7357E4.825545E1@linux.com>
Date: Sat, 27 Jan 2001 23:21:08 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: VM breakdown, 2.4.0 family
In-Reply-To: <01012709593200.27226@oscar>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Marcelo's patch.  It isn't applicable because I am purposely not enabling any
swap.  The problem is the system gets down to about 7 megs of buffers free and within
three seconds has become functionally dead.  Zero response on any user input/output
device save the magic key.

The system will then grind the harddrive solid for about 25-30 minutes then
everything will go silent.

The brokenness is that the OOM code never activates.

-d

Ed Tomlinson wrote:

> David Ford Wrote:
>
> >Since the testN series and up through ac12, I experience total loss of
> >control when memory is nearly exhausted.
> >
> >I start with 256M and eat it up with programs until there is only about
> >7 megs left, no swap.  From that point all user processes stall and the
> >disk begins to grind nonstop.  It will continue to grind for about 25-30
> >minutes until it goes completely silent.  No processes get killed, no VM
> >messages are emitted.
> >
> >The only recourse is the magic key.  If I reboot before the disk goes
> >silent I can cleanly kill X with sysrq-E and restart.
> >
> >If I wait until it goes silent, all is lost.  I have to sysrq-SUB.
>
> You might want to try:
>
> http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.1pre10/bg_page_aging.patch
>
> or
>
> ftp://ftp.cam.org/users/tomlins/pte_aging_limit_swaps.diff
>
> The first patch from Marcelo fixes a problem with aging the wrong pages.  The
> second patch is sort of a 'best of Marcelo' patch.  It contains the aging fix
> and adds conditional bg pte aging (if with activate fast than we age
> down...).  It also has code to trottle swapouts when under preasure - it only
> swaps out as much as we need now.
>
> I have fives days of uptime with it here (on test9 and test10).
>
> Feedback Welcome,
>
> Ed Tomlinson <tomlins@cam.org>

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
