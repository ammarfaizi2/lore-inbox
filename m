Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUBLRCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266529AbUBLRCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:02:41 -0500
Received: from cs24243203-239.austin.rr.com ([24.243.203.239]:27916 "EHLO
	raptor.int.mccr.org") by vger.kernel.org with ESMTP id S266527AbUBLRCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:02:40 -0500
Date: Thu, 12 Feb 2004 11:02:33 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-ID: <339500000.1076605352@[10.1.1.5]>
In-Reply-To: <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
References: <1076384799.893.5.camel@gaston>
 <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
 <20040210173738.GA9894@mail.shareable.org>
 <20040213002358.1dd5c93a.ak@suse.de> <20040212100446.GA2862@elte.hu>
 <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, February 12, 2004 08:36:48 -0800 Linus Torvalds
<torvalds@osdl.org> wrote:

> One option is to mark the brk() VMA's as being grow-up (which they are), 
> and make get_unmapped_area() realize that it should avoid trying to 
> allocate just above grow-up segments or just below grow-down segments. 
> That's still something of a special case, but at least it's not "magic" 
> any more, now it's more of a "makes sense".

So what's a reasonable value for 'not just above' and 'not just below'?  We
could skip the entire hole, which would give us reasonable behavior for the
brk area, but it wouldn't work so well for the area below the stack.  I'm
sure if we define a 'reasonable' value to skip someone somewhere will
collide with it.

Dave McCracken

