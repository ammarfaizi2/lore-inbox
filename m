Return-Path: <linux-kernel-owner+w=401wt.eu-S932244AbWLQSJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWLQSJV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 13:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWLQSJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 13:09:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48203 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244AbWLQSJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 13:09:20 -0500
Date: Sun, 17 Dec 2006 10:08:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: Al Viro <viro@ftp.linux.org.uk>, David Howells <dhowells@redhat.com>,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fallout from atomic_long_t patch
In-Reply-To: <20061217173201.GA31675@2ka.mipt.ru>
Message-ID: <Pine.LNX.4.64.0612171005440.3479@woody.osdl.org>
References: <20061217105907.GE17561@ftp.linux.org.uk>
 <Pine.LNX.4.64.0612170911230.3479@woody.osdl.org> <20061217173201.GA31675@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2006, Evgeniy Polyakov wrote:
> 
> Delayed work was used to play with different timeouts and thus allow to
> smooth performance peaks, but then I dropped that idea, so timeout is always
> zero.

Ok, thanks for the explanation.

> I posted similar patch today to netdev@, which directly used
> work_pending instead of delayed_work_pending(), but if you will figure
> this out itself, I'm ok with proposed patch.

If I'm going to get the proper patch from the proper network trees, I'll 
just drop my patch. Whether you replace "delayed_work" with "work_struct" 
or not is not something I really care about - if you think you may want to 
play with the timeout idea in the future, please feel free to continue 
using delayed_work.

But if you do use delayed work, please use the "delayed_work_pending(&x)" 
function, rather than doing "work_pending(&x->work)" and knowing about the 
internals of how the delayed-work structure looks.

So with that out of the way, I'll just expect that I'll get whatever you 
decide on through Davem's git tree, once his drunken holiday revelry is 
over ;)

		Linus
