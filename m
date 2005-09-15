Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbVIOGu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbVIOGu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVIOGu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:50:57 -0400
Received: from [210.76.114.20] ([210.76.114.20]:59281 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932527AbVIOGu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:50:56 -0400
Message-ID: <432919C3.7060708@ccoss.com.cn>
Date: Thu, 15 Sep 2005 14:50:43 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Question] Can we release vma that include code when one process
 is running?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All:

    I am writing a patch to swap process memory to swap partition or 
swap file.
We think this make system speed up on PC that more little memory. It have
a bit like with page replacement algorithm depend application hit, but 
ours idea is
more easier.We found, if we try swap out openoffice.org, this way  can 
save more
than 50M memory, and when switch task to run openoffice.org again, it do 
not read
all data that did swapped from swap space at most time.

    According to result of experimmnt, the anonymous memory of one 
process are more than code
and data, even, it look some shared library as private code.

    As general rule, we can only some swap anonymous memory. this's OK! 
I also done that.
However my question is if we release vma that include code when one 
process is running?
Of course, if the refcnt of vma is more than one, it can not be released 
yet. In fact,
I writing one patch to do this, some it do successfully on some simple 
process, but
in more time, I will get a SIGSEGV!

    I am running IA32 architecture, I used one little python script to 
try this. and
get SIGSEGV each time. I dump memory that include that code, they are 
too simple:
   
    ...
    nop
    int $0x80
    ret
    nop
    ...

    It seem that code in other place jump here to enter kernel. this is 
in a anonymous
code area.
    At first time, I think this SIGSEGV will trigger by anonymous code 
that is swapped,
but I wrote one specical condition check to filte out this sort of code, 
IOW, I do
not swap out it. but I still get SIGSEGV.

    May be, we can not be release the vma that include code? or, Is 
there have some errors
 in my words for page fault?

   
   
sailor


