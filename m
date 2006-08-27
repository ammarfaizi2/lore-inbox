Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWH0T74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWH0T74 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWH0T7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 15:59:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:21019 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750961AbWH0T7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 15:59:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y43RFS+Er2wjJqBQdMmCSeH8jMSIYEF/tgjJZBDUQJgVmIlw08L43v6ZARaNymSACpr+Gc1YOJbO8jUQPTNMXDIY20w79yUlp/bBH5EntELkQEDF0WUDNOpeSkj9/5wnyqizbSFcrd9v7V5NJOGGW6lCOSH6ZdW8I1/MRl6jiaA=
Message-ID: <9e0cf0bf0608271259p688b8838rc181d3b03cf09996@mail.gmail.com>
Date: Sun, 27 Aug 2006 22:59:53 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608272116.23498.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <445B5524.2090001@gmail.com> <p73irkedod2.fsf@verdi.suse.de>
	 <44F1E970.1050709@zytor.com> <200608272116.23498.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/06, Andi Kleen <ak@suse.de> wrote:
> Just increasing that constant caused various lilo setups to not boot
> anymore. I don't know who is actually to blame, just wanting to
> point out that this "obvious" patch isn't actually that obvious.
>
> -Andi
>

Hello,

lilo has its own COMMAND_LINE_SIZE constant.  It is not depended on
the kernel one.

lilo-22.7 lilo.h:
#define COMMAND_LINE_SIZE        256     /* CL_LENGTH */

lilo-22.7.2 lilo.h:
#define COMMAND_LINE_SIZE       512     /* CL_LENGTH */

So at worse case scenario it passes 256 bytes into the kernel
truncated with null terminated. Best case scenario it passes 512
bytes. Anyway... As long as you don't modify lilo, the kernel can
expect what-ever command-line length it wishes and truncate it to
match its own COMMAND_LINE_SIZE.

Please notice that we modify the kernel so it can accept long command
lines at boot protocol >= 2.02, but we don't modify  lilo behavior. So
lilo user will not be able to use the long command line size, until
lilo is modified to support it.

There is also a problem with grub, I've written a patch for it:
https://savannah.gnu.org/bugs/?func=detailitem&item_id=13606

Best Regards,
Alon Bar-Lev.
