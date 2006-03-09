Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWCICAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWCICAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 21:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWCICAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 21:00:47 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:4480 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932147AbWCICAq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 21:00:46 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 8 Mar 2006 18:00:40 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, David Miller <davem@davemloft.net>
Subject: Re: [patch] POLLRDHUP/EPOLLRDHUP handling for half-closed devices
 notifications ...
In-Reply-To: <Pine.LNX.4.63.0603071247440.15576@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0603081755530.4421@localhost.localdomain>
References: <Pine.LNX.4.63.0603071247440.15576@localhost.localdomain>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2006, Davide Libenzi wrote:

>
> The attached patch against 2.6.16-rc5 implements the half-closed devices 
> notifiation, by adding a new POLLRDHUP (and its alias EPOLLRDHUP) bit to the 
> existing poll/select sets. Since the existing POLLHUP handling, that does not 
> report correctly half-closed devices, was feared to be changed, this 
> implementation leaves the current POLLHUP reporting unchanged and simply add 
> a new bit that is set in the few places where it makes sense.
> The same thing was discussed and conceptually agreed quite some time ago:
>
> http://lkml.org/lkml/2003/7/12/116
>
> Since this new event bit is added to the existing Linux poll infrastruture, 
> even the existing poll/select system calls will be able to use it. As far as 
> the existing POLLHUP handling, the patch leaves it as is.
> The pollrdhup-2.6.16.rc5-0.10.diff defines the POLLRDHUP for all the existing 
> archs and sets the bit in the six relevant files.
> The other attached diff is the simple change required to sys/epoll.h to add 
> the EPOLLRDHUP definition.

I just added a stupid program to test POLLRDHUP delivery here:

http://www.xmailserver.org/pollrdhup-test.c

It tests poll(2), but since the delivery is same epoll(2) will work equally.



- Davide


