Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136238AbRD0WHZ>; Fri, 27 Apr 2001 18:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136240AbRD0WHQ>; Fri, 27 Apr 2001 18:07:16 -0400
Received: from ns2.cypress.com ([157.95.67.5]:19590 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S136238AbRD0WHE>;
	Fri, 27 Apr 2001 18:07:04 -0400
Message-ID: <3AE9ED77.1EE28C94@cypress.com>
Date: Fri, 27 Apr 2001 17:06:47 -0500
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <Pine.LNX.4.33.0104271842550.17635-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Fri, 27 Apr 2001, LA Walsh wrote:
> 
> >     An interesting option (though with less-than-stellar performance
> > characteristics) would be a dynamically expanding swapfile.  If you're
> > going to be hit with swap penalties, it may be useful to not have to
> > pre-reserve something you only hit once in a great while.
> 
> This makes amazingly little sense since you'd still need to
> pre-reserve the disk space the swapfile grows into.
> 
> A dynamically growing swap file can only save you if you
> reserve enough free space on your filesystem for the thing
> to grow...

I seams to work for M$, not that they are a good example.

But in /proc/sys/vm or /proc/sys/swapfile having
min_swap, max_swap, min_free_space and the filename to use. This could
then be set by init scripts like sysctl.

It never grows larger than max(swapfile.max_swap, free_space -
min_free_space).
so if you have free space on the filesystem it can be used,
but if you don't have space the current behavior remains.

Sure it would be slow, but that would only be a problem if you
run out of swap space and need to allocate more. Any
time this routine allocates a larger file than syapfile.min_swap
or frees space you send a WARN message.

Now the user will know why the performance dropped
and can either add RAM, or increase swap with by
partition, file, or increase swapfile.min_swap.

Those with enough RAM/swap will never even know it's there.

	-Thomas
