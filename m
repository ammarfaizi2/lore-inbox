Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132734AbRDIMek>; Mon, 9 Apr 2001 08:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132738AbRDIMeb>; Mon, 9 Apr 2001 08:34:31 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:53388 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S132735AbRDIMe0>;
	Mon, 9 Apr 2001 08:34:26 -0400
Message-Id: <5.0.2.1.2.20010409131813.00a68b80@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 09 Apr 2001 13:34:30 +0100
To: Andi Kleen <ak@suse.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Q: process concurrency and sigaction()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010409134550.A26660@gruyere.muc.suse.de>
In-Reply-To: <5.0.2.1.2.20010409115354.00a311a0@pop.cus.cam.ac.uk>
 <5.0.2.1.2.20010409115354.00a311a0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Thanks a lot for the explanations! All clear now. (-:

[snip]
At 12:45 09/04/01, Andi Kleen wrote:
>It's ok, but you don't really need to spin. A flag is enough. Also you
>could use the signal blocking function (sigprocmask), but they're slightly
>more expensive than just setting a flag.

Yes, good point. Saves me a whole variable in my data structs in fact, as I 
already have 32 bits worth of mostly unused, atomic flags.

sigprocmask would be rather excessive considering it requires a full 
context switch into the kernel to execute and the high frequency of 
lock/unlocks in the normal code while the handler only executes once every 
5 seconds...

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

