Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWBJUDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWBJUDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWBJUDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:03:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20128 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751363AbWBJUDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:03:43 -0500
Date: Fri, 10 Feb 2006 12:03:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <43ECEEFF.7050905@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0602101200080.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
 <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au>
 <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au>
 <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au>
 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au>
 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au>
 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au>
 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au>
 <20060209231432.03a09dee.akpm@osdl.org> <43EC8A06.40405@yahoo.com.au>
 <Pine.LNX.4.64.0602100815580.19172@g5.osdl.org> <43ECC69D.1010001@yahoo.com.au>
 <Pine.LNX.4.64.0602100904330.19172@g5.osdl.org> <43ECD471.9080203@yahoo.com.au>
 <Pine.LNX.4.64.0602101011350.19172@g5.osdl.org> <43ECE97F.1080902@yahoo.com.au>
 <Pine.LNX.4.64.0602101138480.19172@g5.osdl! .org> <43ECEEFF.7050905@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
> Well in that case in your argument your FADV_WRITE_START is of
> the "waits for writeout then starts writeout if dirty" type.
> 
> In which case you've just made 3 consecutive  write+wait cycles
> to the same page, so it is hardly an optimal IO pattern.

The point is, this is the interface that an app would want to use if they 
want _perfect_ IO patterns. 

Obviously, such an app wouldn't do writes every 100 bytes (or would do 
them only if it knows that enough time has passed that the previous IO 
will be done - but it can't _risk_ dropping an IO if something strange 
happens).

The point being the ".. it might have dirtied the page since it's last 
WRITE_START" thing. That's where it can very validly basically say "ok, I 
now need for my last write to have finished, but I don't care about the 
fact that I've made other changes _since_ in that same page". See?

		Linus
