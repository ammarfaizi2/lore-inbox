Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbTALWtX>; Sun, 12 Jan 2003 17:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbTALWtX>; Sun, 12 Jan 2003 17:49:23 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:57106
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267594AbTALWtT>; Sun, 12 Jan 2003 17:49:19 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Robert Love <rml@tech9.net>
To: robw@optonline.net
Cc: Oliver Neukum <oliver@neukum.name>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042410145.3162.152.camel@RobsPC.RobertWilkens.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
	 <20030112211530.GP27709@mea-ext.zmailer.org>
	 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
	 <200301122306.14411.oliver@neukum.name>
	 <1042410145.3162.152.camel@RobsPC.RobertWilkens.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042412286.834.101.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Jan 2003 17:58:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 17:22, Rob Wilkens wrote:

> I say "please don't use goto" and instead have a "cleanup_lock" function
> and add that before all the return statements..  It should not be a
> burden.  Yes, it's asking the developer to work a little harder, but the
> end result is better code.

No, it is gross and it bloats the kernel.  It inlines a bunch of junk
for N error paths, as opposed to having the exit code once at the end. 
Cache footprint is key and you just killed it.

Nor is it easier to read.

As a final argument, it does not let us cleanly do the usual stack-esque
wind and unwind, i.e.

	do A
	if (error)
		goto out_a;
	do B
	if (error)
		goto out_b;
	do C
	if (error)
		goto out_c;
	goto out;
	out_c:
	undo C
	out_b:
	undo B:
	out_a:
	undo A
	out:
	return ret;

Now stop this.

	Robert Love


