Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270443AbTGMXUf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270441AbTGMXUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:20:35 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:36241 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270434AbTGMXUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:20:33 -0400
Date: Sun, 13 Jul 2003 16:35:03 -0700
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Roland Dreier <roland@topspin.com>, alan@storlinksemi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
Message-ID: <20030713233503.GA31793@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"David S. Miller" <davem@redhat.com>,
	Roland Dreier <roland@topspin.com>, alan@storlinksemi.com,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com> <20030713004818.4f1895be.davem@redhat.com> <52u19qwg53.fsf@topspin.com> <20030713160200.571716cf.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713160200.571716cf.davem@redhat.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 04:02:00PM -0700, David S. Miller wrote:
> On send this doesn't matter, on receive you use my clever receive
> buffer handling + flow cache idea to accumulate the data portion of
> packets into page sized chunks for the networking to flip.

Please don't.  I think page flipping was a bad idea.  I think you'd be 
better off to try and make the data flow up the stack in small enough 
windows that it all sits in the cache.

One thing SGI taught me (not that they wanted to do so) is that infinitely
large packets are infinitely stupid, for lots of reasons.  One is that
you have to buffer them somewhere and another is that the bigger they 
are the bigger your cache needs to be to go fast.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
