Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317789AbSFSGiF>; Wed, 19 Jun 2002 02:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317790AbSFSGiE>; Wed, 19 Jun 2002 02:38:04 -0400
Received: from [202.131.151.113] ([202.131.151.113]:42999 "HELO sandstorm.net")
	by vger.kernel.org with SMTP id <S317789AbSFSGiD>;
	Wed, 19 Jun 2002 02:38:03 -0400
Date: Mon, 17 Jun 2002 00:46:06 +0530
From: Abhishek Nayani <abhi@kernelnewbies.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] in do_mmap_pgoff() (2.4.19-preX)
Message-ID: <20020616191606.GA1888@SandStorm.net>
Mail-Followup-To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	While documenting the do_mmap_pgoff() function, i found this
snippet of code very suspicious:

        /* Private writable mapping? Check memory availability.. */
	        if ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE &&
                                           !(flags & MAP_NORESERVE) &&
			          !vm_enough_memory(len >> PAGE_SHIFT))
			return -ENOMEM; 
											 
	Here we need to quit if *any* one of the condition is true. So I
think it should be "||" instead of "&&". As according to the present
code, it quits only if all the 3 conditions is true, which is wrong.




					Bye,
						Abhi.
	
	
Linux Kernel Documentation Project
http://freesoftware.fsf.org/lkdp
--------------------------------------------------------------------------------
Those who cannot remember the past are condemned to repeat it - George Santayana
--------------------------------------------------------------------------------
                          Home Page: http://www.abhi.tk
-----BEGIN GEEK CODE BLOCK------------------------------------------------------
GCS d+ s:- a-- C+++ UL P+ L+++ E- W++ N+ o K- w--- O-- M- V- PS PE Y PGP 
t+ 5 X+ R- tv+ b+++ DI+ D G e++ h! !r y- 
------END GEEK CODE BLOCK-------------------------------------------------------
