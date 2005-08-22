Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVHVT4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVHVT4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVHVT4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:56:33 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:18906 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750783AbVHVT4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:56:21 -0400
Date: Mon, 22 Aug 2005 20:13:05 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.13-rc6-mm1
Message-ID: <20050822181304.GA24076@ens-lyon.fr>
References: <20050821222229.GC6935@ens-lyon.fr> <9e47339105082115347bde79bb@mail.gmail.com> <20050822143713.GA12947@ens-lyon.fr> <9e473391050822094451d11b58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050822094451d11b58@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 12:44:01PM -0400, Jon Smirl wrote:
> On 8/22/05, Benoit Boissinot <benoit.boissinot@ens-lyon.org> wrote:
> > On Sun, Aug 21, 2005 at 06:34:48PM -0400, Jon Smirl wrote:
> > > This should fix it, but I'm not on a machine where I can test it. Can
> > > you give it a try and let me know?
> > >
> > 
> > it works ok.
> > But there is still at least one problem: if ops->store returns an error,
> > then there will be a substraction and the write will loop (i could do it
> > with a store wich returned EINVAL and a 22 length string).
> > 
> > I don't know if you can put a '\0' at buffer->page[count] if
> > count == PAGE_SIZE.
> > 
> > Moreover, i think it is more correct to add only the leading
> > whitespace from the count because if the ops->store doesn't read
> > everything it will do something weird:
> > 
> > For example, if we have ' 123    ' and ops->store read only one char,
> > then the function will return 7 (1 leading + 4 trailing + 1 read).  For
> > the next call the buffer will be filled only by spaces which is
> > incorrect (it should be '23    ').
> 
> The attached version tries to fix these issues. I am still not
> somewhere where I can test, so please check it out.
> 

Yes it works fine, thanks.

Benoit Boissinot

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
