Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUDIBnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 21:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUDIBnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 21:43:09 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:32459 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S261439AbUDIBnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 21:43:05 -0400
Date: Thu, 8 Apr 2004 18:42:44 -0700
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Anton Blanchard <anton@samba.org>
Cc: Andy Isaacson <adi@hexapodia.org>, Andrew Morton <akpm@osdl.org>,
       bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-ID: <20040409014244.GO20863@ca-server1.us.oracle.com>
References: <20040406220358.GE4828@hexapodia.org> <20040406173326.0fbb9d7a.akpm@osdl.org> <20040407173116.GB2814@hexapodia.org> <20040407111841.78ae0021.akpm@osdl.org> <20040407192432.GD2814@hexapodia.org> <20040407123455.0de9ffa9.akpm@osdl.org> <20040407194727.GE2814@hexapodia.org> <20040409003737.GF18493@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040409003737.GF18493@krispykreme>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

philip copeland did a whole set of patches for coreutils to allow
directio for both read write and mixed sizes even
the rpm is at
http://oss.oracle.com/projects/ocfs/files/source/RHAT/RHAS3/coreutils-4.5.3-33.src.rpm,
I think he took it up with the maintainers but so far had no luck

it makes sense to have this stuff, we use it a lot.

Wim

On Fri, Apr 09, 2004 at 10:37:37AM +1000, Anton Blanchard wrote:
>  
> Hi,
> 
> > OK, I can see that one.  But it seems like a pretty small benefit to me
> > -- CPU utilization is already really low.
> 
> Maybe not to you but it does make a big difference on our 500 disk setup.
> At the moment we use dd to do an initial sniff, then ext3 utils to do
> O_DIRECT reads/writes. With O_DIRECT read/write in dd we could use it
> instead. (We are basically interested in IO performance that a database
> would see).
> 
> > Um, that sounds like a bad idea to me.  It seems to me it's the kernel's
> > responsibility to figure out "hey, looks like a streaming read - let's
> > not blow out the buffer cache trying to hold 20GB on a 512M system."  If
> > you're saying that the kernel guys have given up and the established
> > wisdom is now "you gotta use O_DIRECT if you don't want to throw
> > everything else out due to streaming data", well... I'm disappointed.
> 
> When you start hitting memory bandwidth limits, O_DIRECT will help you.
> Sure it wont be an issue for your dd copy scenario, but I wanted to point
> out there are other valid uses for it.
> 
> Anton
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
