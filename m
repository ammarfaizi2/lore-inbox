Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTHVUO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 16:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTHVUO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 16:14:56 -0400
Received: from amdext2.amd.com ([163.181.251.1]:202 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S263617AbTHVUOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 16:14:53 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C080EF006@txexmtae.amd.com>
From: paul.devriendt@amd.com
To: pavel@suse.cz, davej@redhat.com, linux-kernel@vger.kernel.org, aj@suse.de,
       richard.brunner@amd.com, mark.langsdorf@amd.com
Subject: RE: Cpufreq for opteron
Date: Fri, 22 Aug 2003 15:09:15 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1358A7FA612526-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  > +#ifdef DEBUG
> >  > ... deletia 
> >  > +#endif
> > 
> > There's a *lot* of this in this driver. Does it really need 
> that much
> > debugging info ? Additionally, the combination of dprintk, tprintk,
> > printk (KERN_DEBUG  is really messy, and kind of defeats the point
> > of having these macros. If they're not going to be consistent, don't
> > use them at all.
> 
> Yep, I do not like those ?printk's too. Anyway, I killed most #ifdef
> DEBUG, and converted it to BUG_ON(). That makes driver shorter and
> easier to read. Hopefully not much new hardware will be buggy.

I am not really expecting to see a lot of buggy hardware. Hopefully !

I am, however, expecting to see BIOS problems. This code has been tested
internally on a few machines, and every single one of the had some form
or error in the BIOS. Even the AMD internal only development platforms
had problems Some of this stuff was defined kind of late, and went through
several revisions.

There are many debug prints in the code, plus additional code that is
enabled when DEBUG/TRACE are defined. This is all there, based on the
experience of debugging these early machines in house.

I really need all that debug code there so that as new buggy machines
appear in the field, I can just have people email me the log file, and
that ought to be sufficient for me to figure out what is wrong with the
BIOS - I can then report the problem to the machine vendor, and perhaps
offer a workaround.

Without the debug/trace code there, I have to fall back to "please put
the machine in a box and mail it to me" instead of "email me the log file".

I know the debug code is ugly ... but, I am expecting to need it. In the
next rev of the driver, when hardware is publicly for sale, we have some
degree of stability, etc ... then great. But, for now, releasing a driver
that has only been tested on prototype hardware ... and removing the
debug code. Ouch.

Please leave all the debug/trace code in there. I do not care if you
want to change the method of invoking it. But, I fear it is going to be
needed, however it is invoked.

Paul.

