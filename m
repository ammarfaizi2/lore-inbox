Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265767AbTGDFrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 01:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbTGDFrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 01:47:52 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:46188 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265767AbTGDFrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 01:47:51 -0400
Date: Fri, 04 Jul 2003 02:02:03 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
In-reply-to: <3F04EAA0.2050102@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, netdev@oss.sgi.com
Message-id: <200307040200.08574.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <200307032231.39842.jeffpc@optonline.net>
 <3F04EAA0.2050102@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 03 July 2003 22:46, Jeff Garzik wrote:
> Jeff Sipek wrote:
> > +	spinlock_t	rx_packets;
<snip>
> > +	spinlock_t	tx_compressed;
>
> That's a fat daddy list of locks you got there.

Yeah, I know, I am sure there is a way of getting rid of some of those.. (i.e.
the tx functions are inside a spinlock from struct net_device.)

> > +	NETSTAT_TYPE	_rx_packets;		/* total packets received	*/
> > +	NETSTAT_TYPE	_tx_packets;		/* total packets transmitted	*/
> > +	NETSTAT_TYPE	_rx_bytes;		/* total bytes received 	*/
> > +	NETSTAT_TYPE	_tx_bytes;		/* total bytes transmitted	*/
> > +	NETSTAT_TYPE	_rx_errors;		/* bad packets received		*/
> > +	NETSTAT_TYPE	_tx_errors;		/* packet transmit problems	*/
> > +	NETSTAT_TYPE	_rx_dropped;		/* no space in linux buffers	*/
> > +	NETSTAT_TYPE	_tx_dropped;		/* no space available in linux	*/
> > +	NETSTAT_TYPE	_multicast;		/* multicast packets received	*/
> > +	NETSTAT_TYPE	_collisions;
>
> Increasing user-visible sizes arbitrarily breaks stuff.  Having
> config-dependent types like this increases complexity.

Not really, those macros used to change the variables hide everything from the
driver programmer. Besides those changes in procfs and sysfs which always
return 64-bits, everything else is type casted (if needed) by those macros -
depending on CONFIG_NETSTATS64.

> Short term, just sample the stats more rapidly.

That's what Linus said. But it is only a temporary fix.

> Long term, I suppose with 10GbE we should start thinking about this.
> Personally, I would prefer to make the standard net device stats
> available in the format already exported by ETHTOOL_GSTATS -- which I
> note uses u64's for its counters, and it's easily extensible.  I
> received a request for this just today, even.

I was thinking about making the 64-bit stats mandatory, but then I opted to
make in an option in the config. (As Linus pointed out, some people want
performance, not statistics.)

Jeff.

- --
I'm somewhere between geek and normal.
		- Linus Torvalds
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BRhfwFP0+seVj/4RAtBbAJ4nmbs8ZQLgFagfb4KrJGZ55AYTmwCgzkcs
1uPma124BorLUdrcsbF2Txs=
=EIag
-----END PGP SIGNATURE-----

