Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTD3XIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbTD3XIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:08:52 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1175
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262497AbTD3XIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:08:51 -0400
Subject: Re: [RFC][PATCH] Faster generic_fls
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, dphillips@sistina.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87vfwv4pg2.fsf@student.uni-tuebingen.de>
References: <Pine.LNX.4.44.0304300911420.16712-100000@home.transmeta.com>
	 <1051734350.20270.28.camel@dhcp22.swansea.linux.org.uk>
	 <87vfwv4pg2.fsf@student.uni-tuebingen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051741347.20270.33.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Apr 2003 23:22:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-30 at 22:59, Falk Hueffner wrote:
> > ffs(x^(x-1)) == fls(x)
> 
> I don't think so. Maybe you are thinking of ffs(x) == fls(x & -x). So
> you can calculate ffs with fls, but not easily the other way round.

Well I asked my CPU to double check. If I got the code right it thinks that
ffs(i^(i-1))==fls(i) is true for 1->2^32-1

If you think about it it seems to make sense

	x-1 turns the lowest 100..0 sequence into 01......1

	The xor removes unchanged higher bits

	so 
		10100
         -1     10011
	XOR	00111


