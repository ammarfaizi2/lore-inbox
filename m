Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVHMSsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVHMSsh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 14:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVHMSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 14:48:37 -0400
Received: from pop.gmx.net ([213.165.64.20]:2284 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932253AbVHMSsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 14:48:36 -0400
X-Authenticated: #1725425
Date: Sat, 13 Aug 2005 20:47:15 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: rostedt@goodmis.org
Cc: chrisw@osdl.org, jengelh@linux01.gwdg.de, torvalds@osdl.org,
       gdt@linuxppc.org, akpm@osdl.org, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org, robw@optonline.net
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect
 sa_mask
Message-Id: <20050813204715.131ef9b4.Ballarin.Marc@gmx.de>
In-Reply-To: <Pine.LNX.4.58.0508121456570.19908@localhost.localdomain>
References: <1123615983.18332.194.camel@localhost.localdomain>
	<42F906EB.6060106@fujitsu-siemens.com>
	<1123617812.18332.199.camel@localhost.localdomain>
	<1123618745.18332.204.camel@localhost.localdomain>
	<20050809204928.GH7991@shell0.pdx.osdl.net>
	<1123621223.9553.4.camel@localhost.localdomain>
	<1123621637.9553.7.camel@localhost.localdomain>
	<Pine.LNX.4.58.0508091419420.3258@g5.osdl.org>
	<1123643401.9553.32.camel@localhost.localdomain>
	<Pine.LNX.4.61.0508122036500.16845@yvahk01.tjqt.qr>
	<20050812184503.GX7762@shell0.pdx.osdl.net>
	<Pine.LNX.4.58.0508121456570.19908@localhost.localdomain>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005 14:59:49 -0400 (EDT)
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 12 Aug 2005, Chris Wright wrote:
> > * Jan Engelhardt (jengelh@linux01.gwdg.de) wrote:
> > > So, if in doubt what is really meant - check which of the two/three/+
> > > different behaviors the users out there favor most.
> >
> > Rather, check what happens in practice on other implementations.  I don't
> > have Solaris, HP-UX, Irix, AIX, etc. boxen at hand, but some folks must.
> >
> 
> I've supplied this before, but I'll send it again.  Attached is a program
> that should show the behavior of the sigaction.  If someone has one of the
> above mentioned boxes, please run this on the box and send back the
> results.

This is from NetBSD 2.0:

sa_mask blocks other signals
SA_NODEFER does not block other signals
SA_NODEFER does not affect sa_mask
SA_NODEFER and sa_mask does not block sig
!SA_NODEFER blocks sig
SA_NODEFER does not block sig
sa_mask blocks sig


This is from SFU 3.5 on WinXP (*):

sa_mask blocks other signals
SA_NODEFER does not block other signals
SA_NODEFER does not affect sa_mask
SA_NODEFER and sa_mask blocks sig
!SA_NODEFER blocks sig
SA_NODEFER blocks sig
sa_mask blocks sig

(*) original signal.h did not define SA_NODEFER, so take this with a
grain of salt

Marc
