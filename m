Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVE3J25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVE3J25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVE3J25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:28:57 -0400
Received: from nez-perce.inria.fr ([192.93.2.78]:27838 "EHLO
	nez-perce.inria.fr") by vger.kernel.org with ESMTP id S261570AbVE3J2y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:28:54 -0400
Mime-Version: 1.0 (Apple Message framework v622)
Content-Transfer-Encoding: 8BIT
Message-Id: <80c44317563cdb8d2757c40c768a3f19@inria.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
To: linux-kernel@vger.kernel.org
From: cedric lauradoux <cedric.lauradoux@inria.fr>
Subject: Defeating cache timing attack
Date: Mon, 30 May 2005 11:29:31 +0200
X-Mailer: Apple Mail (2.622)
X-Miltered: at nez-perce with ID 429ADCD5.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of things have been said recently on attacks against 
cryptographic primitives that make use of cache memory.
Those attacks are not new and if you want a more complete story of 
those attacks you mail me I will send you the
complete list of paper related to this subject. Now 2 kind of attacks 
seems to emerge:
- Passive attacks: just observe the timing of the code and try to find 
correlation between time variation and key

-Active Attacks: try to create correlation between timing and the key. 
Those attacks may involve
hyperthreading, or malicious code which produce interruptions and cache 
flushes.

Now the big problem is how to deal with those attacks:
- for active attacks the countermeasure is quite simple : take a dummy 
key and evaluate cache misses of several encryptions.
If the misses ratio are too big: the implementation is under attack 
(the only difficulty is too evaluate the work load of processor).
If we only want to defeat Hyperthreading attacks, we just have to code 
the algorithm using hyperthreading. The first thread
compute the algorithm and the second perform prefetch for the first 
thread.

- passive attacks are more complicated to defeat. The first solution is 
to use constant time memory access algorithm (removing lookup table).
We can also warmup the cache to reduce memory latency using prefetch 
instruction. This solution is not available when cache is small in 
comparison of the table.

Those countermeasures are in test. I hope that it will ready for WeWorc 
conference.

The conclusion is that those attacks are not really dangerous. Several 
software countermeasures are possible and it does not require to 
completely change cache architecture.

What do you think about my countermeasures ? I will be pleased with any 
comments or idea on attacks and countermeasures.


Cédric Lauradoux
Inria Rocquencourt
Project team CODES
