Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129914AbQJ0N3v>; Fri, 27 Oct 2000 09:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129288AbQJ0N3l>; Fri, 27 Oct 2000 09:29:41 -0400
Received: from dyna252.cygnus.co.uk ([194.130.39.252]:31993 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129914AbQJ0N3a>;
	Fri, 27 Oct 2000 09:29:30 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20001027005500.A11447@suse.cz> 
In-Reply-To: <20001027005500.A11447@suse.cz>  <20001019102722.B9057@suse.cz> <200010262221.e9QMLfC32276@devserv.devel.redhat.com> 
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        John Levon <moz@compsoc.man.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        faith@valinux.com, jhartmann@precisioninsight.com
Subject: Re: [PATCH] Make agpsupport work with modversions 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Oct 2000 14:25:48 +0100
Message-ID: <20075.972653148@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vojtech@suse.cz said:
> > But that module then depends on both of the others unless you keep
> > recompiling it

> Not really, see for example ns558.c and adi.c plus their third module
> gameport.c, all in drivers/char/joystick. 

But in the case where there _aren't_ any functions which could usefully be 
shared between the modules, you've got a whole extra gratuitous module 
(What's that, 32KiB on some ARM boxen?) just to hold the registration 
functions, which aren't needed if you just use get_module_symbol().

Provide generic code for registering such stuff and it might be acceptable. 
Otherwise, get_module_symbol is better. There's no fundamental flaw with 
get_module_symbol() - just one or two of the current usages of it.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
