Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUG2Tsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUG2Tsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUG2Tsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:48:35 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:55018 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S265048AbUG2TsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:48:16 -0400
Message-ID: <4109544D.5000405@timesys.com>
Date: Thu, 29 Jul 2004 15:47:25 -0400
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
CC: Kumar Gala <kumar.gala@freescale.com>, LKML <linux-kernel@vger.kernel.org>,
       Greg Weeks <greg.weeks@timesys.com>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [BUG] PPC math-emu multiply problem
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com> <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com>
In-Reply-To: <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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


Thanks for doing the initial work!

> Due to its overhead, I never expected it to be _the_ solution for
> processors that don't have floating point hardware.  Recompiling
> the libraries with soft-float and using that option when compiling
> is the way to go.


Indeed, when using this board for real we generally recommend
exactly the same thing.

> Remember, don't mix soft-float compilation with libraries compiled
> with HW floating point, and trap emulations.  They are not
> compatible and will return erroneous results.


Unfortunately, LSB does not provide a set of test binaries which
use the softfloat ABI, so in order to get an LSB-comformant distribution
on this CPU, we need to use floating point emulation.  Interestingly,
this is the only LSB floating point test which fails.

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell's sig


