Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135623AbREBQlB>; Wed, 2 May 2001 12:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135645AbREBQkm>; Wed, 2 May 2001 12:40:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61036 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S135639AbREBQjx>; Wed, 2 May 2001 12:39:53 -0400
To: Fabrice Gautier <gautier@email.enst.fr>
Cc: Reto Baettig <baettig@scs.ch>,
        Linux Alpha mailing list <linux-alpha@vger.rutgers.edu>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: serial console problems with 2.4.4
In-Reply-To: <3AEFD943.8FE23199@scs.ch> <20010502130958.38BB.GAUTIER@email.enst.fr>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 May 2001 10:37:21 -0600
In-Reply-To: Fabrice Gautier's message of "Wed, 02 May 2001 13:15:05 +0200"
Message-ID: <m1elu7pv0e.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabrice Gautier <gautier@email.enst.fr> writes:

> On Wed, 02 May 2001 11:54:11 +0200
> Reto Baettig <baettig@scs.ch> wrote:
> 
> > Hi
> > 
> > I just installed 2.4.4 on our alpha SMP boxes (ES40) and now I have
> > problems with the serial console:
> 
> I get same kind of problem when upgrading from 2.4.2 to 2.4.3 and using
> busybox as init/getty 
> 
> The problem was a bug in busybox. The console initialisation code was
> not correct.
> > 
> > sulogin does not accept input from the serial line
> > mingetty does not accept input from the serial line
> > agetty works fine
> 
> So this this probably a sulogin/mingetty problem. They should set the
> CREAD flag in your tty c_cflag.
> 
> the patch for busybox repalced the line
> 	tty.c_cflag |= HUPCL|CLOCAL
> by
> 	tty.c_cflag |= CREAD|HUPCL|CLOCAL
> 	
> Hope this help.

This part is correct.  

However the kernel sets CREAD by default.  
sysvinit (and possibly other inits) clears CREAD.
I wish I knew where the breakage actually occured.

And then sulogin/mingetty need to reenable it.

It's not too big of a deal except the serial code doesn't accept SAK's
when CREAD is clear.

Eric
