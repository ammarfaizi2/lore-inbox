Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbSLEX47>; Thu, 5 Dec 2002 18:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267440AbSLEX47>; Thu, 5 Dec 2002 18:56:59 -0500
Received: from are.twiddle.net ([64.81.246.98]:42903 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267435AbSLEX46>;
	Thu, 5 Dec 2002 18:56:58 -0500
Date: Thu, 5 Dec 2002 16:03:53 -0800
From: Richard Henderson <rth@twiddle.net>
To: george anzinger <george@mvista.com>
Cc: jim.houston@ccur.com, Linus Torvalds <torvalds@transmeta.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
Message-ID: <20021205160353.A15447@twiddle.net>
Mail-Followup-To: george anzinger <george@mvista.com>, jim.houston@ccur.com,
	Linus Torvalds <torvalds@transmeta.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
	"David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
	schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
References: <Pine.LNX.4.44.0212042009340.11869-100000@home.transmeta.com> <3DEF20E2.5AEE3E78@mvista.com> <3DEF6FC9.AFF1EB0B@ccur.com> <3DEF8046.8A0C5ED9@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DEF8046.8A0C5ED9@mvista.com>; from george@mvista.com on Thu, Dec 05, 2002 at 08:35:18AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 08:35:18AM -0800, george anzinger wrote:
> +asmlinkage long
> +sys_restart_syscall( void *parm)
> +{
> +	if ( ! current_thread_info()->restart_block.fun){
> +		return current_thread_info()->restart_block.fun(&parm);
> +	}

(1) Address of parameter?
(2) Passing in such parameters unchecked is a security hole.
(3) Much easier to just take all information from restart_block
    instead of pushing it into the fake syscall.
(4) Should probably clear restart_block.fun immediately.


r~
