Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266696AbRHFEWK>; Mon, 6 Aug 2001 00:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266715AbRHFEWA>; Mon, 6 Aug 2001 00:22:00 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:9479 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266706AbRHFEVz>;
	Mon, 6 Aug 2001 00:21:55 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: R.E.Wolff@BitWizard.nl
Cc: linux-kernel@vger.kernel.org
Subject: rio_init, tty_io call confusion.  2.4.8-pre4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Aug 2001 14:22:00 +1000
Message-ID: <32756.997071720@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/tty_io calls rio_init and gets a link error when rio is
linked into the kenrel because rio_init is declared as static.  However
rio_init is also declared as module_init() so it gets called twice, one
from tty_io and once from the kernel initcall code.  One of those calls
has to go.  If you keep the tty_io call then rio_init cannot be static.

