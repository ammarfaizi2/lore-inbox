Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271547AbRHPK3k>; Thu, 16 Aug 2001 06:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271549AbRHPK3a>; Thu, 16 Aug 2001 06:29:30 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:5325 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S271547AbRHPK3U>; Thu, 16 Aug 2001 06:29:20 -0400
Date: Thu, 16 Aug 2001 11:29:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), exit(), SIGCHLD)
Message-ID: <20010816112905.A30202@flint.arm.linux.org.uk>
In-Reply-To: <20010813093116Z270036-761+611@vger.kernel.org> <20010814092849.E13892@pc8.lineo.fr> <20010814201825Z270798-760+1687@vger.kernel.org> <3B7A9953.744977A5@mvista.com> <3B7AB93D.F8B5B455@mvista.com> <3B7B1B07.A9FB293B@mvista.com> <20010816121746.A5861@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010816121746.A5861@pc8.lineo.fr>; from christophe.barbe@lineo.fr on Thu, Aug 16, 2001 at 12:17:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 12:17:46PM +0200, christophe barbé wrote:
> > asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec
> > *rmtp)
> > {
> > 	struct timespec t;
> > 	unsigned long expire;
> > +	struct pt_regs * regs = (struct pt_regs *) &rqtp;

Note also that this is bogus as an architecture invariant.

On ARM, we have to pass a pt_regs pointer into any function that requires
it.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

