Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbWGNT1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWGNT1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422727AbWGNT1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:27:51 -0400
Received: from relay03.pair.com ([209.68.5.17]:52751 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1422726AbWGNT1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:27:50 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 14 Jul 2006 14:27:47 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Michael Lindner <mikell@optonline.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: epoll_wait() returns wrong events for EOF with EPOLLOUT
In-Reply-To: <200607141518.58635.mikell@optonline.net>
Message-ID: <Pine.LNX.4.64.0607141425391.27161@turbotaz.ourhouse>
References: <200607141518.58635.mikell@optonline.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006, Michael Lindner wrote:

> 	Also a minor issue - epoll_ctl doesn't check if the fd in events.data.fd
> 	is the same as the fd that's been passed in as argument 3. If they differ
> 	(due to programmer error), epoll_wait will return an event with the
> 	incorrect events.data.fd specified to epoll_ctl().

This is expected behavior. events.data is a union. It is not possible or 
desireable to test data.fd in epoll_ctl() because it would break /many/ 
users of epoll who use the 32 or 64 bit unsigned field or pointer instead 
of fd.

Thanks,
Chase
