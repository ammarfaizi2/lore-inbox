Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbUDBKiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUDBKiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:38:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58796 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263582AbUDBKiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:38:07 -0500
Subject: Re: Is there some bug in ext3 in 2.4.25?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Fenert <daniel@fenert.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michelle Konzack <linux4michelle@freenet.de>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040402102008.GA6336@fenert.net>
References: <Pine.LNX.4.44.0403051048160.2678-100000@dmt.cyclades>
	 <1078496713.14033.53.camel@sisko.scot.redhat.com>
	 <20040402102008.GA6336@fenert.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1080902272.2012.4.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Apr 2004 11:37:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-04-02 at 11:20, Daniel Fenert wrote:

> >> This sounds like memory corruption (which could be caused by a misbehaving
> >> driver or by flaky hardware) because transaction->t_ilist is not used at
> >> all by the kernel code. Did this box run stable with other kernels?
> >
> >Sounds like bad memory to me.  The only other report of this I've seen
> >was at
> >
> >https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=115935
> >
> >and that machine didn't pass memtest86.
> 
> It passed memtest86, 6 or 7 hours, any further hints?

Well, 7 hours is often not enough for memtest86, I usually recommend 24
hours if there are signs of bad hardware.  But other than that, I can't
think of anything ext3-related --- ext3 simply doesn't ever set that
flag.  If it's being set, something is stomping on ext3's transaction
struct.  That _could_ be the kernel, but it could be just about anything
touching memory after it's freed; or it could be bad hardware.

What modules are you using?  Is there anything unusual in common between
your machine or its use and that in #115935?  

Rebuilding the kernel to enable slab debugging may well be useful if
there's something stomping on transaction structs.

Cheers,
 Stephen

