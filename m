Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269136AbUIXUnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269136AbUIXUnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269135AbUIXUmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:42:47 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:62319 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269132AbUIXUk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:40:57 -0400
Subject: Re: 2.6.9-rc2-mm3
From: Paul Fulghum <paulkf@microgate.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20040924204345.C11325@flint.arm.linux.org.uk>
References: <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com>
	 <1096051977.1938.5.camel@deimos.microgate.com>
	 <1096053328.1938.11.camel@deimos.microgate.com>
	 <20040924204345.C11325@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1096058415.1981.25.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 15:40:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 14:43, Russell King wrote:
> a port supporting only 8 bit data transmission
> must not report in termios that it is set to 7 bit data transmission.

OK, the check should stay.

Side note: the current check has an off by one bug:

if (cbaud < 1 || cbaud + 15 > n_baud_table)
   termios->c_flag &= ~CBAUDEX;
else
   cbaud += 15;

where cbaud is an index into baud_table array
and n_baud_table is the number of elements
in baud_table. The conditional should be:

if (cbaud < 1 || cbaud + 15 >= n_baud_table)


-- 
Paul Fulghum
paulkf@microgate.com

