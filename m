Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWIKOxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWIKOxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 10:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWIKOxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 10:53:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58777 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751278AbWIKOxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 10:53:34 -0400
Date: Mon, 11 Sep 2006 07:53:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: What's in libata-dev.git
In-Reply-To: <4505694D.5020304@garzik.org>
Message-ID: <Pine.LNX.4.64.0609110749410.27779@g5.osdl.org>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com>
 <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com>
 <4505694D.5020304@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Sep 2006, Jeff Garzik wrote:

> Sergei Shtylyov wrote:
> >    It's not likely I'll be able to try it. But I'm absolutely sure that
> > drive aborted the read commands with the sector count of 0 (i.e. 256
> > actually). The exact model was IBM DHEA-34331.
> >    255 sectors actually seems more safe bet.
> 
> This sort of thing should be handled by quirks, depending on the controller
> and drive.

Please don't play games with peoples data-safety.

It ios absolutely INCORRECT to think that "things should work as 
documented, let's fix it up with quirks".

It's a hell of a lot better to instead say "people f*ck up, this is a 
known point of trouble, and let's just not push the envelope that hard".

Making max-sectors be 255 instead of 256 just _avoids_ the problem that 
the ATA protocol uses a single-byte control register for the sector 
number, and that "0" is supposed to mean "256", but people have been 
_known_ to get it wrong several times.

It's not like it's even strange and inexplicable that some drive 
controller would think that "zero means zero". Quite the reverse. It's a 
strange special case, and it's not surprising at all that people would 
have gotten it wrong several times independently.

It's not even like you'd get magically higher performance by using 256 
sectors, so there's simply no win from living dangerously. Only losses.

		Linus
