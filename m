Return-Path: <linux-kernel-owner+w=401wt.eu-S1751332AbXALN25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbXALN25 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 08:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbXALN24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 08:28:56 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:58045 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbXALN24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 08:28:56 -0500
Date: Fri, 12 Jan 2007 18:41:20 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Tilman Schmidt <tilman@imap.cc>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: spurious sparse warnings from linux/aio.h (was: 2.6.20-rc4-mm1)
Message-ID: <20070112131120.GA22364@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20070111222627.66bb75ab.akpm@osdl.org> <45A77726.2030605@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45A77726.2030605@imap.cc>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 12:55:18PM +0100, Tilman Schmidt wrote:
> Andrew Morton schrieb:
> > - Merged the "filesystem AIO patches".
> 
> This construct:
> 
> > --- linux-2.6.20-rc4/include/linux/aio.h        2007-01-06 23:34:08.000000000 -0800
> > +++ devel/include/linux/aio.h   2007-01-11 21:36:16.000000000 -0800
> 
> > @@ -237,7 +243,8 @@ do {                                                                        \
> >         }                                                               \
> >  } while (0)
> > 
> > -#define io_wait_to_kiocb(wait) container_of(wait, struct kiocb, ki_wait)
> > +#define io_wait_to_kiocb(io_wait) container_of(container_of(io_wait,   \
> > +       struct wait_bit_queue, wait), struct kiocb, ki_wait)
> > 
> >  #include <linux/aio_abi.h>
> > 
> 
> causes a sparse warning:
> 
> > include/linux/sched.h:1313:29: warning: symbol '__mptr' shadows an earlier one
> > include/linux/sched.h:1313:29: originally declared here
> 
> for every source file referencing <linux/sched.h>.
> Could that be avoided please?

So ... the nested container_of() is a problem ? I guess changing
io_wait_to_kiocb() to be an inline function instead of a macro could help ?

Regards
Suparna

> 
> Thanks
> Tilman
> 
> -- 
> Tilman Schmidt                    E-Mail: tilman@imap.cc
> Bonn, Germany
> Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
> Ungeöffnet mindestens haltbar bis: (siehe Rückseite)
> 



-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

