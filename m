Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUI0L1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUI0L1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 07:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUI0L1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 07:27:32 -0400
Received: from gate.firmix.at ([80.109.18.208]:5523 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S266683AbUI0L1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 07:27:30 -0400
Subject: Re: sprintf -> strcpy (was: Re: gcc-3.4)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jochen Friedrich <jochen@scram.de>,
       "Christian T. Steigies" <cts@debian.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.61.0409271315230.15815@waterleaf.sonytel.be>
References: <20040925145454.GA16191@skeeve> <20040925221427.GA30105@skeeve>
	 <Pine.LNX.4.58.0409262049380.1809@localhost>
	 <Pine.GSO.4.61.0409271315230.15815@waterleaf.sonytel.be>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1096284437.25427.25.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Mon, 27 Sep 2004 13:27:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 13:17 +0200, Geert Uytterhoeven wrote:
> (CC'ing lkml)
> 
> On Sun, 26 Sep 2004, Jochen Friedrich wrote:
> > > Or maybe it is the binutils? After downgrading to 2.14 from a previous
> > > toolchain source, I could build linux-2.6.8 with gcc-3.4.
> > 
> > I'm using binutils 2.15 and gcc 3.4.2 on Alpha to cross compile 2.6. All i
> > noticed is that the compiler optimizes sprintf(x,"%s",y) to strcpy(x,y)
> > which then fails to link or causes unresolved externals because strcpy is
> > an inline function on m68k. The fix is to do the replacement in the
> > source, like here:
> 
> I remember seeing a similar discussion on lkml about some other automatic
> replacements a while ago, but I cannot remember the details...

Do you mean the strncpy() -> strlcpy() conversion which leads to
information leaks from kernel to user-space im several cases (and Alan
cox fixed the wrong replacements in the netword drivers IIRC).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

