Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWIKGMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWIKGMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 02:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWIKGMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 02:12:37 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:41440 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964908AbWIKGMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 02:12:36 -0400
Date: Mon, 11 Sep 2006 08:10:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Madore <david.madore@ens.fr>
cc: Joshua Brindle <method@gentoo.org>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part
 3/4: introduce new capabilities
In-Reply-To: <20060910200337.GA24123@clipper.ens.fr>
Message-ID: <Pine.LNX.4.61.0609110807250.14570@yvahk01.tjqt.qr>
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr>
 <1157905393.23085.5.camel@localhost.localdomain> <450451DB.5040104@gentoo.org>
 <20060910200337.GA24123@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> To expand on this a little, some of the capabilities you are looking to 
>> add are of very little if any use without being able to specify objects. 
>> For example, CAP_REG_OPEN is whether the process can open any file 
>> instead of specific ones. How many applications open no files whatsoever 
>> in practice? Even if there are some as soon as they change and need to 
>> open a file they'll need this capability and will be able to open any. 
>> CAP_REG_WRITE has the same problem. For a description of why 
>> CAP_REG_EXEC is meaningless see the digsig thread on the LSM list from 
>> earlier this year.
>
>CAP_REG_OPEN and CAP_REG_EXEC might be useful only for demonstration
>purposes, but I've *often* wished I could run a program without

You cannot reasonable run a program without CAP_REG_OPEN, because 
ld.so, libc.so and libdl.so all may load a ton of required files 
underneath you.

$ strace -e open ls 2>&1 >/dev/null | grep open | wc -l
36



Jan Engelhardt
-- 
