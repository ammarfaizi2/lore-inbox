Return-Path: <linux-kernel-owner+w=401wt.eu-S1762998AbWLKTmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762998AbWLKTmJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763027AbWLKTmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:42:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57990 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762998AbWLKTmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:42:07 -0500
Date: Mon, 11 Dec 2006 11:36:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
cc: Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
In-Reply-To: <457DAF99.4050106@shadowen.org>
Message-ID: <Pine.LNX.4.64.0612111134340.12500@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
 <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de>
 <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
 <20061211182908.GC7256@MAIL.13thfloor.at> <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org>
 <457DAF99.4050106@shadowen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Andy Whitcroft wrote:
> 
> I am afraid to report that this second version also fails for me, as you point
> out CIFS can break us if defined.

Olaf, will you admit that the SLES9 code is crap now?

Andy, does just replacing the "__initdata" with "const" fix it for you? 
That should hopefully mean that IN PRACTICE the Linux version string will 
be the first one to be triggered, if only because init/main.c is linked 
reasonably early, and all the other "Linux version" strings will hopefully 
be in the same rodata section.

Sad, sad. We shouldn't need to work around tools that are so _obviously_ 
broken like this.

			Linus
