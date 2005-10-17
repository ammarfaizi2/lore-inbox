Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVJQJlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVJQJlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVJQJll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:41:41 -0400
Received: from web33301.mail.mud.yahoo.com ([68.142.206.116]:4733 "HELO
	web33301.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932232AbVJQJll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:41:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hlNYQJYtURrlLsIgWLHmgCXTghJ2b4cH4VJchYVTgLX5NSlxe5eQukd5MdX+VIOtXG+XTpqNjN+bnaNjaducAsrBZ0rjXVvmeY8Vf4ASlxcgAEjZy05cslOK0x+LtW9KPpxvD4csm7CuatfTn+I42k6T0DBdz1K6TWcICFBIkx0=  ;
Message-ID: <20051017094140.14685.qmail@web33301.mail.mud.yahoo.com>
Date: Mon, 17 Oct 2005 02:41:40 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: A problem about DIRECT IO on ext3
To: Jens Axboe <axboe@suse.de>, Grzegorz Kulewski <kangur@polcom.net>
Cc: Erik Mouw <erik@harddisk-recovery.com>, colin <colin@realtek.com.tw>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051017091710.GT2811@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Jens Axboe <axboe@suse.de> wrote:

> On Mon, Oct 17 2005, Grzegorz Kulewski wrote:
> > On Mon, 17 Oct 2005, Jens Axboe wrote:
> > >>how to correct this problem ?
> > >
> > >See your buffer address, it's not aligned. You
> need to align that as
> > >well. This is needed because the hardware will
> dma directly to the user
> > >buffer, and to be on the safe side we require the
> same alignment as the
> > >block layer will normally generate for file
> system io.
> > >
> > >So in short, just align your read buffer to the
> same as your block size
> > >and you will be fine. Example:
> > >
> > >#define BS      (4096)
> > >#define MASK    (BS - 1)
> > >#define ALIGN(buf)      (((unsigned long) (buf) +
> MASK) & ~(MASK))
> > >
> > >char *ptr = malloc(BS + MASK);
> > >char *buf = (char *) ALIGN(ptr);
> > >
> > >read(fd, buf, BS);
> > 
> > Shouldn't one use posix_memalign(3) for that?
> 
> Dunno if one 'should', one 'can' if one wants to. I
> prefer to do it
> manually so I don't have to jump through #define
> hoops to get at it
> (which, btw, still doesn't expose it on this
> machine).
> 
> -- 
> Jens Axboe

Thanx a lot Jens :-)
Its working now.
I did not have to make these adjustments on 2.6
Is looks to be having more relaxation.

Can somebody please throw some light on how to find
your system's hard/soft block size ?


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
