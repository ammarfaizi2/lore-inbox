Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759057AbWLDMGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759057AbWLDMGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759031AbWLDMGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:06:53 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:26592 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S936182AbWLDMGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:06:53 -0500
Message-Id: <200612041206.kB4C61ia004849@laptop13.inf.utfsm.cl>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Bela Lubkin <blubkin@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Corey Minyard <minyard@acm.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Joseph Barnett <jbarnett@motorola.com>
Subject: Re: [Openipmi-developer] [PATCH 9/12] IPMI: add pigeonpoint poweroff 
In-Reply-To: Message from Randy Dunlap <randy.dunlap@oracle.com> 
   of "Sun, 03 Dec 2006 20:01:56 -0800." <45739DB4.6000806@oracle.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Mon, 04 Dec 2006 09:06:01 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 04 Dec 2006 09:06:02 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <randy.dunlap@oracle.com> wrote:
> Bela Lubkin wrote:
> > Andrew Morton wrote:
> >
> >>> Sometime, please go through the IPMI code looking for all these
> >>> statically-allocated things which are initialised to 0 or NULL and remove
> >>> all those intialisations?  They're unneeded, they increase the vmlinux
> >>> image size and there are quite a number of them.  Thanks.
> > Randy Dunlop replied:
> >
> >> I was just about to send that patch.  Here it is,
> >> on top of the series-of-12.
> > ...
> >> -static int bt_debug = BT_DEBUG_OFF;
> >> +static int bt_debug;
> > Is it wise to significantly degrade code readability to work around
> > a minor
> > compiler / linker bug?
> 
> Is that the only one that is a problem?
> 
> I don't think it's a problem.  We *know* that static data areas
> are init to 0.  Everything depends on that.  If that didn't work
> it would all break.

Right. And we know NULL == 0.

> I could say that it's a nice coincidence that BT_DEBUG_OFF == 0,
> but I think that it's more than coincidence.

I'd have had to look over the code to find out what it was initialized
to. In cases where it is not an explicit 0/NULL, I'd leave it as is. It
could also break if somebody later on changes the value of BT_DEBUG_OFF
(yes, very unlikely, but...).

Bug your friendly GCC guy to loose static initializations to zero
(shouldn't be /that/ hard to do...) instead of obfuscating kernel's code.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
