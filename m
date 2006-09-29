Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbWI2Iwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWI2Iwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWI2Iwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:52:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030416AbWI2Iwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:52:36 -0400
Date: Fri, 29 Sep 2006 01:52:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: michael@ellerman.id.au, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
Message-Id: <20060929015223.76d8d85a.akpm@osdl.org>
In-Reply-To: <451CDC31.6060407@goop.org>
References: <20060928225444.439520197@goop.org>
	<20060928225452.229936605@goop.org>
	<1159506427.25820.20.camel@localhost.localdomain>
	<451CDC31.6060407@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 01:41:21 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Michael Ellerman wrote:
> >> +       printk(KERN_EMERG "------------[ cut here ]------------\n");
> >>     
> >
> > I'm not sure I'm big on the cut here marker.
> >   
> 
> x86 has it.  I figured its more important to not change x86 output than 
> powerpc.

We need to clean that output up a bit.  For a while x86 was printing "BUG:"
in front of both warnings and BUGs because Ingo through it made things
clearer - we've lost that.

> >> i386 implements CONFIG_DEBUG_BUGVERBOSE, but x86-64 and powerpc do
> >> not.  This should probably be made more consistent.
> >>     
> >
> > It looks like if you do this you _might_ be able to share struct
> > bug_entry, or at least have consistent members for each arch. Which
> > would eliminate some of the inlines you have for accessing the bug
> > struct.
> >   
> Yeah, its a bit of a toss-up.  powerpc wants to hide the warn flag 
> somewhere, which either means having a different structure, or using the 
> fields differently.  CONFIG_DEBUG_BUGVERBOSE supporters (ie, i386) want 
> to make the structure completely empty in the !DEBUG_BUGVERBOSE case 
> (which doesn't currently happen).
> > It needed a bit of work to get going on powerpc:
> >   
> 
> Thanks.  I'll try to fold all this together into a new patch when things 
> settle down.

Is OK - I'm pretty happy with what I have now.  I'll clump various patches
together and we can take another look at it.  I guess I'll merge the core
and x86, send x86_64 to Andi, let the ppc guys worry about the powerpc
bits.

