Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267311AbUHSTrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267311AbUHSTrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267336AbUHSTrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:47:40 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:35018 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S267311AbUHSTr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:47:26 -0400
Date: Thu, 19 Aug 2004 21:47:24 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: GNU make alleged of "bug" (was: PATCH: cdrecord: avoiding scsi device numbering for ide devices)
Message-ID: <20040819194724.GA10515@merlin.emma.line.org>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200408191600.i7JG0Sq25765@tag.witbe.net> <200408191341.07380.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408191341.07380.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, Gene Heskett wrote:

> Humm, I got many many losses of header stuff messages from:
> [root@coyote cdrecord]# make --version
> GNU Make 3.80

The "bug" is not specific to GNU make 3.80 but can also be seen in
3.78.1 for instance.

The "bug" however is purely cosmetical.

GNU make writes a message that an "include" file is missing, but it
finds it has a rule, generates the include file, pulls it in and
continues as though the file had always been there.

For instance if you have this Makefile:

# BEGIN Makefile
all:    hello
hello.d:
        makedepend -f- hello.c >$@
include hello.d
# END Makefile

You'll get at "make" time:

Makefile:5: hello.d: No such file or directory
makedepend -f- hello.c >hello.d
cc   hello.o   -o hello

and a working hello program.

Jörg's complaints about GNU make aren't false but aren't helpful either
and certainly don't warrant waiting 15 seconds after that message.

There is no bug, just this confusing "Makefile:5: hello.d: No such file
or directory".

> So apparently 3.80 is a regression in this case.

No, it isn't.

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
