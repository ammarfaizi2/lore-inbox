Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318786AbSG0QWA>; Sat, 27 Jul 2002 12:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318788AbSG0QWA>; Sat, 27 Jul 2002 12:22:00 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:8446 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318786AbSG0QV7>; Sat, 27 Jul 2002 12:21:59 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1027712005.14773.12.camel@irongate.swansea.linux.org.uk> 
References: <1027712005.14773.12.camel@irongate.swansea.linux.org.uk>  <3D418DFD.8000007@deming-os.org> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell Lewis <spamhole-2001-07-16@deming-os.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 27 Jul 2002 17:24:58 +0100
Message-ID: <16918.1027787098@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Memory is relatively cheap, and the complexity of such a paging
> kernel is huge (you have to pin down disk driver and I/O paths for
> example). Linux prefers to try to keep simple debuggable approaches to
> things. 

You could do it. Start with kmalloc_pageable (probably actually 
vmalloc_pageable) and introduce new sections for pageable data and text, 
which can be marked just as init sections are currently. Introduce it 
slowly, adding it a little at a time like we did SMP, and like we _should_ 
have done preemption.

It's debatable what kind of benefit it would give you over and above just 
fixing specific cases like page tables, though. Most of the systems where 
I've _really_ cared about RAM to that extent have been systems without any 
local storage which could sanely be used for swap.

--
dwmw2


