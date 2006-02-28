Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751653AbWB1Ayy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWB1Ayy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWB1Ayy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:54:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13999 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751518AbWB1Ayy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:54:54 -0500
Date: Mon, 27 Feb 2006 16:54:36 -0800
From: Richard Henderson <rth@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] i386: make bitops safe
Message-ID: <20060228005436.GA24895@redhat.com>
References: <200602271700_MC3-1-B969-F4A5@compuserve.com> <Pine.LNX.4.64.0602271502410.22647@g5.osdl.org> <200602280047.22909.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602280047.22909.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 12:47:22AM +0100, Andi Kleen wrote:
> I remember asking rth about this at some point and IIRC
> he expressed doubts if it would actually do what expected. Richard?

It's a bit dicey to be sure.  GCC may or may not be able to look
through the size of the array and not kill things beyond it.  If
one could be *sure* of some actual maximum index, this would be
fine, but I don't think you can.

One could reasonably argue that if you used a structure with a
flexible array member, that GCC could not look through that.  But
again I'm not 100% positive this is handled properly.

I think the best argument for simply leaving things with a memory
clobber is that these are atomic operations, and are on occasion
used as locks, or parts of locks.


r~
