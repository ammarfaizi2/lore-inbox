Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267696AbUG3Opr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267696AbUG3Opr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 10:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267697AbUG3Opr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 10:45:47 -0400
Received: from mail.timesys.com ([65.117.135.102]:16672 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S267696AbUG3Opl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 10:45:41 -0400
Message-ID: <410A5F08.90103@timesys.com>
Date: Fri, 30 Jul 2004 10:45:28 -0400
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
CC: Kumar Gala <kumar.gala@freescale.com>, LKML <linux-kernel@vger.kernel.org>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [BUG] PPC math-emu multiply problem
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com> <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com>
In-Reply-To: <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2004 14:45:01.0890 (UTC) FILETIME=[CB4CA220:01C47643]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Malek wrote:

>
> On Jul 29, 2004, at 10:06 AM, Kumar Gala wrote:
>
>>
>> On Jul 29, 2004, at 8:14 AM, Greg Weeks wrote:
>>
>>> I'm seeing what appears to be a bug in the ppc kernel trap math
>>> emulator. An extreme case for multiplies isn't working the way gcc
>>> soft-float or hardware floating point is.
>>
>
> I'm not surprised.  I lifted this code from Sparc, glibc, and adapted
> it as best I could for PPC years ago for the 8xx.  I was happy when
> it appeared to work for the general cases. :-)
>
> Due to its overhead, I never expected it to be _the_ solution for
> processors that don't have floating point hardware.  Recompiling
> the libraries with soft-float and using that option when compiling
> is the way to go.

OK, this patch fixes my multiply problem with the LSB test. I still need 
to test to make sure I didn't break anything else, but it appears the 
rounding is only used when converting back to IEEE format. Is there some 
reason this is something really dumb to do?

Signed-off-by: Greg Weeks <greg.weeks@timesys.com> under TS0087

--- tanith-linux-2.6.6/arch/ppc/math-emu/soft-fp.h.orig    2004-07-30 
10:31:34.000000000 -0400
+++ tanith-linux-2.6.6/arch/ppc/math-emu/soft-fp.h    2004-07-30 
10:31:57.000000000 -0400
@@ -15,7 +15,7 @@
 # define FP_RND_PINF        2
 # define FP_RND_MINF        3
 #ifndef FP_ROUNDMODE
-# define FP_ROUNDMODE        FP_RND_NEAREST
+# define FP_ROUNDMODE        FP_RND_ZERO
 #endif
 #endif

