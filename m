Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbQKIR6T>; Thu, 9 Nov 2000 12:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQKIR6K>; Thu, 9 Nov 2000 12:58:10 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:61196 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129657AbQKIR5x>; Thu, 9 Nov 2000 12:57:53 -0500
Message-ID: <3A0AE653.70D91891@mvista.com>
Date: Thu, 09 Nov 2000 10:00:51 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: david <sector2@ihug.co.nz>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: fpu now a must in kernel
In-Reply-To: <3A09E161.ACB11253@ihug.co.nz> <20001109153648.A21769@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Thu, Nov 09, 2000 at 12:27:29PM +1300, david wrote:
> >
> > 2 . put the save / restore code in my code (NOT! GOOD! i do not wont to
> > do it this way it is not the right way)
> 
> It is the right way because it only penalizes your code, not everybody else.
> 
This is a MAJOR drag on preemptability.  MUCH better to keep it out of
the kernel.  Barring that, since context switch does not (and should
not) save/restore fp state, the using code must be preemption locked. 
Sound folks won't like this.  

Maybe you could explain why you think you need this and the community
here could suggest an alternative way to do the same or better.

By the way, since the kernel is not yet preemptable, you could use empty
macros to lock preemption.  This way, when preemption comes (2.5) your
code will be easily found.

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
