Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVHBPw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVHBPw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVHBPuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:50:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64732 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261588AbVHBPsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:48:43 -0400
Date: Tue, 2 Aug 2005 08:48:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Manuel Lauss <mano@roarinelk.homelinux.net>,
       Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Erik Waling <erikw@acc.umu.se>
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <20050802154022.A15794@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.58.0508020845520.3341@g5.osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org> <42EC9410.8080107@roarinelk.homelinux.net>
 <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org> <Pine.LNX.4.58.0507311125360.29650@g5.osdl.org>
 <1122846072.17880.43.camel@deep-space-9.dsnet> <Pine.LNX.4.58.0507311557020.14342@g5.osdl.org>
 <1122907067.31357.43.camel@localhost.localdomain> <1122976168.4656.3.camel@localhost.localdomain>
 <20050802103226.GA5501@roarinelk.homelinux.net> <20050802154022.A15794@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Aug 2005, Ivan Kokshaysky wrote:
> 
> Does the patch in appended message fix that?

The problem with this is that it only papers over the bug. 

I don't mind trying to allocate at higher addresses per se: we used to
have the starting point be 0x4000 at some point, and that part is fine.  
The problem is that this also screws us if somebody has a PCI bridge with
an IO window that is at a lower address than 0x2000 - now the PCI layer 
will refuse to try to allocate within it, and you'll replace one bug by 
another.

		Linus
