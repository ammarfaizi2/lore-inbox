Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVBLOxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVBLOxy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 09:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVBLOxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 09:53:53 -0500
Received: from almesberger.net ([63.105.73.238]:45835 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261410AbVBLOx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 09:53:26 -0500
Date: Sat, 12 Feb 2005 11:51:06 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>,
       "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>,
       Adrian Bunk <bunk@stusta.de>,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
Message-ID: <20050212115106.A1257@almesberger.net>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org> <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de> <Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro> <20050121071144.GB657@wotan.suse.de> <20050207035707.C25338@almesberger.net> <m1hdkhzxxj.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hdkhzxxj.fsf@ebiederm.dsl.xmission.com>; from ebiederm@xmission.com on Sat, Feb 12, 2005 at 06:54:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Actually this is trivial to do by using a file in initramfs.
> If we need something in a well defined format anyway.

Yes, constructing an additional initramfs, or modifying an existing
one to hold such data is certainly a possibility.

I think there are mainly three choices:
 1) the command line
 2) an initramfs
 3) some other, yet to be defined data structure

1) is relatively easy to do, but leads to more little parsers and
doesn't scale too well. 2) scales well but has a relatively high
overhead (constructing/scanning a cpio archive, etc., particularly
for items needed early in the boot process), and does not work too
well for discontiguous data structures. 3) is of course what we
should try to avoid :-)

So far, I also think that using an initramfs, or at least
something that looks like one, even if not normally used as such,
is the thing to try first.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
