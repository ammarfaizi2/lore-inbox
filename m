Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSH0PjV>; Tue, 27 Aug 2002 11:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSH0PjV>; Tue, 27 Aug 2002 11:39:21 -0400
Received: from [217.167.51.129] ([217.167.51.129]:11217 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S316535AbSH0PjT>;
	Tue, 27 Aug 2002 11:39:19 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>, <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: readsw/writesw readsl/writesl
Date: Tue, 27 Aug 2002 08:49:59 +0200
Message-Id: <20020827064959.1100@192.168.4.1>
In-Reply-To: <20020827064632.27053@192.168.4.1>
References: <20020827064632.27053@192.168.4.1>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The problem with that approach is that the "s" versions must also take
>care of byte swapping (or rather _not_ byteswapping while the non-"s"
>do the byteswapping).
>
>So we would need to have raw_{in,out}{b,w,l}. Currently, it's not
>possible to implement {in,out}s{b,w,l} in an efficient way because of
>that.
>
>Then we would also need to expose the io_barrier for CPUs like PPC
>
>etc...
>
>I tend to think that makes us expose too much CPU-specific things, which
>is why I'd rather have the {read,write}s{b,w,l} versions provided by the
>arch so those can be done "the right way" in the arch code, and drivers
>not care about some of the gory details.

Ok, thinking more about it, I think finally that you are right. Since
we also have the "_p" crap entering the dance, that would really make
to much functions to abstract. However, if we decide to go the way
you describe, the we should probably also provide the raw_{in,out}*
ones.

Ben.


