Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265810AbUEZVZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUEZVZk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 17:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUEZVZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 17:25:39 -0400
Received: from aun.it.uu.se ([130.238.12.36]:30649 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265810AbUEZVZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 17:25:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16565.1600.168844.334347@alkaid.it.uu.se>
Date: Wed, 26 May 2004 23:04:00 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Paul Jackson <pj@sgi.com>
Cc: akiyama.nobuyuk@jp.fujitsu.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI trigger switch support for debugging
In-Reply-To: <20040526133438.196ca930.pj@sgi.com>
References: <40B1BEAC.30500@jp.fujitsu.com>
	<20040524023453.7cf5ebc2.akpm@osdl.org>
	<40B3F484.4030405@jp.fujitsu.com>
	<20040525184148.613b3d6e.akpm@osdl.org>
	<40B400D1.1080602@jp.fujitsu.com>
	<16564.26285.431229.665902@alkaid.it.uu.se>
	<20040526133438.196ca930.pj@sgi.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson writes:
 > Mikael Pettersson, replying to AKIYAMA Nobuyuki:
 > >  > +	if (!old_state == !unknown_nmi_panic)
 > >  > +		return 0;
 > > 
 > > This conditional looks terribly obscure.
 > 
 > Would the following variant seem clearer:
 > 
 > 	if (!!unknown_nmi_panic == !!old_state)
 > 		return 0;
 > 
 > Odd, I know.  For those of us familiar with the '!!' idiom, which
 > converts any value to its binary logical equivalent 0 (if zero) or
 > 1 (otherwise), this reads as:
 > 
 > 	if (the logical value of unknown_nmi_panic is unchanged)
 > 		return 0;

The !! idiom has the advantage of making it crystal clear
that the author is comparing boolean-normalised values.
The code I commented on was unusual enough that I couldn't
ignore the possibility of a bug.

In this case, I'd prefer the !! idiom, or moving the test into
the two state-changing code snippets below it.

/Mikael
