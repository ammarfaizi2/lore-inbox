Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTHaDmK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 23:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTHaDmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 23:42:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27272 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262413AbTHaDmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 23:42:08 -0400
Date: Sat, 30 Aug 2003 20:33:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.22-pre1][NET] timer cleanups
Message-Id: <20030830203311.0b8c0807.davem@redhat.com>
In-Reply-To: <1062258097.8532.26.camel@lima.royalchallenge.com>
References: <1062258097.8532.26.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Aug 2003 21:11:37 +0530
Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:

> This patch does the following timer code cleanup:
> 
> 1. Change del_timer/add_timer to mod_timer
> 2. Use static timer initialisation wherever applicable

I'm not accepting this.  In particular, the ip6_flowlabel.c
change is a bad idea because the code remains racey.  Someone
submitted a similar move to mod_timer() for ip6_flowlabel
earlier this week so see my comments there about what needs
to occur to fix the code properly.

Just blindly doing these kinds of conversions to mod_timer()
is foolhardy.  You need to apply some brains to it to make
sure you really are getting rid of whatever potential races
exist in the code.  And in the ip6_flowlabel.c case things are
as buggy as they were before.

