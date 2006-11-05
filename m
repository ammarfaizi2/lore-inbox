Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWKELcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWKELcu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 06:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWKELcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 06:32:50 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:52903 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932638AbWKELct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 06:32:49 -0500
Date: Sun, 5 Nov 2006 12:31:05 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Willy Tarreau <w@1wt.eu>
cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <20061105083416.GA2246@1wt.eu>
Message-ID: <Pine.LNX.4.61.0611051225130.12727@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.64.0611041633110.25218@g5.osdl.org>
 <Pine.LNX.4.64.0611050410210.29515@artax.karlin.mff.cuni.cz>
 <20061105083416.GA2246@1wt.eu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-40927187-1162726265=:12727"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-40927187-1162726265=:12727
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


>> BTW do you find uppercase typedefs like
>> typedef struct {
>> 	...
>> } SPADFNODE;
>> confusing too?
>
>Yes for the reason above. Also, we don't much use type definitions for
>structures, because it's easier to understand "struct spadfnode *node"
>in a function declaration than "SPADFNODE *node".

It gets worse when code authors begin to use

typedef struct { ... } MYSTRUCT, *PMYSTRUCT, **PPMYSTRUCT;

Most certainly you will run into "passing argument from incompatible 
pointer"[1] and "request for member ■a■ in something not a structure or 
union"[2] and "invalid type argument of ■->■"[3] (BTW I hate gcc using 
Unicode chars in its output which are not displayed in the console):

struct foo {
    int bar;
} ST, *PST;
void foobar(ST a) {  // [1]
    a->bar = 1;
    foobar2(a);  // [3]
}
void foobar2(PST a) {  // [2]
    a.bar = 1;
}

So I much rather like to see all the 'funky stars' (struct foo *) in the 
parameter list, instead of trying to keep track of how many of them a 
PST carries.



	-`J'
-- 
--1283855629-40927187-1162726265=:12727--
