Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbUKWFBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUKWFBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 00:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbUKWEtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 23:49:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10146 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262345AbUKVTF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:05:28 -0500
Date: Mon, 22 Nov 2004 20:05:25 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hans Reiser <reiser@namesys.com>
cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory
In-Reply-To: <41A23566.6080903@namesys.com>
Message-ID: <Pine.LNX.4.53.0411222002380.21595@yvahk01.tjqt.qr>
References: <2c59f00304112205546349e88e@mail.gmail.com>
 <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu> <41A23566.6080903@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>(Hint - "file as directory" broke a number of programs that didn't
>>expect that a file *could* be a directory, when run on a reiser4
>>filesystem...)
>
>It broke extraordinarily few.

(The fewer the better.)

That's good news, and frankly, I did not expect anything else. That's because
either programs definitely know that "it" is a file/directory because they just
mkdir'ed or so, or they implement correct error checks, e.g. the user just
created a directory and we check back (i.e. race protection).

What I am worried about is the opendir() libc call, which AFAIK does this:
  fd = open("directory", myflags | O_DIRECTORY)

OTOH, I'm not worried, because it should be the user's duty to check whether
directory really is one or not. Anything else is sloppy programming.
(Exception: taking argv[xx] from the user)


Cheers,
Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
