Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbTBFXu0>; Thu, 6 Feb 2003 18:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267554AbTBFXu0>; Thu, 6 Feb 2003 18:50:26 -0500
Received: from franka.aracnet.com ([216.99.193.44]:52620 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267351AbTBFXuY>; Thu, 6 Feb 2003 18:50:24 -0500
Date: Thu, 06 Feb 2003 15:59:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc -O2 vs gcc -Os performance
Message-ID: <285570000.1044575997@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302061456370.14478-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302061456370.14478-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The observation re low repeat rate is interesting ... might be amusing 
>> to do some really basic profile-guided optimisation on this grounds,
>> take readprofile / oprofile output, and compile the files that don't
>> get hammered at all with -Os rather than -O2. Given their low frequency
>> (by definition), I'm not sure that improving their icache footprint will
>> have a measureable effect though.
> 
> Icache footprint has nothing to do with repeat rates, which is exactly why 
> repeat rates are interesting for -Os.

Reading the below, I think I just misinterpreted what you meant by 
"repeate rate". My point was that if you hardly ever run that section
of code, -Os might be better. If we call how often you call that code
section it's "frequency" (nothing to do with how tightly it loops inside
it), then if the frequency of the code is low, the icache footprint 
might be better off smaller, as it'll just blow the icache when we do
run it and those cachelines are fetched. On the other hand, that won't
happen often, so it may well be unobservable for real loads.

M.



