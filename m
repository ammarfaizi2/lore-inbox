Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVCODQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVCODQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVCODQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:16:11 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:29517 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262219AbVCODPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:15:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WCGKObg9H5u3lzjlxDzCkm6kLlDVMRd4ilpTpEyzfRMF1rNMbVeYi2wVQ1EtSWW2R+wWN9Tn9vuXo1SzpvqB07BDjkV5dovqzC+Wre/Km8piEKa+/ITMwauaGZN9oUnrPx9+R0dcudsVw3rYqlcfPFffBcjcZumakWpUm/I2wns=
Message-ID: <9e47339105031419157d52dced@mail.gmail.com>
Date: Mon, 14 Mar 2005 22:15:36 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110807209.15943.115.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <1110568448.15927.74.camel@localhost.localdomain>
	 <16948.54411.754999.668332@wombat.chubb.wattle.id.au>
	 <1110807209.15943.115.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 13:33:31 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2005-03-14 at 00:02, Peter Chubb wrote:
> > I can see there'd be problems if the code allowed shared interrupts,
> > but it doesn't.
> 
> If you don't allow shared IRQ's its useless, if you do allow shared
> IRQ's it deadlocks. Take your pick 8)
> 
> As to your comment about needing to do a few more I/O operations I
> agree. However if your need is for speed then you might want to just
> write a small IRQ helper module for the kernel or extend the syntax I
> proposed a little (its conveniently trivial to generate native code from
> this).

The concept of passing in a little structure telling how to
acknowledge an interrupt is a very good one. I'd like to see it added
as a kernel feature so that drivers could start being converted to it.
This is a big deal for Xen since Xen has the same problem with
forwarded IRQs. Xen would pass the little structure from the domain to
the supervisor so that the supervisor could cut off the IRQ if the
domain fails.

> 
> There isn't much you can do about the status read without MWI on most
> chip designs (some get it right by posting status to system memory but
> not many)
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Jon Smirl
jonsmirl@gmail.com
