Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbULIDKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbULIDKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 22:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbULIDKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 22:10:39 -0500
Received: from [209.195.52.120] ([209.195.52.120]:1728 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261445AbULIDKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 22:10:34 -0500
Date: Wed, 8 Dec 2004 19:10:16 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Bernard Normier <bernard@zeroc.com>
cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
In-Reply-To: <079001c4dcc9$1bec3a60$6401a8c0@centrino>
Message-ID: <Pine.LNX.4.60.0412081905140.17193@dlang.diginsite.com>
References: <006001c4d4c2$14470880$6400a8c0@centrino>
 <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr> <009501c4d4c6$40b4f270$6400a8c0@centrino>
 <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino>
 <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org>
 <079001c4dcc9$1bec3a60$6401a8c0@centrino>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004, Bernard Normier wrote:

> I am just trying to generate UUIDs (without duplicates, obviously).
>

pulling data from /dev/random or /dev/urandom will not ensure that you 
don't have duplicates.

the key factor in a random number generator is that the next number to 
coem out must be (sufficiantly) unpredictable. this says nothing about it 
being unique, in fact it says that if you pull the number 1234 the first 
time you should have the exact same odds of pulling 1234 the second time 
as you have in pulling 4321 (or any other number)

no much of the time you can get away with useing a random number generator 
like this, but if you pull enough numbers you will get collisions.

remember the birthday paradox. it says that if you get a group of 26 
people in a room you have about a 50% chance that two of these people have 
the same birthday.

now that's only with numbers in the range of 1-365 if you pull 16 bit 
numbers (1-65536) you will need a much larger group to see the problem, 
but if you pull enough you WILL see the problem eventually.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
