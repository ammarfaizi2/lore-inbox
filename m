Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266834AbSKUQcR>; Thu, 21 Nov 2002 11:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266837AbSKUQcR>; Thu, 21 Nov 2002 11:32:17 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:60678 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266834AbSKUQcQ>; Thu, 21 Nov 2002 11:32:16 -0500
Date: Thu, 21 Nov 2002 17:38:50 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 kconfig doesn't handle "&& m" correctly
In-Reply-To: <20021121132459.GC18869@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0211211655250.2113-100000@serv>
References: <20021121083912.GE11952@fs.tum.de> <Pine.LNX.4.44.0211211350270.2113-100000@serv>
 <20021121132459.GC18869@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Nov 2002, Adrian Bunk wrote:

> > treated like booleans, that means they are visible if the dependencies are 
> > different than 'n'. For this it should be possible to automatically add 
> > '&& MODULES' if the parser sees a 'm'. I'll have to check this out.
> 
> My first thought is that this sounds like a workaround. Is there a good
> reason not to restore the semantics of the old kconfig that interpreted
> dependencies as a restriction of the input range?

It still does mostly, that's one case I missed. The old config had more 
than one semantic regarding visible input range (the shell 'if' semantic 
and the dep_* dependencies, which differed again between the commands), 
kconfig has only one. So it's not matter of restoring semantics, but 
translating them correctly. In general a symbol is now visibile is if the 
dependencies are !='n', "restoring" would mean to change this into ='y' 
only for tristate symbols when MODULES='n', this would be an even larger 
hack. Translating 'm' into 'm && MODULES' is the cleaner solution, as it 
doesn't change the base kconfig logic.

bye, Roman

