Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263564AbTCUI7b>; Fri, 21 Mar 2003 03:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263566AbTCUI7b>; Fri, 21 Mar 2003 03:59:31 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:20740 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S263564AbTCUI73>; Fri, 21 Mar 2003 03:59:29 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200303210910.h2L9ABp8002500@green.mif.pg.gda.pl>
Subject: Re: Non-__init functions calling __init functions
To: cfriesen@nortelnetworks.com (Chris Friesen)
Date: Fri, 21 Mar 2003 10:10:11 +0100 (CET)
Cc: ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
       stuartm@connecttech.com (Stuart MacDonald),
       linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <3E79F405.9030705@nortelnetworks.com> from "Chris Friesen" at Mar 20, 2003 12:01:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrzej Krzysztofowicz wrote:
> 
> > Not always possible.
> > 
> > __init A() {
> > ...
> > }
> > 
> > __exit B() {
> > ...
> > }
> > 
> > C() {
> > ...
> > A();
> > ...
> > #ifdef MODULE
> > B();
> > #endif
> > ...
> > }
> > 
> > C cannot be marked __init for #define MODULE case. Even if it is called only
> > by some __init code. I can imagine other similar situations.
> 
> I thought that in the case of modules, __init is a noop?  At least, that's what 
> this page says

Currently - yes.
But I heard about patches that make __init usefull in modular case.
Why break them ?

> http://www.netfilter.org/unreliable-guides/kernel-hacking/routines-init.html
> 
> So if MODULE is defined, it doesn't matter if C is labelled as __init or not, 
> and if it is not defined, it *should* be labelled as __init since it is itself 
> calling __init code.

Safely the following can be added:

+ #ifndef MODULE
+ __init
+ #endif
  C() {

But I heard that our policy is avoiding extra #ifdefs if possible... 

AFAIR, some __init functions were called (in 2.4 scsi code; I didn't check
newer code) indirectly, by pointers to them, from non __init code. It is
more dificult to detect such cases.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
