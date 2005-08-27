Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbVH0GNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbVH0GNC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 02:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbVH0GNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 02:13:02 -0400
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:6008 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030323AbVH0GNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 02:13:00 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
Date: Sat, 27 Aug 2005 01:12:50 -0500
User-Agent: KMail/1.8.2
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Mitchell Blank Jr <mitch@sfgoth.com>, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@davemloft.net>, rml@novell.com, akpm@osdl.org
References: <1125094725.18155.120.camel@betsy> <20050827040622.GH91880@gaz.sfgoth.com> <20050827053359.GB15782@mandriva.com>
In-Reply-To: <20050827053359.GB15782@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508270112.50947.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 August 2005 00:34, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 26, 2005 at 09:06:22PM -0700, Mitchell Blank Jr escreveu:
> > Andi Kleen wrote:
> > > - it doesn't seem to help that much on modern CPUs with good
> > > branch prediction and big icaches anyways.
> > 
> > Really?  I would think that as pipelines get deeper (although that trend
> > seems to have stopped, thankfully) and Icache-miss penalties get relatively
> > larger we'd see unlikely() becoming MORE of a benefit, not less.  Storing
> > the used part of a "hot" function in 1 Icacheline instead of 4 seems like
> > an obvious win.
> > 
> > Personally I've never found unlikely() to be ugly; if anything I think
> > it serves as a nice little human-readable comment about whats going on
> > in the control-flow.  I guess I'm in the minority on that one, though.
> 
> Hey, even if unlikely was:
> 
> #define unlikely(x) (x)
> 
> I'd find it useful :-)
>

Aside from annotating performance-critical sections what other purpose
would it carry? It's not like you should not pay attention to teh code
in these branches even if the are unlikely to be taken. So if code is
not in hot path likely/unlikely just litter the code.

Btw, does it actually generate smaller code for constructs like

	if (unlikely(blah))
		goto out;

-- 
Dmitry
