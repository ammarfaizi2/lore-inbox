Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268913AbRG0SGU>; Fri, 27 Jul 2001 14:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268919AbRG0SGA>; Fri, 27 Jul 2001 14:06:00 -0400
Received: from mail.mesatop.com ([208.164.122.9]:34577 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S268913AbRG0SFw>;
	Fri, 27 Jul 2001 14:05:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Robert Schiele <rschiele@uni-mannheim.de>
Subject: Re: [PATCH] Re: 2.4.8-pre1 build error in drivers/parport/parport_pc.c
Date: Fri, 27 Jul 2001 12:04:37 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <01072619531103.06728@localhost.localdomain> <20010727101241.A15014@schiele.swm.uni-mannheim.de>
In-Reply-To: <20010727101241.A15014@schiele.swm.uni-mannheim.de>
MIME-Version: 1.0
Message-Id: <01072712043700.01181@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001 02:12, Robert Schiele wrote:
> On Thu, Jul 26, 2001 at 07:53:11PM -0600, Steven Cole wrote:
> > I got the following errors building 2.4.8-pre1.
> >
> > parport_pc.c:257: redefinition of `parport_pc_write_data'
> > /usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:45:
> > `parport_pc_write_data' previously defined here parport_pc.c:262:
> > redefinition of `parport_pc_read_data'
> > /usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:53:
> > `parport_pc_read_data' previously defined here ...
> > make[3]: *** [parport_pc.o] Error 1
> > make[3]: Leaving directory `/usr/src/linux-2.4.8-pre1/drivers/parport'
>
> Hmm, these functions are multiply defined, namely in the c source and
> in it's header file. I see no reason why someone should do this. The
> problem was hidden in older kernel releases by the fact that these
> functions were declared "extern __inline__" which is absolutely
> nonsense in my opinion. So the solution should be to just remove these
> inline functions from the c source file, which can be done with the
> following simple and stupid patch.
>
> This should be the correct solution, or did I miss the vital point?
>
> Robert

Your patch works for me.  Thank you.  I can now print from my parallel port
printer using 2.4.8-pre1.  FWIW, here is my gcc version:

[steven@localhost steven]$ gcc -v
Reading specs from /usr/lib/gcc-lib/i586-mandrake-linux/2.96/specs
gcc version 2.96 20000731 (Linux-Mandrake 8.0 2.96-0.47mdk)

Steven
