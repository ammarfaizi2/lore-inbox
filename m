Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVD0Rio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVD0Rio (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVD0Rin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:38:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50304 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261841AbVD0RhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:37:24 -0400
Date: Wed, 27 Apr 2005 13:37:04 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Chris Wright <chrisw@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: New debugging patch was Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050427173704.GC19011@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Hugh Dickins <hugh@veritas.com>, Chris Wright <chrisw@osdl.org>,
	"Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
	Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
References: <20050414170117.GD22573@wotan.suse.de> <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com> <20050414181015.GH22573@wotan.suse.de> <20050414181133.GA18221@wotan.suse.de> <20050414182712.GG493@shell0.pdx.osdl.net> <20050415172408.GB8511@wotan.suse.de> <20050415172816.GU493@shell0.pdx.osdl.net> <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com> <20050415180703.GA26289@redhat.com> <20050427142343.GN13305@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427142343.GN13305@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 04:23:44PM +0200, Andi Kleen wrote:
 > 
 > Could someone who reproduces this problem apply the following
 > patch and see if the WARN_ON triggers?
 > 
 > 
 > diff -u linux-2.6.11/mm/memory.c-o linux-2.6.11/mm/memory.c
 > --- linux-2.6.11/mm/memory.c-o	2005-03-02 08:38:08.000000000 +0100
 > +++ linux-2.6.11/mm/memory.c	2005-04-27 15:48:19.777104735 +0200
 > @@ -94,6 +94,7 @@
 >  	if (pmd_none(*pmd))
 >  		return;
 >  	if (unlikely(pmd_bad(*pmd))) {
 > +		printk("%s:%d: ", current->comm, current->pid);
 >  		pmd_ERROR(*pmd);
 >  		pmd_clear(pmd);
 >  		return;
 > @@ -113,6 +114,7 @@
 >  	unsigned long addr = start, next;
 >  	pmd_t *pmd, *__pmd;
 >  
 > +	WARN_ON(start == end);
 >  	if (pud_none(*pud))
 >  		return;
 >  	if (unlikely(pud_bad(*pud))) {

I'm up to my eyeballs in other stuff right now, so probably won't
get a chance to test this personally. I'll add it to the Fedora
testing rpm however, as 1-2 users are also hitting it.

I'll let you know if I hear anything back.

		Dave

