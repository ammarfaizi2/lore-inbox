Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263682AbTJCKPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 06:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbTJCKPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 06:15:47 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:31732
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S263682AbTJCKPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 06:15:46 -0400
Message-ID: <3F7D4C4D.78BB5D0C@eyal.emu.id.au>
Date: Fri, 03 Oct 2003 20:15:41 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1: HZ not constant?
References: <20031002152648.GB1240@velociraptor.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting failures like this:

tr.c:81: initializer element is not constant
make[3]: *** [tr.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/net/802'


ecc.c:43: initializer element is not constant
ecc.c:1495: warning: function declaration isn't a prototype
make[2]: *** [ecc.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/drivers/char'

where the problem is a file level definition like
	static var = HZ;

and it seems that HZ is not anymore valid here (see include/linux/hz.h).

I have:
# CONFIG_DEBUG_KERNEL is not set

My gcc is 2.95 (Debian stable/woody).

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
