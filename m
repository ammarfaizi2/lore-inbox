Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSHATXQ>; Thu, 1 Aug 2002 15:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSHATWQ>; Thu, 1 Aug 2002 15:22:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7429 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316856AbSHATVm>; Thu, 1 Aug 2002 15:21:42 -0400
Date: Thu, 1 Aug 2002 12:25:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@elf.ucw.cz>,
       Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for
 2.5.29)
In-Reply-To: <20020801191823.GA24428@tapu.f00f.org>
Message-ID: <Pine.LNX.4.33.0208011221380.3000-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Aug 2002, Chris Wedgwood wrote:
> 
> How about export the value via a syscall and also export an 'error'
> which for now could just be set to 5% or something conservative and
> refined later if necessary or cleanup on other architectures,

Ugh. That sounds like overdesign, and I hate overdesign.

The error is also rather hard to quantify, and only user land can do that 
sanely anyway in the long run (ie the same reason why we have things like 
/etc/adjtime - good guesses depend on history).

The kernel really shouldn't be involved in something like this. 

I seriously doubt that people really care _that_ much about a precise 
time source for aio timeouts, and we should spend more time on making it 
efficient and easy to use than on worrying about the precision. People who 
do care can fall back to gettimeofday() and try to correct for it that 
way.

		Linus

