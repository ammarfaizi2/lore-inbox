Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRDHVKH>; Sun, 8 Apr 2001 17:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbRDHVJ5>; Sun, 8 Apr 2001 17:09:57 -0400
Received: from stanis.onastick.net ([207.96.1.49]:24337 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S132606AbRDHVJu>; Sun, 8 Apr 2001 17:09:50 -0400
Date: Sun, 8 Apr 2001 17:09:48 -0400
From: Disconnect <dis@sigkill.net>
To: Steven Walter <srwalter@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: All processes hung under 2.4.3
Message-ID: <20010408170948.A4931@sigkill.net>
In-Reply-To: <20010408144101.A6171@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010408144101.A6171@hapablap.dyn.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Althought I was unable to do any debugging, I found the same thing earlier
today.  Syslog showed everything normal (uptimed reports, MARK, etc) and
ctrl-sysrq worked, but it had frozen hard.  I was using xlock, and it was
stopped in the middle of an opengl saver.  I had suspected it was related
to the nvidia drivers (I just got AGP enabled yesterday) but this looks a
lot like what I was seeing.

(On a side note, does anyone know if the K7 optimizations have been fixed
for those of us using the KK266 mobo?)

On Sun, 08 Apr 2001, Steven Walter did have cause to say:

> Earlier today, I tried to unlock xscreensaver on my desktop.  After
> typing in the password, it said "Checking..." and then hung.  In
> response, I hit Ctrl+Alt+Bksp, which killed X.  However, gdm did not
> restart X.  I tried logging in on the console, but none of them were
> responsive; characters would echo, but nothing else.
> 
> In hopes of finding the problem, I entered kdb, and did a bta.  All
> processes were hung in exactly the same spot, schedule+0x268!  This code
> is as follows:
> 
> 0xc0110d50 <schedule+252>:	jne    0xc0110d7e <schedule+298>
> 0xc0110d52 <schedule+254>:	test   %eax,%eax
> 0xc0110d54 <schedule+256>:	jne    0xc0110d72 <schedule+286>
> 0xc0110d56 <schedule+258>:	mov    0xffffffe4(%ecx),%edx
> 0xc0110d59 <schedule+261>:	test   %edx,%edx
> 0xc0110d5b <schedule+263>:	je     0xc0110d7e <schedule+298>
> 0xc0110d5d <schedule+265>:	mov    0xfffffff0(%ecx),%eax
> 0xc0110d60 <schedule+268>:	cmp    0xfffffff0(%ebp),%eax
> 0xc0110d63 <schedule+271>:	je     0xc0110d69 <schedule+277>
> 0xc0110d65 <schedule+273>:	test   %eax,%eax
> 0xc0110d67 <schedule+275>:	jne    0xc0110d6a <schedule+278>
> 0xc0110d69 <schedule+277>:	inc    %edx
> 0xc0110d6a <schedule+278>:	add    $0x14,%edx
> 0xc0110d6d <schedule+281>:	sub    0x24(%esi),%edx
> 0xc0110d70 <schedule+284>:	jmp    0xc0110d7e <schedule+298>
> 
> Additionally, I did a "ps" in kdb and found dozens of "cron" and "sh"
> started.  I suspect that these processes were somehow related to the
> lockup, as the machine should've been idle for hours, and no cron jobs
> were scheduled for the time.
> 
> The captured "bta" is availible if anyone is interested.  I don't know
> of a way to reproduce this offhand.
> -- 
> -Steven
> Freedom is the freedom to say that two plus two equals four.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---
   _.-=<Disconnect>=-._
|     dis@sigkill.net    | And Remember...
\  shawn@healthcite.com  / He who controls Purple controls the Universe..
 PGP Key given on Request  Or at least the Purple parts!

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
