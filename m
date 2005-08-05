Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbVHENcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVHENcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 09:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbVHENcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 09:32:48 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:20001 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263014AbVHENcr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 09:32:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ayt3w6MW53GG/nmCA3kG8mw32crDVwJuHNMeQi+Qux5wqRzvuIJKvsItAnUiWttUKwdzI5kUvH8x1gaidDiQIME7e1b1JIFQMUDOBD0MT/+skkehGKtQce2q6SwakicSz3MwVkrF+3JIPUowTfbi2W3PUjcc8n4Lod6ZXjELPO4=
Message-ID: <9e47339105080506325d93f431@mail.gmail.com>
Date: Fri, 5 Aug 2005 09:32:45 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020101075339.GA467@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726015401.GA25015@kroah.com>
	 <20050728190352.GA29092@kroah.com>
	 <9e47339105072812575e567531@mail.gmail.com>
	 <200507282310.23152.oliver@neukum.org>
	 <9e47339105072814125d0901d9@mail.gmail.com>
	 <20020101075339.GA467@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/02, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > > > New, simplified version of the sysfs whitespace strip patch...
> > >
> > > Could you tell me why you don't just fail the operation if malformed
> > > input is supplied?
> >
> > Leading/trailing white space should be allowed. For example echo
> > appends '\n' unless you know to use -n. It is easier to fix the kernel
> > than to teach everyone to use -n.
> 
> Please, NO! echo -n is the right thing to do, and users will eventually learn.
> We are not going to add such workarounds all over the kernel...

It is not a work around. These are text attributes meant for human
use.  Humans have a hard time cleaning up things they can't see. And
the failure mode for this is awful, your attribute won't set but
everything on the screen looks fine.

echo is not the only source of problems. I had some trailing
whitespace in a shell script and it took me a couple of hours to
discover why the attribute set was failing. I finally had to add debug
code to the kernel and reboot to located the problem. Normal users are
never going to figure this out.

Binary attributes are for program use, they should not get cleaned up.
If you dont want the whitespace cleaning switch to a binary one.

>                                 Pavel
> --
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
