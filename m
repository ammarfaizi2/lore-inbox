Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBNRtp>; Wed, 14 Feb 2001 12:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129075AbRBNRtg>; Wed, 14 Feb 2001 12:49:36 -0500
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:11793 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S129066AbRBNRt0>; Wed, 14 Feb 2001 12:49:26 -0500
Date: Wed, 14 Feb 2001 17:46:56 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: Carlos Carvalho <carlos@fisica.ufpr.br>
Cc: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org,
        axp-hardware@talisman.alphalinux.org
Subject: Re: Alpha: bad unaligned access handling
Message-ID: <20010214174656.H11048@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Carlos Carvalho <carlos@fisica.ufpr.br>, jbglaw@lug-owl.de,
	linux-kernel@vger.kernel.org, axp-hardware@talisman.alphalinux.org
In-Reply-To: <20010214154808.A15974@lug-owl.de> <14986.48181.55212.358637@hoggar.fisica.ufpr.br> <20010214172607.E11048@dev.sportingbet.com> <14986.49817.44381.454285@hoggar.fisica.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14986.49817.44381.454285@hoggar.fisica.ufpr.br>; from carlos@fisica.ufpr.br on Wed, Feb 14, 2001 at 03:38:33PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 03:38:33PM -0200, Carlos Carvalho wrote:
> Sean Hunter (sean@dev.sportingbet.com) wrote on 14 February 2001 17:26:
>  >This is an application problem, not a kernel one.  You need to upgrade your
>  >netkit.
> 
> Yes, I was quite confident of this. However, unaligned traps are a
> frequent problem with alphas. For a looong time we had zsh produce
> lots of it, to the point of making it unusable. Strangely, the problem
> disappeared without changing anything in zsh. It was either a library
> or kernel problem.

Definitely library, I'd think.

> 
>  >P.S. I wrote a small wrapper to aid in the debugging of unaligned
>  >traps, which I'll send to anyone who's interested.
> 
> I'd like it!
> 

OK, my alpha is a sick bunny at the moment, so I'll have to wait until I get
home (so I can see why I can't ssh to it).  What the wrapper does is set some
settings so your program gets sigbus when it generates an unaligned trap, and
then runs your program in gdb so gdb helpfully stops at the line which
generated the trap.  It goes without saying you need to build the program in
question with debugging symbols so that you see the code.

You then need to fix the unaligned access.  This sometimes requires real alpha
guruhood (Which I do not possess, but Richard Henderson or Michal Jagerman do,
if you need advice), but sometimes simply requires adding __attribute__
((__unaligned__)) to a struct member in a c file.

Sean

