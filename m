Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbSKCVSJ>; Sun, 3 Nov 2002 16:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262479AbSKCVSI>; Sun, 3 Nov 2002 16:18:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62733 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262448AbSKCVSF>; Sun, 3 Nov 2002 16:18:05 -0500
Date: Sun, 3 Nov 2002 21:24:35 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5: troubles with piping make output
Message-ID: <20021103212435.G5589@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	linux-kernel@vger.kernel.org
References: <200211031122.gA3BMbp27805@Port.imtp.ilyichevsk.odessa.ua> <20021103182805.GA1057@mars.ravnborg.org> <200211031946.gA3JkIp29186@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0211032106010.6949-100000@serv> <20021103202446.F5589@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211032146240.6949-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211032146240.6949-100000@serv>; from zippel@linux-m68k.org on Sun, Nov 03, 2002 at 09:54:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 09:54:05PM +0100, Roman Zippel wrote:
> On Sun, 3 Nov 2002, Russell King wrote:
> > No thanks.  That breaks my build scripts.  I don't want to go logging into
> > multiple machines just to run make oldconfig when the old system worked
> > perfectly well.
> > 
> > "perfectly well" here means that make oldconfig worked over ssh, with the
> > local end logging the stdout to a file as well as the terminal, with stdin
> > from the terminal.  It is quite reasonable to expect the configuration to
> > continue as normal.
> 
> Huh? What do you mean? oldconfig still works as before, above only happens 
> if you touch .config or a Kconfig file, kconfig tries to automatically 
> update .config and will fail if stdio is redirected, but needs user input.
> The problem is not a missing fflush, the question is why kconfig couldn't 
> detect the pipe.

ssh host make -C $tree oldconfig ARCH=arm

that doesn't allocate a terminal.  I want such commands to _prompt_ for
input.  If they die because its not a terminal, I consider that _broken_.
Why?  The command is able to read input from a human, and write its output
to a human via the ssh pipes.

If you insist on breaking this, I'll insist on fixing it.  Its a misfeature
that you refuse to run in this situation.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

