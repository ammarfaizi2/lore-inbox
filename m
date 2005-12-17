Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVLQWkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVLQWkM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 17:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVLQWkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 17:40:11 -0500
Received: from are.twiddle.net ([64.81.246.98]:2954 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S964993AbVLQWkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 17:40:10 -0500
Date: Sat, 17 Dec 2005 14:38:24 -0800
From: Richard Henderson <rth@twiddle.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, dhowells@redhat.com, nickpiggin@yahoo.com.au,
       arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051217223824.GA16736@twiddle.net>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	torvalds@osdl.org, dhowells@redhat.com, nickpiggin@yahoo.com.au,
	arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
	cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <Pine.LNX.4.64.0512160829180.3060@g5.osdl.org> <20051216.142349.89717140.davem@davemloft.net> <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org> <20051216.145306.132052494.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216.145306.132052494.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 02:53:06PM -0800, David S. Miller wrote:
> I'll have to add "put write prefetch in CAS sequences" onto my sparc64
> TODO list :-)

You might consider just beginning your loops like

	mov	zero, old
	cas	[mem], zero, old

to do the initial read, since old will now contain the 
contents of the memory, and we havn't changed the memory.


r~
