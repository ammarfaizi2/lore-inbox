Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135725AbRDZRYG>; Thu, 26 Apr 2001 13:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135738AbRDZRX4>; Thu, 26 Apr 2001 13:23:56 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12276 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S135725AbRDZRXo>;
	Thu, 26 Apr 2001 13:23:44 -0400
Date: Thu, 26 Apr 2001 19:23:31 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200104261723.TAA20960.aeb@vlet.cwi.nl>
To: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH for 2.4.3 - tinny mount code cleanup (kernel 0.97 compatibility)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Martin Dalecki <dalecki@evision-ventures.com>

    The attached patch is fixing georgeous "backward compatibility"
    in the mount system command. It is removing two useless defines in
    the kernel headers and finally doubles the number of possible
    flags for the mount command.

    Please apply.

You have it all backwards. Your patch halves the number of
possible flags. The present kernel can use 32 (or 31) flags.

    @@ -1317,10 +1313,6 @@
         struct super_block *sb;
         int retval = 0;
     
    -    /* Discard magic */
    -    if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
    -        flags &= ~MS_MGC_MSK;
    - 
         /* Basic sanity checks */
     
         if (!dir_name || !*dir_name || !memchr(dir_name, 0, PAGE_SIZE))

You see what this code does: if the top half has this old magic
(as it has today in 100% of all Linux installations),
then the top half is ignored.
If the value is non-conventional, it can be used to mean something.

Maybe you did not realize that mount still puts that value there?
The mount we use today will be around for many years to come.
This "discard magic" part cannot be removed within five years.

Andries
