Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbTGLUzl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 16:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268473AbTGLUzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 16:55:41 -0400
Received: from c180224.adsl.hansenet.de ([213.39.180.224]:34699 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S267852AbTGLUzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 16:55:40 -0400
Message-ID: <3F10793E.5080202@portrix.net>
Date: Sat, 12 Jul 2003 23:10:22 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: agpgart, nforce2, radeon and agp fastwrite
References: <3F102E8E.4030507@portrix.net> <20030712202622.GB7741@suse.de>
In-Reply-To: <20030712202622.GB7741@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sat, Jul 12, 2003 at 05:51:42PM +0200, Jan Dittmer wrote:
>  > just took me half a hour to figure out. On nforce2 you have to disable 
>  > agp fastwrites, otherwise X locks hard on startup with the following 
>  > (from serial console).
>  > ...
>  > 
>  > Without AGP Fastwrites turned on, it all works wonderful. Just if 
>  > anybody encounters the same problem.
>  > Mainboard is nForce2 based, graphics is radeon 8500le (R200).
> 
> Could be that the nforce & radeon don't play well together.
> Anyone using fast writes without problems with non-ATI cards & nforce ?
> If it works there, it's trivial to blacklist ATI cards and make them
> unable to enable fast writes in the gart driver.
> 
Forgot to mention I had to use this patchlet to get nvidia-agp to link 
properly.

Jan

--- linux-mm/drivers/char/agp/generic.c Thu Jul  3 15:04:06 2003
+++ 2.5.73-mm3/drivers/char/agp/generic.c       Wed Jul  9 10:04:34 2003
@@ -39,7 +39,7 @@

  __u32 *agp_gatt_table;
  int agp_memory_reserved;
-
+EXPORT_SYMBOL(agp_memory_reserved)
  /*
   * Generic routines for handling agp_memory structures -
   * They use the basic page allocation routines to do the brunt of the 
work.


-- 
Linux rubicon 2.5.75-mm1-jd10 #1 SMP Sat Jul 12 19:40:28 CEST 2003 i686

