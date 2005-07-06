Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVGFTo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVGFTo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVGFTo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:44:57 -0400
Received: from [195.23.16.24] ([195.23.16.24]:49341 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262308AbVGFOYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:24:05 -0400
Message-ID: <42CBE97C.2060208@grupopie.com>
Date: Wed, 06 Jul 2005 15:23:56 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Slowdown with randomize_va_space in 2.6.12.2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, all

I have a bash script that calls a small application several times 
(around 50 calls) that just send and receives data through an already 
open tcp socket to a local server through the loopback device. It also 
launches another small app several times that just reads a small file 
from disk and does some processing on it in memory.

We noticed a severe performance regression on this application under 
kernel 2.6.12.2 that we tracked down to the address space randomization 
patches:

# echo 0 > randomize_va_space
# time ./script
real    0m0.671s
user    0m0.293s
sys     0m0.325s

# echo 1 > randomize_va_space
# time ./script
real    0m3.310s
user    0m2.712s
sys     0m0.401s

Notice that the real time is 5x slower with "randomize_va_space" turned 
on. This is on a Transmeta Crusoe TM5600 at 533MHz.

What is weird is that most of the extra time is being accounted as 
user-space time, but the user-space application is exactly the same in 
both runs, only the "randomize_va_space" parameter changed.

I browsed the randomization patch code and I don't think the random 
calculations themselves could account for all that time.

Does anybody have a clue as to why this is happening or what I should do 
to debug this further?

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
