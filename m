Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130909AbRCJD0x>; Fri, 9 Mar 2001 22:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130906AbRCJD0n>; Fri, 9 Mar 2001 22:26:43 -0500
Received: from saloma.stu.rpi.edu ([128.113.199.230]:35085 "EHLO incandescent")
	by vger.kernel.org with ESMTP id <S130904AbRCJD03>;
	Fri, 9 Mar 2001 22:26:29 -0500
Date: Fri, 9 Mar 2001 22:25:29 -0500
From: Andres Salomon <dilinger@mp3revolution.net>
To: "Marco d'Itri" <md@Linux.IT>
Cc: linux-kernel@vger.kernel.org
Subject: Re: peer shrinks window
Message-ID: <20010309222529.A28615@mp3revolution.net>
In-Reply-To: <20010310004556.A7380@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010310004556.A7380@wonderland.linux.it>; from md@Linux.IT on Sat, Mar 10, 2001 at 12:45:56AM +0100
X-Operating-System: Linux incandescent 2.4.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed this as well in my logs.  In linux/include/net/tcp.h,
TCP_DEBUG is turned on; in linux/net/ipv4/tcp_input.c,
tcp_ack_update_window() contains the following:

#ifdef TCP_DEBUG
<snip>
printk(KERN_DEBUG "TCP: peer %u.%u.%u.%u:%u/%u shrinks window %u:%u:%u. Bad, what else can I say?\n",
                               NIPQUAD(sk->daddr), htons(sk->dport), sk->num,
                               tp->snd_una, tp->snd_wnd, tp->snd_nxt);
<snip>
#endif

Is it really necessary for TCP_DEBUG to be turned on by default?

On Sat, Mar 10, 2001 at 12:45:56AM +0100, Marco d'Itri wrote:
> 
> In two days I've got 46 messages like:
> 
> Mar  7 08:00:55 attila kernel: TCP: peer 163.162.41.4:37582/20 shrinks window 752789960:5840:752797200. Bad, what else can I say?
> 
> If needed I can ask about the os running there, I think it's solaris.
> (nmap confirms: Solaris 7)
> 
> Linux attila 2.4.0-test11 #11 Wed Dec 13 12:02:51 CET 2000 ppc unknown
> 
> -- 
> ciao,
> Marco

-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com
