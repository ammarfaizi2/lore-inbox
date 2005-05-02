Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVEBWAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVEBWAc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 18:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVEBWAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 18:00:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:4837 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261165AbVEBWAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 18:00:23 -0400
Date: Mon, 2 May 2005 15:02:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Matt Mackall <mpm@selenic.com>, Morten Welinder <mwelinder@gmail.com>,
       Sean <seanlkml@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <427650E7.2000802@tmr.com>
Message-ID: <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org>
References: <118833cc05042908181d09bdfd@mail.gmail.com><118833cc05042908181d09bdfd@mail.gmail.com>
 <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 May 2005, Bill Davidsen wrote:
> 
> If there is a functional reason to use git, something Mercurial doesn't 
> do, then developers will and should use git. But the associated hassles 
> with large change size, rather than the absolute size, are worth 
> considering.

Note that we discussed this early on, and the issues with full-file 
handling haven't changed. It does actually have real functional 
advantages:

 - you can share the objects freely between different trees, never 
   worrying about one tree corrupting another trees object by mistake.
 - you can drop old objects.

delta models very fundamentally don't support this. 

For example, a simple tree re-linker will work on any mirror site, and
work reliably, even if I end up uploading new objects with some tool that
doesn't know to break hardlinks etc. That can easily be much more than a
10x win for a git repository site (imagine something like bkbits.net, but
got git).

Whether it is a huge deal or not, I don't know. I do know that the big 
deal to me is just the simplicity of the git object models. It makes me 
trust it, even in the presense of inevitable bugs. It's a very safe model, 
and right now safe is good.

		Linus
