Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbTI3EzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 00:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbTI3EzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 00:55:10 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37125
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263108AbTI3EzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 00:55:08 -0400
Subject: Re: -mregparm=3 (was Re: [PATCH] i386 do_machine_check() is
	redundant.
From: Robert Love <rml@tech9.net>
To: Valdis.Kletnieks@vt.edu
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200309300449.h8U4nSvl002308@turing-police.cc.vt.edu>
References: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org>
	 <1064775868.5045.4.camel@laptop.fenrus.com>
	 <Pine.LNX.4.58.0309292214100.3276@artax.karlin.mff.cuni.cz>
	 <20030929202604.GA23344@nevyn.them.org>
	 <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz>
	 <200309300449.h8U4nSvl002308@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1064897712.4568.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Tue, 30 Sep 2003 00:55:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 00:49, Valdis.Kletnieks@vt.edu wrote:

> I discovered that -test6-mm1 doesn't build with -ffreestanding with gcc 3.3.1,
> for an odd reason:  when I specify -ffreestanding, it generates 'call abs' calls
> where it was able to do it inline otherwise. -ffreestanding says there's no library,
> so it can't inline the library call (which leaves no external call to 'abs()').

Hm, we may need to do something like:

	#define abs(n)	 __builtin_abs((n))

because -ffreestanding implies -fno-builtin, which disables use of
built-in functions that do not begin with __builtin.

	Robert Love


