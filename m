Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVBLPVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVBLPVP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 10:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVBLPVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 10:21:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31134 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261160AbVBLPVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 10:21:09 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Andi Kleen <ak@suse.de>,
       "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>,
       Adrian Bunk <bunk@stusta.de>,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
	<20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de>
	<Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro>
	<20050121071144.GB657@wotan.suse.de>
	<20050207035707.C25338@almesberger.net>
	<m1hdkhzxxj.fsf@ebiederm.dsl.xmission.com>
	<20050212115106.A1257@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Feb 2005 08:17:51 -0700
In-Reply-To: <20050212115106.A1257@almesberger.net>
Message-ID: <m1brapzu1s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Eric W. Biederman wrote:
> > Actually this is trivial to do by using a file in initramfs.
> > If we need something in a well defined format anyway.
> 
> Yes, constructing an additional initramfs, or modifying an existing
> one to hold such data is certainly a possibility.
> 
> I think there are mainly three choices:
>  1) the command line
>  2) an initramfs
>  3) some other, yet to be defined data structure
> 
> 1) is relatively easy to do, but leads to more little parsers and
> doesn't scale too well. 2) scales well but has a relatively high
> overhead (constructing/scanning a cpio archive, etc., particularly
> for items needed early in the boot process), and does not work too
> well for discontiguous data structures. 

There is certainly an issue with reading it early.  But constructing
an additional cpio and sticking it into the initrd block is fairly
simple.  For detecting devices especially in the case that takes
a while that isn't something we need to do early
in the boot process.

> 3) is of course what we should try to avoid :-)

Well the data structure is still yet to be defined.  The
question you raised is how to pass it.
 
> So far, I also think that using an initramfs, or at least
> something that looks like one, even if not normally used as such,
> is the thing to try first.

Something like that.    I have yet to see a even a proof of concept
of the idea of passing device information, to clean up probes.
Nor am I quite certain if it is really useful.  But when it
happens I am sure we can cope.

Eric
