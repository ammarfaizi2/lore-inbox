Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbTCTQVM>; Thu, 20 Mar 2003 11:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbTCTQVM>; Thu, 20 Mar 2003 11:21:12 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:49417 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261608AbTCTQVK>; Thu, 20 Mar 2003 11:21:10 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200303201632.h2KGW8Vu002620@green.mif.pg.gda.pl>
Subject: Re: Non-__init functions calling __init functions
To: stuartm@connecttech.com (Stuart MacDonald)
Date: Thu, 20 Mar 2003 17:32:08 +0100 (CET)
Cc: ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
       linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <02e201c2eefd$1abe2240$294b82ce@connecttech.com> from "Stuart MacDonald" at Mar 20, 2003 11:23:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Andrzej Krzysztofowicz" <ankry@green.mif.pg.gda.pl>
> > From: "Stuart MacDonald" <stuartm@connecttech.com>
> > > This is always a bug isn't it?
> >
> > ... unless they are guaranteed to be called in the init context only.
> 
> In which case those functions should also be marked __init so they can
> be reclaimed, correct? So it's the reciprocal bug.

Not always possible.

__init A() {
...
}

__exit B() {
...
}

C() {
...
A();
...
#ifdef MODULE
B();
#endif
...
}

C cannot be marked __init for #define MODULE case. Even if it is called only
by some __init code. I can imagine other similar situations.

However it is not your case probably.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
