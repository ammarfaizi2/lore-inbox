Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbUKSAxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbUKSAxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbUKRSxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:53:50 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:54755 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262879AbUKRSwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:52:46 -0500
In-Reply-To: <E1CUprL-00041e-00@dorka.pomaz.szeredi.hu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, torvalds@osdl.org
MIME-Version: 1.0
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFA311AC16.4350B724-ON88256F50.0065969A-88256F50.00677F64@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 18 Nov 2004 10:49:34 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M2_07222004 Beta 2|July
 22, 2004) at 11/18/2004 13:52:44,
	Serialize complete at 11/18/2004 13:52:44
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>but I
>think usually you have lot's of virtual memory (4Gbyte per process),
>so killing off processes to get more of it makes no sense. 

I think it's fair to say you have 4G of virtual address space per process, 
but try to store 4G of information per process in it, and you will 
probably find you can't.  What's essentially scarce is swap space. Killing 
off processes frees up swap space.

It was probably wrong of me to say the OOM can't free up real memory, 
because where real memory backs virtual memory, the only way to free up 
the real memory is to page out the virtual memory or destroy it, and the 
OOM killer destroys it.

But still -- if the real memory shortage isn't because there's no place to 
page out to, but rather that the process that's supposed to be writing the 
pages is deadlocked, the OOM killer will not kick in.

