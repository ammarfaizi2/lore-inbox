Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTEIPFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 11:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTEIPFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 11:05:36 -0400
Received: from ns.suse.de ([213.95.15.193]:8210 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262164AbTEIPFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 11:05:35 -0400
To: Willy Tarreau <willy@w.ods.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
X-Yow: NOW, I'm supposed to SCRAMBLE two, and HOLD th' MAYO!!
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 09 May 2003 17:18:12 +0200
In-Reply-To: <20030509145621.GA17581@alpha.home.local> (Willy Tarreau's
 message of "Fri, 9 May 2003 16:56:21 +0200")
Message-ID: <jeof2ctah7.fsf@sykes.suse.de>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3.50 (gnu/linux)
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030509132757.GA16649@alpha.home.local>
	<20030509154637.5cf14c8d.skraw@ithnet.com>
	<20030509145621.GA17581@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> writes:

|> On Fri, May 09, 2003 at 03:46:37PM +0200, Stephan von Krawczynski wrote:
|> > On Fri, 9 May 2003 15:27:57 +0200
|> > Willy Tarreau <willy@w.ods.org> wrote:
|> > 
|> > > On Fri, May 09, 2003 at 03:02:07PM +0200, Stephan von Krawczynski wrote:
|> > >  
|> > > > I cannot say which version of the driver it was, the only thing I can tell
|> > > > you is that the archive was called aic79xx-linux-2.4-20030410-tar.gz.
|> > > 
|> > > That's really interesting, because I got the bug since around this version
|> > > (20030417 IIRC), and it locked up only on SMP, sometimes during boot, or
|> > > during heavy disk accesses caused by "updatedb" and "make -j dep". It's
|> > > fixed in 20030502 from http://people.freebsd.org/~gibbs/linux/SRC/
|> > 
|> > I tried to merge the latest aic archive into 2.4.21-rc2, besides the "usual"
|> > signed/unsigned warnings I got this one:
|> > 
|> > aic7xxx_osm.c: In function `ahc_linux_map_seg':
|> > aic7xxx_osm.c:770: warning: integer constant is too large for "long" type
|> 
|> Good catch, but in fact, it's more this line which worries me :
|> 
|> 758:                if ((addr ^ (addr + len - 1)) & ~0xFFFFFFFF) {
|> 
|> I don't see how ~0xFFFFFFFF can be non-null on 32 bits archs

It will always be zero even on 64 bit archs, because ~0xFFFFFFFF is of
type unsigned int.  The context doesn't matter.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
