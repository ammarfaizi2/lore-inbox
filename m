Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUG2TWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUG2TWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbUG2TV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:21:56 -0400
Received: from embeddededge.com ([209.113.146.155]:24589 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S265041AbUG2TVZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:21:25 -0400
In-Reply-To: <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com>
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Weeks <greg.weeks@timesys.com>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [BUG] PPC math-emu multiply problem
Date: Thu, 29 Jul 2004 15:22:33 -0400
To: Kumar Gala <kumar.gala@freescale.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 29, 2004, at 10:06 AM, Kumar Gala wrote:

>
> On Jul 29, 2004, at 8:14 AM, Greg Weeks wrote:
>
>> I'm seeing what appears to be a bug in the ppc kernel trap math
>> emulator. An extreme case for multiplies isn't working the way gcc
>> soft-float or hardware floating point is.

I'm not surprised.  I lifted this code from Sparc, glibc, and adapted
it as best I could for PPC years ago for the 8xx.  I was happy when
it appeared to work for the general cases. :-)

Due to its overhead, I never expected it to be _the_ solution for
processors that don't have floating point hardware.  Recompiling
the libraries with soft-float and using that option when compiling
is the way to go.

Remember, don't mix soft-float compilation with libraries compiled
with HW floating point, and trap emulations.  They are not
compatible and will return erroneous results.

Thanks.


	-- Dan

