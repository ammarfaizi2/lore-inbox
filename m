Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288319AbSACV0q>; Thu, 3 Jan 2002 16:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288308AbSACV0g>; Thu, 3 Jan 2002 16:26:36 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:55785 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S288258AbSACV01>;
	Thu, 3 Jan 2002 16:26:27 -0500
Date: Thu, 3 Jan 2002 16:26:46 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103162646.A14133@nevyn.them.org>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <E16Lvh8-0006E6-00@the-village.bc.nu> <25193.1010018130@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25193.1010018130@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 12:35:30AM +0000, David Woodhouse wrote:
> 
> (cc list trimmed)
> 
> alan@lxorguk.ukuu.org.uk said:
> >  If you want a strcpy that isnt strcpy then change its name or use a
> > different language 8)
> 
> The former is not necessarily sufficient in this case. You've still done the
> broken pointer arithmetic, so even if the function isn't called strcpy() the
> compiler is _still_ entitled to replace it with a call to memcpy() or even
> machine_restart() before sleeping with your mother and starting WW III.

No, that's not true.  We're passing a pointer as an argument.  It is a
valid pointer - dereferencing it may not be valid, but the pointer is
perfectly legal!  There is nothing wrong with this case.  The problem
lies in calling a function whose name is special to GCC and to the C
language, which GCC can then transform.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
