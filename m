Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292580AbSBPWcL>; Sat, 16 Feb 2002 17:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292581AbSBPWcB>; Sat, 16 Feb 2002 17:32:01 -0500
Received: from colorfullife.com ([216.156.138.34]:64522 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S292580AbSBPWbn>;
	Sat, 16 Feb 2002 17:31:43 -0500
Message-ID: <3C6EDDCA.DAB884BD@colorfullife.com>
Date: Sat, 16 Feb 2002 23:31:38 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-21 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5: further llseek cleanup (3/3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

I think the pcilynx change is wrong:

> -        if (newoffs < 0 || newoffs > PCILYNX_MAX_MEMORY + 1) return
> -EINVAL;
> +        if (newoffs < 0 || newoffs > PCILYNX_MAX_MEMORY + 1) {
> +                lock_kernel();
                  ^^^^^^ unlock_kernel()?
> +                return -EINVAL;
> +        }
>  
>          file->f_pos = newoffs;
^^^^^^^^^^^^^^^^^^^ where is the unlock here?
>          return newoffs;

--
	Manfred
