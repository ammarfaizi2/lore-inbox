Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318099AbSHPDh1>; Thu, 15 Aug 2002 23:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318109AbSHPDh1>; Thu, 15 Aug 2002 23:37:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36873 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318099AbSHPDh1>; Thu, 15 Aug 2002 23:37:27 -0400
Date: Thu, 15 Aug 2002 20:43:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re:
 async-io API registration for 2.5.29)]
In-Reply-To: <20020815221647.M29874@redhat.com>
Message-ID: <Pine.LNX.4.44.0208152041120.1271-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Benjamin LaHaise wrote:
> I wish life were that simple.  Unfortunately, struct page isn't the only 
> problem with these abominations: the system can run out of kvm for 
> vm_area_struct, task_struct, files...  Personally, I *never* want to see 
> those data structures being kmap()'d as it would hurt kernel code quality 
> whereas a 4G/4G split is well confined, albeit sickening.

A 4G/4G split will perform _so_ badly that it isn't even funny (it's also
technically impossible since you have to have some shared area anyway, but
you can get pretty close to it).

My bet is that we'll never do it due to performance issues. It's just 
simpler to make the high pages end up being some special stuff (ie the old 
"swap victim cache" etc that wouldn't show up to the VM proper).

		Linus

