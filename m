Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318881AbSHMACt>; Mon, 12 Aug 2002 20:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318882AbSHMACt>; Mon, 12 Aug 2002 20:02:49 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:10373 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S318881AbSHMACt>; Mon, 12 Aug 2002 20:02:49 -0400
Date: Mon, 12 Aug 2002 19:03:00 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Greg Banks <gnb@alphalink.com.au>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
Message-ID: <20020813000300.GE761@cadcamlab.org>
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <Pine.LNX.4.44.0208121959360.8911-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208121959360.8911-100000@serv>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Roman Zippel]
> with the latest modifications this can be written as:
> 
> dep_tristate NEW !OLD
> dep_tristate OLD !NEW
> 
> This still has the back reference and you have to run 'make config'
> twice to change NEW from n to y.

I don't see this as a big problem.  Most people don't use the bare
Configure script anyway, except for 'make oldconfig'.

With the ! patch, Menuconfig does the right thing here.

> It's possible to fix this:
> 
> tristate DRV
> if [ DRV == y ]; then
>   choice OLD NEW
> fi
> if [ DRV == m ]; then
>   dep_tristate NEW DRV
>   dep_tristate OLD DRV
> fi

Simpler and perhaps more intuitive:

tristate DRV
dep_mbool DRV_OLD DRV

dep_mbool COMMON_OPT DRV
dep_mbool OLD_OPT1 DRV_OLD
dep_mbool OLD_OPT2 DRV_OLD
dep_mbool NEW_OPT1 DRV !DRV_OLD
dep_mbool NEW_OPT2 DRV !DRV_OLD

I don't see a real need for a separate symbol announcing DRV_NEW.  Let
the Makefile cope.

Peter
