Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263023AbREaHxe>; Thu, 31 May 2001 03:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbREaHxY>; Thu, 31 May 2001 03:53:24 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:18719 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S263023AbREaHxN>;
	Thu, 31 May 2001 03:53:13 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Frank Davis <fdavis112@juno.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.5-ac4 es1371.o unresolved symbols 
In-Reply-To: Your message of "Thu, 31 May 2001 08:08:45 +0200."
             <20010531080845.A808@suse.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 May 2001 17:52:39 +1000
Message-ID: <16983.991295559@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2001 08:08:45 +0200, 
Vojtech Pavlik <vojtech@suse.cz> wrote:
>On Thu, May 31, 2001 at 11:29:06AM +1000, Keith Owens wrote:
>> With your patch, if a user selects CONFIG_INPUT_GAMEPORT=m and
>> CONFIG_SOUND_ES1370=y then the built in es1370 driver has unresolved
>> references to gameport_register_port() which is in a module, vmlinux
>> will not link.  That is why I derived CONFIG_INPUT_GAMEPORT based on
>> the config options in two separate directories.
>
>Have you tried the patch? Because the gameport.h define has:
>
>#if defined(CONFIG_INPUT_GAMEPORT) || (defined(CONFIG_INPUT_GAMEPORT_MODULE) && defined(MODULE))
>void gameport_register_port(struct gameport *gameport);
>void gameport_unregister_port(struct gameport *gameport);
>#else
>void __inline__ gameport_register_port(struct gameport *gameport) { return; }
>void __inline__ gameport_unregister_port(struct gameport *gameport) { return; }
>#endif

When the user has gameport hardware compiled it as a module and they
have es1371 bult into the kernel then es1371 silently ignores the
gameport, even if the gameport modules has been loaded.  This violates
the principle of least surprise, a user configuring both gameport and
es1371 expects to use the gameport, kbuild should support that instead
of silently ignoring the combination.

