Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTEAXty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 19:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbTEAXtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 19:49:53 -0400
Received: from rth.ninka.net ([216.101.162.244]:46553 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262790AbTEAXtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 19:49:51 -0400
Subject: Re: [RFC][PATCH] Faster generic_fls
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b8q8gq$4o3$1@penguin.transmeta.com>
References: <87d6j34jad.fsf@student.uni-tuebingen.de.suse.lists.linux.kernel>
	 <Pine.LNX.4.44.0304301801210.20283-100000@home.transmeta.com.suse.lists.linux.kernel>
	 <p73ade730d1.fsf@oldwotan.suse.de>  <b8q8gq$4o3$1@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051790452.8772.18.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 05:00:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-30 at 21:40, Linus Torvalds wrote:
> And inline asms schedule as well as any built-in, unless they are marked
> volatile (either explicitly or implicitly by not having any outputs).

This actually is false.  GCC does not know what resources the
instruction uses, therefore it cannot perform accurate instruction
scheduling.

Richard and I discussed at some time providing a way for inline
asms to give the instruction attributes.

An easier way is to provide a per-platform way to get at the
"weird" instructions a cpu has.  This is precisely what GCC currently
provides in the form of __builtin_${CPU}_${WEIRD_INSN}(args...) type
interfaces.  These give you what you want (complete control) yet
also let GCC schedule the thing accurately.

I know you think GCC is a pile of dogshit, in many ways I do too, but I
think it's just as important to point out the good parts where they
exist.

-- 
David S. Miller <davem@redhat.com>
