Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWIYGWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWIYGWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWIYGWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:22:17 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:63449 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932214AbWIYGWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:22:16 -0400
Date: Mon, 25 Sep 2006 08:17:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Adrian Bunk <bunk@stusta.de>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       junkio@cox.net
Subject: Re: git diff <-> diffstat
In-Reply-To: <Pine.LNX.4.64.0609241949370.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0609250812360.18552@yvahk01.tjqt.qr>
References: <20060924161809.GA13423@havoc.gtf.org> <Pine.LNX.4.64.0609241005290.4388@g5.osdl.org>
 <45172297.6070108@garzik.org> <Pine.LNX.4.64.0609241732580.3952@g5.osdl.org>
 <20060925011436.GC4547@stusta.de> <Pine.LNX.4.64.0609241858380.3952@g5.osdl.org>
 <20060925022208.GF4547@stusta.de> <Pine.LNX.4.64.0609241949370.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Ah, OK. The truncates are something I wasn't used from diffstat 
>> (diffstat always prints the complete name).
>
>Yeah, I don't know what the right solution is.
>
>Especially with renames (but even without), diffstat-like output can get 
>some _really_ long lines, and since I think it's important to get the 
>actual _stat_ part to line up (so that you can really see where the big 
>changes are),

Would it be useful to use the logarithm for the + and -? Like

  #perl
  print $filename, " | ",
        "+" x log($additions) / log(2),
        "-" x log($deletions) / log(2);

That would print 'small' changes with more or less (might want to 
tune log(2)) their regular amount of +/-, while 'large' changes (say, 
1000+?) do not create extremely long lines.



Jan Engelhardt
-- 
