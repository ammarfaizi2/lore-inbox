Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262934AbVBCUEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVBCUEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbVBCUC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:02:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:2180 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262925AbVBCTwF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:52:05 -0500
Date: Thu, 3 Feb 2005 11:51:27 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Lorenzo =?ISO-8859-1?B?SGVybuFuZGV6IEdhcmPtYS1IaWVycm8=?= 
	<lorenzo@gnu.org>
Cc: linux@horizon.com, mingo@elte.hu, Arjan van de Ven <arjan@infradead.org>,
       bunk@stusta.de, Chris Wright <chrisw@osdl.org>, davem@redhat.com,
       Hank Leininger <hlein@progressive-comp.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, Valdis.Kletnieks@vt.edu, spender@grsecurity.net
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Message-ID: <20050203115127.3245951f@dxpl.pdx.osdl.net>
In-Reply-To: <1107365917.3754.155.camel@localhost.localdomain>
References: <20050202171702.24523.qmail@science.horizon.com>
	<1107365917.3754.155.camel@localhost.localdomain>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2005 18:38:37 +0100
Lorenzo Hernández García-Hierro <lorenzo@gnu.org> wrote:

> El mié, 02-02-2005 a las 17:17 +0000, linux@horizon.com escribió:
> > There *are* things in OpenBSD, like randomized port assignment (as opposed
> > to the linear scan in tcp_v4_get_port()) that would be worth emulating.
> > Maybe worry about that first?
> > 

Recent 2.6 does a more advanced form of port randomization already
using address hash at connect time.  tcp_v4_get_port is only used for the case
of applications that explicitly bind to port zero to find a free port.

So the sequence:
	socket(); connect(); 
will assign a random port in a manner similar to sequence number creation

The sequence:
	socket(); bind(); connect();
assigns a simple linear increasing port value.  It could be randomized, but
most applications don't bother binding, so the first case is sufficient.

-- 
Stephen Hemminger	<shemminger@osdl.org>
