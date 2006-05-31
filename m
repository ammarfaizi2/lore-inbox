Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWEaHpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWEaHpn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 03:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWEaHpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 03:45:42 -0400
Received: from gw.openss7.com ([142.179.199.224]:7148 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S964836AbWEaHpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 03:45:42 -0400
Date: Wed, 31 May 2006 01:45:40 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: David Miller <davem@davemloft.net>
Cc: draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060531014540.A1319@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: David Miller <davem@davemloft.net>,
	draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <20060531042908.10463.qmail@web51410.mail.yahoo.com> <20060530235525.A30563@openss7.org> <20060531.001027.60486156.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060531.001027.60486156.davem@davemloft.net>; from davem@davemloft.net on Wed, May 31, 2006 at 12:10:27AM -0700
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On Wed, 31 May 2006, David Miller wrote:

> From: "Brian F. G. Bidulock" <bidulock@openss7.org>
> Date: Tue, 30 May 2006 23:55:26 -0600
> 
> > For example, it goes to great pains to permute upper order bits in
> > the local address, which for most connections will be a constant
> > value.
> 
> Consider an apache server hosting thousands of virtual
> hosts.  The local address will be different for every
> such host.
> 

If you mean named virtual hosts, no.  They have the same
addresses.

If you mean actual hosts (with an IP address), perhaps in
the low order bits (host number), but unlikely in the high
order bits of the local address (network mask bits).

Also, in such a case the local port number will be rather
constant (80, etc); a condition also not exploited by the
function.

Also consider that the function simply folds the values
rather than permuting bits across the key field by shifting
by some other value than a multiple of 8 between XOR
operations.  This will result in a longer collision list
because the entropy of the key value has not been
sufficiently reduced.

It might sound like I'm complaining, but I'm not.  The
function works for me.  But from a purist point of view,
the hash function is not as efficient as it could be and
there is room for improvement.
