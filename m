Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292632AbSCDRtw>; Mon, 4 Mar 2002 12:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292609AbSCDRsT>; Mon, 4 Mar 2002 12:48:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1806 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292594AbSCDRrM>; Mon, 4 Mar 2002 12:47:12 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: 4 Mar 2002 09:46:55 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a60buf$lfi$1@cesium.transmeta.com>
In-Reply-To: <E16hjFq-0006OQ-00@the-village.bc.nu> <200203040504.AAA05343@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200203040504.AAA05343@ccure.karaya.com>
By author:    Jeff Dike <jdike@karaya.com>
In newsgroup: linux.dev.kernel
> 
> Even with address overcommit management, I can fault if I touch pages when
> tmpfs is full but the system is not near overcommit.
> 
> > Furthermore unless you are very careful you may
> > fault again on the stack push for the SIGBUS and if that faults -
> > SIGKILL->OOM time
> 
> We are talking about UML kernel stacks.  If they have been allocated the way
> I'm proposing with the UML __alloc_pages touching each page on the way out,
> they are allocated on the host, and therefore can't fault.
> 
> This seems to me to be sufficiently careful.
> 
> One of us is missing something, who is it?
> 

I think it's you -- you seem to suffer from the "my application is the
only one that counts" syndrome.  If you want to pages dirtied, then
dirty them using memset() or similar.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
