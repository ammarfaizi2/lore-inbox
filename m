Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263776AbUD0Fb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUD0Fb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUD0Fb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:31:26 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:4104 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263776AbUD0FbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:31:19 -0400
Date: Tue, 27 Apr 2004 07:26:55 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040427052655.GQ596@alpha.home.local>
References: <408DC0E0.7090500@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408DC0E0.7090500@gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 04:09:36AM +0200, Carl-Daniel Hailfinger wrote:
> Hi,
> 
> LinuxAnt offers binary only modules without any sources. To circumvent our
> MODULE_LICENSE checks LinuxAnt has inserted a "\0" into their declaration:
> 
> MODULE_LICENSE("GPL\0for files in the \"GPL\" directory; for others, only
> LICENSE file applies");

Funny, this reminds me of VGA BIOSes which put "IBM Compatible" at the right
location, because lots of programs were looking for "IBM" to check if this
way such a bios. Same check, same workaround :-) I hope they have patented
this trick so that they will be the only ones using it :-)

> The attached patch blacklists all modules having "Linuxant" or "Conexant"
> in their author string. This may seem a bit broad, but AFAIK both
> companies never have released anything under the GPL and have a strong
> history of binary-only modules.

What would be smarter would be to try to understand why they do this. At
the moment, it seems to me that their only problem is to taint the kernel.
Why ? I don't this that any old modutils/module-utils found in any distros
don't load properly such modules. So perhaps they only want not to taint
the kernel because it appears dirty to their customers who will not receive
any more support from LKML. So perhaps what we really need is to add a new
MODULE_SUPPORT field stating where to get support from in case of bugs,
oopses or panics on a tainted kernel. Thus, the module author would be able
to insert something such as "support_XXX@author.com" which will be displayed
on each oops/panic/etc... Even if this is a long list because the customer
uses connexant, nvidia, checkpoint and I don't know what, at least he will
get 3 email addresses for his support. And it might reassure these authors
to know that the customer will ask them before asking us with our automatic
replies "unload your binary modules...".

Anyway it now seems like strings will have to be matched on their lenghts...

Regards,
Willy

