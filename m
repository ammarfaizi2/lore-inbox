Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278964AbRJVVnD>; Mon, 22 Oct 2001 17:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278965AbRJVVlf>; Mon, 22 Oct 2001 17:41:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:2014 "EHLO
	e33.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278962AbRJVVlD>; Mon, 22 Oct 2001 17:41:03 -0400
Date: Mon, 22 Oct 2001 14:38:22 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: How to read past 8Mb boundary in early boot (i386 arch)?
Message-ID: <3034122113.1003761502@mbligh.des.sequent.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At boot time, we seem map the first 8Mb by hand ... unfortunately
my hardware puts the MPS tables at 511Mb. Reading this crashes 
us hard & fast ;-)

My current "fix" for this problem involves patching the firmware
to put the MPS tables at 7Mb instead, which worked fine, but it's
difficult to release patches for the firmware. I'm thinking it might be 
easier to hack Linux.

What I guess is needed is to read the pointer to the MPS tables,
if pointer > 8Mb (well, plus the length of the table or an allowance) 
then copy it to 7Mb with some phys_memcopy routine. But it seems
this means handcrafting a page table entry ... in which case, it might 
be easier to temporarily create a page table for the area pointed to, 
read it as normal, then tear it down again afterwards?

Any pointers much appreciated. Speak slowly, handcrafting page
tables is mildly confusing (to me ;-)).

Thanks,

Martin.

