Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267336AbTABWT6>; Thu, 2 Jan 2003 17:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267337AbTABWT5>; Thu, 2 Jan 2003 17:19:57 -0500
Received: from bitmover.com ([192.132.92.2]:11170 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267336AbTABWTx>;
	Thu, 2 Jan 2003 17:19:53 -0500
Date: Thu, 2 Jan 2003 14:28:16 -0800
From: Larry McVoy <lm@bitmover.com>
To: Thomas Ogrisegg <tom@rhadamanthys.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
Message-ID: <20030102222816.GF2461@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Thomas Ogrisegg <tom@rhadamanthys.org>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	Larry McVoy <lm@bitmover.com>
References: <20021230010953.GA17731@window.dhis.org> <20021230012937.GC5156@work.bitmover.com> <1041489421.3703.6.camel@rth.ninka.net> <20030102221210.GA7704@window.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102221210.GA7704@window.dhis.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1) Does not handle writes that straddle multiple VMAs
> 
> What exactly do you mean? In my test, files larger than a
> page were handled perfectly, as well.

	mmap(file1 at location [a,b)
	mmap(file2 at location [b,c)
	write(sock, a, (size_t)(c - a));

> However, I didn't like the VM waste either, but I believe there
> is no other way.

The VM cost hurts.  Badly.  Imagine that the network costs ZERO.  Then
the map/unmap/vm ops become the dominating term.  That's why it is a
fruitless approach, it still has a practical limit which is too low.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
