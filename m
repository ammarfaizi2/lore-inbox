Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSGHAbG>; Sun, 7 Jul 2002 20:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSGHAbF>; Sun, 7 Jul 2002 20:31:05 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:19686 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S316681AbSGHAbE>; Sun, 7 Jul 2002 20:31:04 -0400
Date: Mon, 8 Jul 2002 01:31:42 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Oliver Neukum <oliver@neukum.name>
Cc: Werner Almesberger <wa@almesberger.net>, Bill Davidsen <davidsen@tmr.com>,
       Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020708013141.A13387@kushida.apsleyroad.org>
References: <20020702133658.I2295@almesberger.net> <20020704035012.O2295@almesberger.net> <20020707220933.B11999@kushida.apsleyroad.org> <200207072341.22896.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207072341.22896.oliver@neukum.name>; from oliver@neukum.name on Sun, Jul 07, 2002 at 11:41:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> How do you find CPU's that are about to execute module code ?
> 
> IMHO you need to do this freeze trick before you check the module
> usage count.
> 
> [..]
> > Another possibility would be the RCU thing: execute the module's exit
> > function, but keep the module's memory allocated until some safe
> > scheduling point later, when you are sure that no CPU can possibly be
> > running the module.
> 
> But what do you do if that CPU increases the module usage count?

Those are the cases where I said this does not help.
You basically need:

      (a) to catch the exiting case properly
      (b) to catch entry points

Catching the entry points is what the current `try_inc_mod_count' code
does.  I can't think of another way to do that.

-- Jamie
