Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267131AbUBMRhm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267132AbUBMRhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:37:42 -0500
Received: from ns.suse.de ([195.135.220.2]:61673 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267131AbUBMRhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:37:41 -0500
Date: Sun, 15 Feb 2004 06:25:44 +0100
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: torvalds@osdl.org, mingo@elte.hu, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, drepper@redhat.com
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-Id: <20040215062544.5e554a61.ak@suse.de>
In-Reply-To: <20040213032604.GI25499@mail.shareable.org>
References: <1076384799.893.5.camel@gaston>
	<Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
	<20040210173738.GA9894@mail.shareable.org>
	<20040213002358.1dd5c93a.ak@suse.de>
	<20040212100446.GA2862@elte.hu>
	<Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
	<20040213032604.GI25499@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 03:26:04 +0000
Jamie Lokier <jamie@shareable.org> wrote:

> Linus Torvalds wrote:
> > One option is to mark the brk() VMA's as being grow-up (which they are), 
> > and make get_unmapped_area() realize that it should avoid trying to 
> > allocate just above grow-up segments or just below grow-down segments. 
> > That's still something of a special case, but at least it's not "magic" 
> > any more, now it's more of a "makes sense".
> 
> That reminds me.  What happens when grow-down stack VMAs finally bump
> into another VMA.  Is there an unmapped guard page retained to segfault
> the program, or does the program silently start overwriting the VMA it
> bumped into?

In the standard kernel it silently overwrites, but in 2.4-aa there was a patch forever
that adds a guard page.

-Andi
