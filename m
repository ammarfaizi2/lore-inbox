Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135987AbREAH0E>; Tue, 1 May 2001 03:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136583AbREAHZy>; Tue, 1 May 2001 03:25:54 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:44553 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S136582AbREAHZi>; Tue, 1 May 2001 03:25:38 -0400
Date: Tue, 1 May 2001 08:25:36 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Tony Hoyle <tmh@nothing-on.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: just-in-time debugging?
Message-ID: <20010501082536.A30970@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Tony Hoyle <tmh@nothing-on.tv>, linux-kernel@vger.kernel.org
In-Reply-To: <20010428201708.E629E13F6A@mail.cvsnt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010428201708.E629E13F6A@mail.cvsnt.org>; from tmh@nothing-on.tv on Sat, Apr 28, 2001 at 09:17:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My approach is something like the others.  I developed a small wrapper to catch
unaligned traps on alpha.  What it does is run a program in gdb with some
specified arguments (it also sets up so that the process gets a SIGBUS when it
does an unaligned access, but that's probably not relevant here).

Any case, its available by anonymous ftp at ftp://uncarved.com/unaligned.c 
in case you're interested...

Sean

On Sat, Apr 28, 2001 at 09:17:10PM +0100, Tony Hoyle wrote:
> Is there a way (kernel or userspace... doesn't matter) that gdb/ddd
> could be invoked when a program is about
> to dump core, or perhaps on a certain signal (that the app could deliver
> to itself when required).  The latter case
> is what I need right now, as I have to debug an app that breaks
> seemingly randomly & I need to halt when
> certain assertions fail.  Core dumps aren't much use as you can't resume
> them, otherwise I'd just force a segfault
> or something.
> 
> I had a look at the do_coredump stuff and it looks like it could be
> altered to call gdb in the same way that
> modprobe gets called by kmod... however I don't sufficiently know the
> code to work out whether it'd work properly
> or not.  
> 
> A patch to glibc would perhaps be better, but I know that code even
> less!
> 
> Something like responding to SIGTRAP would probably be ideal.
> 
> Tony
> 
> -- 
> 
> "Two weeks before due date, the programmers work 22 hour days cobbling an
>  application from... (apparently) one programmer bashing his face into the
>  keyboard." -- Dilbert
> 
> tmh@magenta-netlogic.com                http://www.nothing-on.tv 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
