Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135660AbRECCVB>; Wed, 2 May 2001 22:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135664AbRECCUv>; Wed, 2 May 2001 22:20:51 -0400
Received: from durandal.simons-rock.edu ([64.210.108.44]:64274 "HELO
	durandal.simons-rock.edu") by vger.kernel.org with SMTP
	id <S135660AbRECCUf>; Wed, 2 May 2001 22:20:35 -0400
Mime-Version: 1.0
Message-Id: <p04320402b7166eda68f2@[64.210.111.70]>
Date: Wed, 2 May 2001 22:20:33 -0400
To: linux-kernel@vger.kernel.org
From: peterius@durandal.simons-rock.edu
Subject: memory and current macro
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I've been trying to write a device driver and I've found two 
problems.  First, the current macro.  I wanted to get the uid of the 
calling process but "current->uid" does NOT work it returns some 
other number.  Same with "current->pid" and many others.  I figured 
these numbers weren't random and decided to print out a particular 
processes's descriptor and check out what was going on.  I found that 
"&(current->uid)" is 0x1d lower than the address that holds the user 
id.  In addition, adding 0x1d to that address added it twice???  So 
to get the uid I ended up adding half...or "&(current->uid) + 0x0f". 
Does anyone know why this is?  I have an i686 processor, IBM thinkpad 
570e laptop, Debian 2.2, kernel version 2.4.2.

	Second problem might not have anything to do with my device 
driver at all.  It seems that applications on my laptop know longer 
free memory they have allocated.  I thought it was my module.  I 
check "free" for the memory available, "insmod" my module, check 
"free" again, "rmmod" it.  Each time the amount of free memory goes 
down.  Even when I remove the module.  Then I found that all other 
processes do this also, from ftp to ls or cd.  Then I start getting 
really bad segmentation errors in almost every process I try to run. 
And at the top, they say, usually, "kernel BUG page_alloc.c line:xx". 
I'm worried I've corrupted something or I don't know.  I looked this 
up in the source but I don't know why everything is triggering it. 
Are there any known memory allocation or freeing problems with kernel 
2.4.2?

								- Peter
