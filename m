Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVCLAUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVCLAUh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVCLAUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 19:20:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:36582 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261387AbVCLAUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 19:20:06 -0500
Date: Fri, 11 Mar 2005 16:13:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, kas@fi.muni.cz, paulus@samba.org,
       jt@bougret.hpl.hp.com, javier@tudela.mad.ttd.net,
       acpi-devel@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net,
       roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Re: [ACPI] inappropriate use of in_atomic()
Message-Id: <20050311161335.1e601da1.akpm@osdl.org>
In-Reply-To: <1110543974.5809.98.camel@gaston>
References: <20050310204006.48286d17.akpm@osdl.org>
	<20050311091142.GB22415@fi.muni.cz>
	<20050311014601.166ae43d.akpm@osdl.org>
	<1110543974.5809.98.camel@gaston>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(where'd my cc go?)

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Fri, 2005-03-11 at 01:46 -0800, Andrew Morton wrote:
> > Jan Kasprzak <kas@fi.muni.cz> wrote:
> > >
> > > This may be the cause of 
> > > 
> > >  http://bugme.osdl.org/show_bug.cgi?id=4150
> > 
> > Looks that way, yes.
> 
> Note that it would be interesting to fix that (I mean the reliability of
> is_atomic() or an alternative). I agree it's quite bad to rely on that
> in practice, but there are a few corner cases where it's useful (like
> oops handling in fbdev's etc...)
> 

That would require that we increment current->something on every
spin/read/write_lock and decrement it in unlock, even with !CONFIG_PREEMPT.

iirc, Anton added an option to do that to the ppc64 build, decoupled from
CONFIG_PREEMPT (which ppc64 doesn't support).

But it's an appreciable amount of overhead.
