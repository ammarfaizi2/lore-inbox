Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292593AbSCRU6K>; Mon, 18 Mar 2002 15:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSCRU57>; Mon, 18 Mar 2002 15:57:59 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:54521 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292593AbSCRU5p>;
	Mon, 18 Mar 2002 15:57:45 -0500
Date: Mon, 18 Mar 2002 12:57:43 -0800
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Killing tasklet from interrupt
Message-ID: <20020318125743.A26532@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020318115313.A26490@bougret.hpl.hp.com> <Pine.LNX.3.95.1020318153650.29558B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 03:38:29PM -0500, Richard B. Johnson wrote:
> 
> You have the tasklet kill itself the next time it executes. Set some
> flag so it knows it should give up its timer-slot and expire. The
> interrupt sets the flag. It doesn't do anything else.

	I already have this flag and my code mostly work like this, so
that would be trivial to do.
	I looked at the code, and you are right, killing the tasklet
within itself is by far the safest way to do it. It's a shame that the
code doesn't explitely allow for it (i.e. you will deadlock every time
in tasklet_unlock_wait(t);).

	Thanks, and have fun...

	Jean
