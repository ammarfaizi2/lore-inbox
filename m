Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbTEEOKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTEEOKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:10:33 -0400
Received: from ns.suse.de ([213.95.15.193]:30734 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262245AbTEEOKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:10:31 -0400
Date: Mon, 5 May 2003 16:23:00 +0200
From: Karsten Keil <kkeil@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, kai@tp1.ruhr-uni-bochum.de,
       linux-kernel@vger.kernel.org
Subject: Re: ISDN massive packet drops while DVD burn/verify
Message-ID: <20030505142300.GC28010@pingi3.kke.suse.de>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, kai@tp1.ruhr-uni-bochum.de,
	linux-kernel@vger.kernel.org
References: <20030416151221.71d099ba.skraw@ithnet.com> <Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu> <20030419193848.0811bd90.skraw@ithnet.com> <1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk> <20030420181812.44844175.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030420181812.44844175.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.20-4GB i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On Sun, Apr 20, 2003 at 06:18:12PM +0200, Stephan von Krawczynski wrote:
> On 19 Apr 2003 23:01:32 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > On Sad, 2003-04-19 at 18:38, Stephan von Krawczynski wrote:
> > > I don't buy that explanation. Reason is simple: during this all network
> > > connections work flawlessly, and they do have quite a lot of interrupts
> > > compared to ISDN. ISDN is so slow and has so few interrupts that it is
> > > quite unlikely in a SMP-beyond-GHz-limit box that you loose some. The
> > > ancient hardware days are long gone ...
> > 
> > I'd suggest buying his explanation, because he's right. You are
> > confusing quantity and latency.
> 
> Sorry Alan, "been there, done that"
> I made ISDN work on just about anything that you would call an OS on sometimes
> quite ancient hardware (compared to nowadays), and I really cannot imagine that
> the combined (though sometimes confusing) efforts of you, Andre, Pavel, name-one
> on IDE made a dual 1.4 GHz PIII slower (responding) than a M68k 7,14 MHz with a
> polling IDE interface - which happens to be the slowest thing I ever did ISDN
> programming on _flawlessly_.
> 

No Alan and Kai are right.

The problem with the Infineon ISDN chips is that the fifos are small and so IRQ 
latency is relativ critical. 32 or 64 bytes are only 4/8 ms, and if one of these
32 Byte is dropped, the complete frame is lost. Modern ethernet cards allways
have fifos for multiple complete frames, so that such things don't happen here.

You can try to use HFC based ISDN cards (e.g. Conrad: ISDN TA 128K) the
fifos are much bigger (7.5kB) so at least 4 complete 1500 byte frames can be 
handled without segmentation. That increase the IRQ latency a lot (~900 ms).

-- 
Karsten Keil
SuSE Labs
ISDN development
