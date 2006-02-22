Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWBVRfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWBVRfb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbWBVRfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:35:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161140AbWBVRfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:35:30 -0500
Date: Wed, 22 Feb 2006 09:31:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Zeuthen <david@fubar.dk>
cc: Kay Sievers <kay.sievers@suse.de>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <Pine.LNX.4.64.0602220848280.30245@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0602220915500.30245@g5.osdl.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> 
 <20060217231444.GM4422@stusta.de>  <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
  <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> 
 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> 
 <20060221225718.GA12480@vrfy.org>  <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
  <20060222152743.GA22281@vrfy.org>  <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org>
 <1140625103.21517.18.camel@daxter.boston.redhat.com>
 <Pine.LNX.4.64.0602220848280.30245@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Feb 2006, Linus Torvalds wrote:
> 
> > For just one example of API breaking see
> > 
> >  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175998
> 
> And yes, some of it may be just HAL being a fragile mess, and some of it 
> may end up being just user-level code that must be made to be more robust 
> ("I see a new type I don't understand" "Ok, assume a lowest common 
> denominator, and stop whining about it"). 

Btw, having looked at that bug report some more, I have to say that this 
particular one seems to be of the "HAL is just being an ass about things" 
variety.

Why the hell anybody would care about what the command transport type is, 
when all that matters is that it's a block device, I don't understand. The 
exact details of what kind of block device it is are totally secondary, 
and shouldn't affect basic desktop behaviour.

The patch (to HAL) that the bugzilla entry points to doesn't seem to make 
anything better either. It just adds _another_ magic case-statement. 
Instead, it should just default to doing something sane.

			Linus
