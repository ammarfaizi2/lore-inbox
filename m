Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVCLA1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVCLA1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVCLA1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 19:27:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:33764 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261798AbVCLA1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 19:27:34 -0500
Subject: Re: [Linux-fbdev-devel] Re: [ACPI] inappropriate use of in_atomic()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       kas@fi.muni.cz, Paul Mackerras <paulus@samba.org>,
       jt@bougret.hpl.hp.com, javier@tudela.mad.ttd.net,
       acpi-devel@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net,
       roland@topspin.com, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050311161335.1e601da1.akpm@osdl.org>
References: <20050310204006.48286d17.akpm@osdl.org>
	 <20050311091142.GB22415@fi.muni.cz> <20050311014601.166ae43d.akpm@osdl.org>
	 <1110543974.5809.98.camel@gaston>  <20050311161335.1e601da1.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 12 Mar 2005 11:22:54 +1100
Message-Id: <1110586974.5752.141.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 16:13 -0800, Andrew Morton wrote:
> (where'd my cc go?)
> 
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > On Fri, 2005-03-11 at 01:46 -0800, Andrew Morton wrote:
> > > Jan Kasprzak <kas@fi.muni.cz> wrote:
> > > >
> > > > This may be the cause of 
> > > > 
> > > >  http://bugme.osdl.org/show_bug.cgi?id=4150
> > > 
> > > Looks that way, yes.
> > 
> > Note that it would be interesting to fix that (I mean the reliability of
> > is_atomic() or an alternative). I agree it's quite bad to rely on that
> > in practice, but there are a few corner cases where it's useful (like
> > oops handling in fbdev's etc...)
> > 
> 
> That would require that we increment current->something on every
> spin/read/write_lock and decrement it in unlock, even with !CONFIG_PREEMPT.
> 
> iirc, Anton added an option to do that to the ppc64 build, decoupled from
> CONFIG_PREEMPT (which ppc64 doesn't support).

ppc64 _does_ support PREEMPT nowadays :)

> But it's an appreciable amount of overhead.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

