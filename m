Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTIKVle (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbTIKVle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:41:34 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:42131 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261555AbTIKVld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:41:33 -0400
Subject: Re: Size of Tasks during ddos
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Breno <brenosp@brasilsec.com.br>, Valdis.Kletnieks@vt.edu,
       Stan Bubrouski <stan@ccs.neu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030911213006.GD26618@matchmail.com>
References: <001b01c39047$d65cf580$f8e4a7c8@bsb.virtua.com.br>
	 <20030911002755.GA13177@triplehelix.org> <3F5FD993.2060900@ccs.neu.edu>
	 <009201c37860$f0d3c5f0$131215ac@poslab219>
	 <200309111419.h8BEJbSo010948@turing-police.cc.vt.edu>
	 <009f01c3788a$08b7f780$9f0210ac@forumci.com.br>
	 <1063305670.3605.0.camel@dhcp23.swansea.linux.org.uk>
	 <20030911212341.GB26618@matchmail.com>
	 <1063315578.3886.9.camel@dhcp23.swansea.linux.org.uk>
	 <20030911213006.GD26618@matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063316416.3881.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 22:40:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-11 at 22:30, Mike Fedyk wrote:
> > Syncookies protect you from DoS stuff but they have other side
> > effects on efficiency when they are in use. 
> 
> Care to point me to a thread in the archives?  I'd like to read more about
> this.

Not sure offhand where the thread is. The quick summary is

Syn cookies accept the SYN frame and encode sufficient information into
the reply that they can avoid storing any data until the next packet
arrives from the other end completing the connection.

That means squashing all the information we track (mss, window, etc)
into very few bits. A modern TCP will offer large windows, selective ack
and other features which we can't fit into a syn cookie so with this off
a burst of traffic will cause pauses while the socket queue clears and
negotiate fully featured TCP,  with syncookies enabled many of the
connections on the burst will not have the extra features so many not
perform as well.

