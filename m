Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWAEQtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWAEQtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWAEQtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:49:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29919 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751361AbWAEQtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:49:08 -0500
Date: Thu, 5 Jan 2006 08:48:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/19] mutex subsystem, -V11 
In-Reply-To: <20379.1136468695@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0601050845070.3169@g5.osdl.org>
References: <1136301286.2869.2.camel@laptopd505.fenrus.org> 
 <20060103100632.GA23154@elte.hu> <16604.1136300837@warthog.cambridge.redhat.com>
  <20379.1136468695@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, David Howells wrote:
> 
> This sort of thing is done by the compiler when it does tail-calling.

Yes. And it's nice even when unconditional branches are effectively free, 
because it can avoid an unnecessary cache miss just to fetch the 
unnecessary branch (which very much _can_ happen, since the failure 
function will sleep).

Of course, the thing to look out for is to never get the call-return stack 
messed up, but this kind of regular tail-call doesn't have that issue.

			Linus
