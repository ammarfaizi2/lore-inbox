Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWIOS16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWIOS16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWIOS16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:27:58 -0400
Received: from gw.goop.org ([64.81.55.164]:64674 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932154AbWIOS15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:27:57 -0400
Message-ID: <450AF0A1.60803@goop.org>
Date: Fri, 15 Sep 2006 11:27:45 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: acahalan@gmail.com, ak@suse.de, arjan@infradead.org, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org,
       zach@vmware.com
Subject: Re: Assignment of GDT entries
References: <200609150755.k8F7tKUD005518@alkaid.it.uu.se>	<450A6238.9050404@goop.org> <17674.27416.420259.744117@alkaid.it.uu.se>
In-Reply-To: <17674.27416.420259.744117@alkaid.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
>  >  Changing the API 
>  > to use abstract "TLS indicies" would also require a call to return the 
>  > "TLS base", which hardly seems like an improvement.
>
> The TLS base can obviously be zero.
>
> User-space asks to access TLS #n (for allocs #n can be -1).
> The kernel maps that to GDT index #m.
> The kernel stores #m in the user-space buffer.
> User-space maps #m to a selector.
>   

I'm missing why this is a substantial improvement over the current 
interface (or functionally different at all).  What does this proposal 
let you do that the current one doesn't?

> Look, I'm not saying the current API is perfect, far from it. But it does
> have valid usage modes which are broken in x86-64's ia32 emulation, and
> will break on i386 of you reallocate the TLS GDT indices. This is a fact.
>   

Hm, well its a "fact" in that they use different segment descriptors, 
but you'd be hard pressed to say that was a breakage.  set_thread_area 
was added in 2.5.29 (Jul 2002), and x86-64 added support in 2.5.43 (Oct 
2002), so the current behaviour is pretty much as it has always been.  
If you have a program that expects something different, you either wrote 
it in Jul-Oct 2002, or you made an unsustainable assumption about how 
set_thread_area() works.

> Look, I'm not saying the current API is perfect, far from it. But it does
> have valid usage modes which are broken in x86-64's ia32 emulation, and
> will break on i386 of you reallocate the TLS GDT indices. This is a fact.
>   

You seem to have a specific use-case in mind; do you have a program 
which would like to use a new interface?  Would you mind spelling it 
out, and describe why the current interface doesn't work for you?

    J
