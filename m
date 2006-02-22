Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWBVUCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWBVUCf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWBVUCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:02:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12963 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750870AbWBVUCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:02:35 -0500
Subject: Re: 2.6.16-rc4: known regressions
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, gombasg@sztaki.hu, tytso@mit.edu,
       torvalds@osdl.org, kay.sievers@suse.de, penberg@cs.helsinki.fi,
       gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
In-Reply-To: <20060222115410.1394ff82.akpm@osdl.org>
References: <20060221225718.GA12480@vrfy.org>
	 <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org>
	 <20060221162104.6b8c35b1.akpm@osdl.org>
	 <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
	 <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
	 <20060222112158.GB26268@thunk.org>
	 <20060222154820.GJ16648@ca-server1.us.oracle.com>
	 <20060222162533.GA30316@thunk.org>
	 <20060222173354.GJ14447@boogie.lpds.sztaki.hu>
	 <20060222185923.GL16648@ca-server1.us.oracle.com>
	 <20060222115410.1394ff82.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 21:02:11 +0100
Message-Id: <1140638531.2979.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, I tend to think that insmod should just block until all devices are
> ready to be used.  insmod doesn't just "insert a module".  It runs that
> module's init function.

that's just not always possible. Think USB, where you don't know the hub
is there.. until it had time to think about it for a bit after it got
power. 

> 
> But right now the default (and unalterable) behaviour is the oddball,
> rarely-desired and hard-to-handle one.

well there is one worse behavior: doing it sync for some, async for
others. That'd mean that the kernel needs to do all the work AND
userspace needs to do all the work *again*.

Lets at least pick ONE place where the work needs to be done ;)
(and if that is userspace, we can make a debug config option which
delays device announcing for a second or two just to help userland
developers debug their code)

