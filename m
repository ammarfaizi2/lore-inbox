Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbSKTA5P>; Tue, 19 Nov 2002 19:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSKTA5P>; Tue, 19 Nov 2002 19:57:15 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:28125 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267027AbSKTA5O>;
	Tue, 19 Nov 2002 19:57:14 -0500
To: Andrew Morton <akpm@digeo.com>
cc: vasya vasyaev <vasya197@yahoo.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Machine's high load when HIGHMEM is enabled 
In-reply-to: Your message of Tue, 19 Nov 2002 01:40:31 PST.
             <3DDA070F.CF2047BF@digeo.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18339.1037754225.1@us.ibm.com>
Date: Tue, 19 Nov 2002 17:03:45 -0800
Message-Id: <E18EJHN-0004lr-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oracle usually likes its SGA locked in memory, so if it is
set to request 800 MG of RAM on a 1 GB machine, I think you
have tuned Oracle to be requesting too much SGA for your
hardware.

gerrit

In message <3DDA070F.CF2047BF@digeo.com>, > : Andrew Morton writes:
> vasya vasyaev wrote:
> > 
> > Hi again,
> > 
> > Let me try to explain what is this all about...
> > 
> > Box has 1 GB of RAM, it's running oracle database.
> > After some disk activity disk cache has 400 Mb, so 600
> > Mb is free
> 
> And the other 400 megabytes will be freed up on demand.
> 
> > Oracle is tuned for using of 800 Mb of RAM for SGA (as
> > shared memory segment), so Oracle needs 800 Mb of RAM
> > to be free before it's start, right ?
> 
> No...  If that were so, you'd never be able to start any
> applications.
> 
> > So when oracle starts it can't allocate this 800 Mb
> > for SGA and fails to start...
> 
> Well, maybe Oracle is failing to start.  But maybe that's
> not for the reasons you are assuming.
> 
> > Where is a problem - in kernel which can't reduce disk
> > cache to allow allocating of shared memory segment or
> > in oracle ?
> 
> If Oracle requests 800 megabytes from the kernel, it will get it.
> It won't be able to mlock it (I'm guessing here).
>  
> > BTW, free doesn't show that shared memory is in use
> > when oracle is started and requested shared memory
> > segment is allocated (and ipcs shows it).
> 
> Yup, the "shared" accounting is always zero.  Maybe we should
> fix that, or remove it.
>  
> > We need to control disk cache to reduce it as much as
> > possible because it's not needed for oracle, much
> > better is to allow oracle to control the RAM
> > for it's use.
> > 
> > As to compare, on solaris we mount ufs with
> > "forcedirectio" mount option, which tells not to use
> > disk cache.
> 
> Please ensure that the failure is not some Oracle-specific setup
> thing, and then provide specific details on the problem which you
> are observing.  The assumptions which you are making may not be
> correct.
> 
> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
