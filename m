Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266720AbUHCUT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266720AbUHCUT7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266770AbUHCUT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:19:59 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:34467 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S266720AbUHCUT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:19:57 -0400
Date: Tue, 3 Aug 2004 23:19:33 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <20040803185026.A10580@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.44.0408032256110.2281-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti5.jyu.fi; Tue, 03 Aug 2004 23:19:36 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, Francois Romieu wrote:

> > The first log file is with both patchs applied and the second one with one 
> > little change to rx8139_rx() to show if it even goes to through 
> > 
> > "        while (netif_running(dev) && received < budget
> >                && (RTL_R8 (ChipCmd) & RxBufEmpty) == 0) {"-section.
> > 
> > This was the change which I made.. so you can see in the second log file 
> > that there won't be any of these messages after the driver has crashed. 
> If you remove the "if (received > 0) {" test in r8139-10.patch and keep
> both patches applied, I assume you are back to a crash within 15min (instead
> of within 2min as suggested by the log), right ?

Hmm,

I removed "if (received > 0) {" and tested it something like 3 hours and 
wasn't able to crash the driver. I will test it for couple more hours 
tomorrow and if I'm not still able the crash it, we may have find some 
sort of a solution.

I'm not sure yet if it's a good one because of that earlier crash I had.
I guess I will also test if

- read the interruption status word that the driver will ack before the
  actual processing is done;

has something to do it.

We'll see.. I'll get back to you tomorrow with more information.

--
Pasi Sjöholm


