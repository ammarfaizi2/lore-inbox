Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318387AbSGRVju>; Thu, 18 Jul 2002 17:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318388AbSGRVju>; Thu, 18 Jul 2002 17:39:50 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:53004 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318387AbSGRVjt>;
	Thu, 18 Jul 2002 17:39:49 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Matthew Wilcox <willy@debian.org>
Date: Thu, 18 Jul 2002 23:42:18 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.26 broken on headless boxes
CC: jsimmons@transvirtual.com, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <B48C1CD735C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 02 at 22:18, Matthew Wilcox wrote:
> On Thu, Jul 18, 2002 at 11:04:54PM +0200, Petr Vandrovec wrote:
> > You have enabled CONFIG_VT without CONFIG_VGA_CONSOLE and 
> > CONFIG_DUMMY_CONSOLE. It is illegal configuration.
> 
> Huh.  So CONFIG_VT_CONSOLE is not enough any more?  I really do think
> this should be documented in Config.help.

CONFIG_VT_CONSOLE works other way around. If you set CONFIG_VT_CONSOLE,
/dev/console can be displayed on your VTs (on your screen).

CONFIG_VGA_CONSOLE/CONFIG_DUMMY_CONSOLE determines whether your VT can
be created at all - maybe _CONSOLE suffix is misleading - without
having at least one displaying device virtual terminals cannot be build.
I always thought that CONFIG_DUMMY_CONSOLE cannot be unset, but
apparently it can...

And BTW, when such configuration worked for you last time? It does not
look to me like that it should ever work.

> > To fix oopses, either enable 'Framebuffer devices' under 'Console
> > drivers' section (you do not have to enable any fbdev driver, just
> > check this option...), or disable CONFIG_VT. See arch/*/kernel/setup.c
> > for explanation, no code in VT subsystem kernel expects conswitchp == NULL,
> > but couple of architectures leaves sometime conswitchp uninitialized.
> 
> well, this is on x86 ...
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
