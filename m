Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132688AbREBLQr>; Wed, 2 May 2001 07:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132707AbREBLQG>; Wed, 2 May 2001 07:16:06 -0400
Received: from enst.enst.fr ([137.194.2.16]:5000 "HELO enst.enst.fr")
	by vger.kernel.org with SMTP id <S132688AbREBLP4>;
	Wed, 2 May 2001 07:15:56 -0400
Date: Wed, 02 May 2001 13:15:05 +0200
From: Fabrice Gautier <gautier@email.enst.fr>
To: Reto Baettig <baettig@scs.ch>
Subject: Re: serial console problems with 2.4.4
Cc: Linux Alpha mailing list <linux-alpha@vger.rutgers.edu>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3AEFD943.8FE23199@scs.ch>
In-Reply-To: <3AEFD943.8FE23199@scs.ch>
Message-Id: <20010502130958.38BB.GAUTIER@email.enst.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 May 2001 11:54:11 +0200
Reto Baettig <baettig@scs.ch> wrote:

> Hi
> 
> I just installed 2.4.4 on our alpha SMP boxes (ES40) and now I have
> problems with the serial console:

I get same kind of problem when upgrading from 2.4.2 to 2.4.3 and using
busybox as init/getty 

The problem was a bug in busybox. The console initialisation code was
not correct.
> 
> sulogin does not accept input from the serial line
> mingetty does not accept input from the serial line
> agetty works fine

So this this probably a sulogin/mingetty problem. They should set the
CREAD flag in your tty c_cflag.

the patch for busybox repalced the line
	tty.c_cflag |= HUPCL|CLOCAL
by
	tty.c_cflag |= CREAD|HUPCL|CLOCAL
	
Hope this help.

-- 
Fabrice Gautier <gautier@email.enstfr>

