Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVCAWK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVCAWK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVCAWK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:10:59 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:17607 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262089AbVCAWKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:10:42 -0500
To: Bernd Schubert <bernd-schubert@web.de>
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re: x86_64: 32bit emulation problems
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
	<20050301202417.GA40466@muc.de>
	<200503012207.02915.bernd-schubert@web.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: My TOYOTA is built like a ... BAGEL with CREAM CHEESE!!
Date: Tue, 01 Mar 2005 23:10:38 +0100
In-Reply-To: <200503012207.02915.bernd-schubert@web.de> (Bernd Schubert's
 message of "Tue, 1 Mar 2005 22:07:01 +0100")
Message-ID: <jewtsruie9.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert <bernd-schubert@web.de> writes:

>> It is most likely some kind of user space problem.  I would change
>> it to int err = stat(dir, &buf);
>> and then go through it with gdb and see what value err gets assigned.
>>
>> I cannot see any kernel problem.
>
> The err value will become -1 here.

That's because there are some values in the stat64 buffer delivered by the
kernel which cannot be packed into the stat buffer that you pass to stat.
Use stat64 or _FILE_OFFSET_BITS=64.

>  Trond Myklebust already suggested to look at the results of errno:
>
> On Tuesday 01 March 2005 00:43, Bernd Schubert wrote:
>> On Monday 28 February 2005 23:26, you wrote:
>> > Given that strace shows that both syscalls (stat64() and stat())
>> > succeed,

The trace does not say anything about the user-level stat().

>> bernd@hitchcock tests>./test_stat32 /mnt/test/yp
>> stat for /mnt/test/yp failed
>> ernno: 75 (Value too large for defined data type)
>>
>> But why does stat64() on a 64-bit kernel tries to fill in larger data than
>> on a 32-bit kernel and larger data also only for nfs-mount points? Hmm, I
>> will tomorrow compare the tcp-packges sent by the server.
>
> So I still think thats a kernel bug.

This has nothing to do with the kernel.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
