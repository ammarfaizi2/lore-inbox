Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbUBZBJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbUBZBJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:09:12 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:2456 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262587AbUBZBJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:09:03 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 26 Feb 2004 12:09:01 +1100
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory exceeds 2.5GB (correction)
Message-ID: <20040226010901.GB22527@cse.unsw.EDU.AU>
References: <20040224002237.GE8906@cse.unsw.EDU.AU> <20040224011458.GA18070@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224011458.GA18070@cse.unsw.EDU.AU>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Where we are upto:

The machine below starts producing slab corruption errors when the amount of RAM is
3GB or more.

The hardware has been check and it does not appear to be a hardware error, additional
hardware that was producing different errors was removed and the slab corruption
persisted.

The driver that seems to be triggering the error is the eepro100. And only when receiving
data, transmitting data produces no errors. 
the test was 
 send kern-image A -> B, no errors.
 send kern-image B -> A, errors.

A being the itanium

Using the alternative Intel e100 driver removes the slab corruption errors.

A small modification to 'struct skb_shared_info' that places an int before the 
'atomic_t dataref' field removes the slab corruption errors.


Darren

On Tue, 24 Feb 2004, Darren Williams wrote:

> Hi Darren
> 
> On Tue, 24 Feb 2004, Darren Williams wrote:
> 
> > 
> > On Ia64 Itanium 1 machines with more than 2.5GB of RAM the follwing error is triggered.
> >  
> > slab error in check_poison_obj(): cache `size-16384': object was modified after freeing
> > 
> > The machine that triggered the error above is an
> > 
> > i2000 HP workstation
> > 4gb RAM
> > 1gb SWAP
> > 
> > An identical machine with 3GB ram produces:
>                             ^^^
>  
> > slab error in check_poison_obj(): cache `size-2048': object was modified after freeing
> > 
> > if the amount of RAM is reduced to 2.5GB or less then the errors do not appear.
>                                      ^^^^^ 
> 
> > Kernel logs and configs can be found at:
> > http://quasar.cse.unsw.edu.au/~dsw/public-files/lemon-debug/
> > 
> > 
> > --------------------------------------------------
> > Darren Williams <dsw AT gelato.unsw.edu.au>
> > Gelato@UNSW <www.gelato.unsw.edu.au>
> > --------------------------------------------------
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --------------------------------------------------
> Darren Williams <dsw AT gelato.unsw.edu.au>
> Gelato@UNSW <www.gelato.unsw.edu.au>
> --------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
