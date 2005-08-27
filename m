Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbVH0L0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbVH0L0N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 07:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVH0L0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 07:26:13 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:5552 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030349AbVH0L0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 07:26:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ToQpp7RAFFlSSZZb77EVnVXtL4NHPJi7A/Lxd79KlQMzp7Ps+y21fD4IfosFbhhs8PrVPxPf0ezxamEwq2PDgIuGEfrHCqfeMiXhdG961U0HI9Sd8yqlpeSkG2YPZ4Lny7M7WqNixst8yDKX5sJW9fr2Xjxz9Qw69mavRhmg1vY=
Date: Sat, 27 Aug 2005 15:35:25 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Mitchell Blank Jr <mitch@sfgoth.com>, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@davemloft.net>, rml@novell.com, akpm@osdl.org
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
Message-ID: <20050827113525.GA27575@mipter.zuzino.mipt.ru>
References: <1125094725.18155.120.camel@betsy> <20050827040622.GH91880@gaz.sfgoth.com> <20050827053359.GB15782@mandriva.com> <200508270112.50947.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508270112.50947.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2005 at 01:12:50AM -0500, Dmitry Torokhov wrote:
> On Saturday 27 August 2005 00:34, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Aug 26, 2005 at 09:06:22PM -0700, Mitchell Blank Jr escreveu:
> > > Andi Kleen wrote:
> > > > - it doesn't seem to help that much on modern CPUs with good
> > > > branch prediction and big icaches anyways.
> > > 
> > > Really?  I would think that as pipelines get deeper (although that trend
> > > seems to have stopped, thankfully) and Icache-miss penalties get relatively
> > > larger we'd see unlikely() becoming MORE of a benefit, not less.  Storing
> > > the used part of a "hot" function in 1 Icacheline instead of 4 seems like
> > > an obvious win.
> > > 
> > > Personally I've never found unlikely() to be ugly; if anything I think
> > > it serves as a nice little human-readable comment about whats going on
> > > in the control-flow.  I guess I'm in the minority on that one, though.
> > 
> > Hey, even if unlikely was:
> > 
> > #define unlikely(x) (x)
> > 
> > I'd find it useful :-)
> >
> 
> Aside from annotating performance-critical sections what other purpose
> would it carry? It's not like you should not pay attention to teh code
> in these branches even if the are unlikely to be taken. So if code is
> not in hot path likely/unlikely just litter the code.
> 
> Btw, does it actually generate smaller code for constructs like
> 
> 	if (unlikely(blah))
> 		goto out;

Well, with my usual .config (-O2) and gcc-3.3.5-something it does:

text    data     bss     dec     hex filename
3614     303    1696    5613    15ed drivers/hwmon/hdaps.o
3678     303    1696    5677    162d drivers/hwmon/hdaps.o (unlikely()s removed)

Fortunately, there is -Os:

text    data     bss     dec     hex filename
3163     303    1696    5162    142a drivers/hwmon/hdaps.o
3163     303    1696    5162    142a drivers/hwmon/hdaps.o (unlikely()s removed)

See? The difference is 64 vs 451 bytes.

