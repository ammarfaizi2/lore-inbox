Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSIYTun>; Wed, 25 Sep 2002 15:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262090AbSIYTun>; Wed, 25 Sep 2002 15:50:43 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:52362 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262089AbSIYTum>; Wed, 25 Sep 2002 15:50:42 -0400
Date: Wed, 25 Sep 2002 14:55:50 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <Pine.LNX.4.44.0209252154010.18654-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209251452440.28659-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Ingo Molnar wrote:

> hm, then what is the standard way to make a new kernel option default-Y?  
> At least for the development kernel, a default-enabled kksymoops sounds
> like the right way to go.

There isn't really any. You can do 

	define_bool CONFIG_KALLSYMS y

for two releases and hope to propagate it into people's .config before 
making it an actual choice in config.in.

Or you can hack something up like

if [ "$CONFIG_KALLSYMS" = "" ]; then
	define_bool CONFIG_KALLSYMS y
fi
bool 'kallsyms' CONFIG_KALLSYMS

which gives the desired effect in make oldconfig, but may magically break 
make xconfig or so.

So no, just hope for people to read the help text and enable it.

--Kai


