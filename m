Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266921AbUHIUMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266921AbUHIUMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUHIULi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:11:38 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:13707 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266921AbUHIUHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:07:40 -0400
Message-ID: <4117D98C.2030203@comcast.net>
Date: Mon, 09 Aug 2004 16:07:40 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] Bug zapper?  :)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Assuming this accurately falls under [RFC]; I *am* requesting comments 
on this method)

A pondering of all the bugs in the linux kernel-- and yes, we all know 
there are bugs, stable or not-- always leads me to attempt to figure a 
way to get rid of them.  In the past I'd thought of taking just an 
unstructured "Tell the list to take a month to try and kill all bugs" 
approach; but decided that that would be a rediculous idea.  Since then 
I've been pondering, trying to figure a good and reliable way to do it 
other than rewriting from scratch (a very effective method of delousing 
a huge codebase).

I recently read a few pages in a book on exploiting software, skimming 
it in the bookstore to see if it was worth the buy.  For those 
interested, it's ISBN 0201786958, "Exploiting Software:  How to Break 
Code."  This gave me some insight into possible solutions.

The book covered several exploit types, although it didn't seem from the 
glance I took to indicate strong separation between those that exist by 
design (the ILoveYou bug used this type) and those that exist by 
screw-up (MSBlast and Sasser used these).  It discussed typical buffer 
overflows and software bugs, though.

What I found interesting was that it described bugs as 
pseudo-quantitative based on the KLOC (thousands of lines of code) for a 
code body.  The basic theory boils down to 5-50 bugs per 1000 LOC, 
approaching 5 for QA audited code.  Thus, 10000 LOC executable, 50 bugs.

Decrease the size of the code body, and you evade the above issue:  A 
small, independent code body will have the number of bugs approach 0; 
fractional (less than one) bug counts are lost.  This can be realisticly 
done.

First, above every function's implementation, explain the function in 
terms of **input**, **output**, and **state change**.  Detail its 
**process** as well if possible.  This allows you to make a definite 
review of a function from wherever you call it, simply by reading the 
comments.

Second, in all of your code, assume that the functions you call do 
**exactly** what these comments say they do, no more, no less.  This 
takes your view off the worry of "will this do something unexpected" and 
moves it to "am I screwing up HERE?"  This narrows your code body to the 
current function for the brief period that you're writing it.

In passing, you can check a function for bugs while considering it only 
the process that it performs, and puting absolute trust in the functions 
that it calls.  By explaining the process it performs, everyone else who 
looks at the code has deep enough knowledge that they can see bugs if 
they have technical knowledge about coding and the other functions. 
Furthermore, large code bodies are reduced to small sets of logical 
processes-- each function effectively becomes ONE line of code.

The result is that you micro-manage your functions, causing related bug 
searches to be narrowed down to them with confidence that your 
understanding of the function is correct due to the explaination above 
the function body.  This reduces all code bodies (asside from assembly) 
to a handfull of LOC, which statistically should have 0 bugs.

In practice, I believe this high volume of documentation will not reduce 
the kernel's bug count to 0; however, it would become closer, I believe. 
  It would become especially easier to devout bug-hunters, who no longer 
have to take several days to understand the code.

What do you all think?  Do you see flaws in my logic?

--John

-- 
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

Sorry, 64 bit cpu, Thunderbird is broke so no enigmail.  I'd sign it if 
I could.
