Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbTCSAgx>; Tue, 18 Mar 2003 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262886AbTCSAgw>; Tue, 18 Mar 2003 19:36:52 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:26120 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262885AbTCSAgv>;
	Tue, 18 Mar 2003 19:36:51 -0500
Date: Tue, 18 Mar 2003 16:35:44 -0800
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dev_t [2/3]
Message-ID: <20030319003543.GH10089@kroah.com>
References: <UTC200303190022.h2J0MZu08990.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200303190022.h2J0MZu08990.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 01:22:35AM +0100, Andries.Brouwer@cwi.nl wrote:
>     Ah, I wish we could change that function to be:
>     int register_chrdev_region(major, num_minors, name, fops)
>     if it wasn't for the tty drivers wanting to start their minor at 64.
> 
>     Hm, wait, why can't we just do it that way and not change the tty core
>     to use the register_chrdev_region() call?  It should still all work
>     properly, right?  The tty core would ask for 256 minors, and split them
>     off the same way it currently does.
> 
> # cat /proc/devices | head
> Character devices:
>   1 mem
>   2 pty
>   3 ttyp
>   4 vc/0
>   4 vc/%d
>   4 ttyS%d
>   5 tty
>   5 console
>   5 ptmx
> #

???  That's with 2.5.65 today or your patch?  Hm, ok, I see with your
patch, how it will generate the above result.

But the fact that the tty core today abuses major numbers by overloading
them is no reason to try to fix that broken behavior.

:)

Anyway, it's a minor nit, I just would prefer to have a "num_minors"
request, but am fine with your patch as is for right now.

Nice job.

thanks,

greg k-h
