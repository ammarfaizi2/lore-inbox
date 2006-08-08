Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWHHPju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWHHPju (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWHHPjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:39:49 -0400
Received: from web25804.mail.ukl.yahoo.com ([217.12.10.189]:14712 "HELO
	web25804.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964966AbWHHPjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:39:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=i1MWXQK0blwdN8iqp80kK+1KsteJC90y0Xp98Jx4M5RT3cRYp1o/L8mt9ssd0wLu5lPke4BfgZfVJySXqBEYS6NeD5F7ObANCGZzQhfSFKI7enJ71Uly9/ZnVLOFVGHC3+hFTVKuevgy97bmNv15Nd57xhg2XSrBNDQUtzk1EYU=  ;
Message-ID: <20060808153947.39735.qmail@web25804.mail.ukl.yahoo.com>
Date: Tue, 8 Aug 2006 15:39:47 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : [HW_RNG] How to use generic rng in kernel space
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608042308.24421.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> So, if you have a special hwrng on your embedded board and you
> have some special driver in that board, why not interface
> directly from the driver to the hwrng-driver?

This is what I'm currently doing. I was just thinking to use the
new HW-RNG layer and drop common code...

> This is all pretty special case.
> In the hwrng-driver you could still additionally do a
> hrwng_register() to export the functionality to
> userspace, though.
> 

yes I would like to do that but there is a problem: I have no 
access to "rng_mutex" to synchronise hw accesses and I'm
wondering if there's any issue to use a mutex in driver init
code.

> 
> I am not a friend of a direct in-kernel hwrng access interface,
> because it may return crap data by definition. Many (all current)
> RNG devices may fail and return non-random data. If that's happily
> used by some in-kernel user by the interface, we are screwed.
> 
> Why can't you build your random-data consumer as module and load
> it later, when random data is available (and was carefully checked
> by various tests in rngd)?
> 

simply because in this embedded system, there's no module support.

thanks

Francis
