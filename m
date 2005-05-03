Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVECPSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVECPSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVECPQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:16:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39298 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261712AbVECPQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:16:04 -0400
Date: Tue, 3 May 2005 11:15:54 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Christopher Warner <chris@servertogo.com>,
       Hugh Dickins <hugh@veritas.com>, cwarner@kernelcode.com,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050503151554.GG18109@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Chris Wright <chrisw@osdl.org>,
	Christopher Warner <chris@servertogo.com>,
	Hugh Dickins <hugh@veritas.com>, cwarner@kernelcode.com,
	"Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
	Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com> <20050419133509.GF7715@wotan.suse.de> <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com> <1114773179.9543.14.camel@jasmine> <20050429173216.GB1832@redhat.com> <20050502170042.GJ7342@wotan.suse.de> <1115047729.19314.1.camel@jasmine> <20050502203359.GR23013@shell0.pdx.osdl.net> <20050502210839.GB2230@redhat.com> <20050503142858.GZ7342@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503142858.GZ7342@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 04:28:58PM +0200, Andi Kleen wrote:
 > On Mon, May 02, 2005 at 05:08:39PM -0400, Dave Jones wrote:
 > > On Mon, May 02, 2005 at 01:33:59PM -0700, Chris Wright wrote:
 > >  > * Christopher Warner (chris@servertogo.com) wrote:
 > >  > > Actually I am testing your patches. Its just going to take some time.
 > >  > > The problem occurs under severe load and I'm in the process of doing
 > >  > > load testing this for an inhouse app this week. Soon as i'm able to send
 > >  > > debug information I will.
 > >  > 
 > >  > Same here.  I've just never found a way to trigger other than wait.
 > > 
 > > *nod*, the current test-kernel update for Fedora also has your
 > > debugging patches, but none of the users have hit them (or reported
 > > them) yet.
 > 
 > The second version with the WARN_ON? If not please update to that one.

I lost track.. Here's what I included..

--- linux-2.6.11/mm/memory.c~	2005-04-27 13:37:20.000000000 -0400
+++ linux-2.6.11/mm/memory.c	2005-04-27 13:37:45.000000000 -0400
@@ -94,6 +94,7 @@ static inline void clear_pmd_range(struc
 	if (pmd_none(*pmd))
 		return;
 	if (unlikely(pmd_bad(*pmd))) {
+		printk("%s:%d: ", current->comm, current->pid);
 		pmd_ERROR(*pmd);
 		pmd_clear(pmd);
 		return;
@@ -113,6 +114,7 @@ static inline void clear_pud_range(struc
 	unsigned long addr = start, next;
 	pmd_t *pmd, *__pmd;
 
+	WARN_ON(start == end);
 	if (pud_none(*pud))
 		return;
 	if (unlikely(pud_bad(*pud))) {



		Dave
