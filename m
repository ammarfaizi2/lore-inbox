Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbULRNx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbULRNx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 08:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbULRNx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 08:53:28 -0500
Received: from news.suse.de ([195.135.220.2]:63696 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262256AbULRNxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 08:53:21 -0500
Date: Sat, 18 Dec 2004 14:53:20 +0100
From: Andi Kleen <ak@suse.de>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: Andi Kleen <ak@suse.de>, Crazy AMD K7 <snort2004@mail.ru>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: do_IRQ: stack overflow: 872..
Message-ID: <20041218135320.GA10030@wotan.suse.de>
References: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel> <p73zn0ccaee.fsf@verdi.suse.de> <1103368330.3566.15.camel@localhost.localdomain> <20041218111420.GE338@wotan.suse.de> <1103370690.3566.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103370690.3566.33.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 12:51:30PM +0100, Bart De Schuymer wrote:
> > 
> > Just take a look at the backtrace in the original post. It clearly
> > shows a problem. And it points strongly towards br-netfilter.
> 
> I don't doubt you are a much better reader of such backtraces than me.
> However, let's count the number of times a function from
> net/bridge/br_netfilter.c is in the backtrace:
> 1. br_nf*: 6 times
> 2. *sabotage*: 3 times
> Seriously, out of 222 lines, only 9 from bridge-nf.
> The function ip_queue_xmit, OTOH, is 8 times in the trace.

Yep, but ip_queue_xmit doesn't call itself recursively. Someone 
must be doing it. And that's likely the bridge code.

BTW not all of these entries are probably true, there can 
be a lot of false positives.

> Anyway, as I already suspected weeks ago, AMD must be seeing some
> incompatibility between ip_queue (he's using snort) and the bridge-nf
> patch.
> 
> He is using the patch (I gave it to him) below on top of the bridge-nf
> patch. Before using that patch he got a kernel panic occasionally.
> However he seems not to get a message in his syslog.

Ok, since this report seems to be for a totally non standard
severly hacked up kernel I suppose nothing from it can be concluded for
the mainline kernel. Thanks for clearing this up.

Note to the original poster: when you report a bug with a patched
kernel always mention it.

-Andi



