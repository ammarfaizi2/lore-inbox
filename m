Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbTIIUNG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTIIUNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:13:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:32671 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264485AbTIIUMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:12:32 -0400
Date: Tue, 9 Sep 2003 13:06:50 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5: configcheck results
Message-Id: <20030909130650.0670778d.rddunlap@osdl.org>
In-Reply-To: <20030909194001.GB3009@mars.ravnborg.org>
References: <20030909100412.A25143@flint.arm.linux.org.uk>
	<20030909194001.GB3009@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003 21:40:01 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:

| On Tue, Sep 09, 2003 at 10:04:12AM +0100, Russell King wrote:
| > Hi all,
| > 
| > I just ran make configcheck on 2.6.0-test5 and the results are:
| > 
| >     832 files need linux/config.h but don't actually include it.
| >     689 files which include linux/config.h but don't require the header.
| 
| Randy, you have looked into related perl scripts. Is the result of
| checkconfig.pl reliable?

They aren't perfect.  I consider them more like 80-90% solutions.
Usable until there's a better solution IMO, like maybe sparse.

The perl scripts don't look at other #included files to check if they
supply any of the needed #defines.  I.e., they look only at the one
file being searched to check if it uses names (CONFIG_*) without
#include-ing config.h in this case, so it can produce false positives.

I looked quickly at crypto/tcrypt.c (which is listed as needing config.h).
It #includes linux/init.h, which #includes linux/config.h.
I expect that there are several...or many like this.

--
~Randy
