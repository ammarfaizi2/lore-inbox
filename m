Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVF1TKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVF1TKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVF1TKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:10:17 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:42354 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261194AbVF1TJ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:09:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M+J07KqLW5Z5WnWViLUqWsm1uNEfySIzRIBNzK37aLT7UMQMGSc+dc4KZ1l9aQP8/A0diuVoCqzWwx+VlIkJ75DRqPJuEK4a2cgTUnZ6SoiIAvcZ48AAC89c+zgn63fgMbPt5Lccc5uIJurRrWYcML94e7yX3HVa8hKyXic0HPY=
Message-ID: <94e67edf05062812096ece6cf7@mail.gmail.com>
Date: Tue, 28 Jun 2005 15:09:56 -0400
From: Sreeni <sreeni.pulichi@gmail.com>
Reply-To: Sreeni <sreeni.pulichi@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Memory Management during Program Loading
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506281858.j5SIw2dr013640@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <94e67edf05062810497c7a20b5@mail.gmail.com>
	 <200506281800.j5SI0FEe011475@turing-police.cc.vt.edu>
	 <94e67edf0506281112545d4766@mail.gmail.com>
	 <200506281858.j5SIw2dr013640@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My main aim is to run a particular application in a known and fixed
physical memory location. When kernel loads this binary, is there a
way to force it to load at that fixed memory location. For example I
always wanna run a program "hello_world.bin" from physical address
location 0x007F_0000 to 0x007F_FFFF. I want my data, stack etc to be
in this location only.

The word "secure" is our internal terminology which seems to be bit confusing.

Thanks
Sreeni

On 6/28/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Tue, 28 Jun 2005 14:12:43 EDT, Sreeni said:
> 
> > We have a "Bus Monitor hardware" which monitors and polices the bus at
> > the specified physical address.
> 
> What does this hardware do, exactly, in addition to the usual memory-protection
> capabilities of the main processor?  I suspect the answer to your query will
> depend largely on what your monitor does, exactly, and what capabilities
> it has, and what threat model you're trying to secure against....
> 
> > Basically we need to run "secure" program under the supervision of the
> > Bus monitor hardware.
> 
> Is there an actual "threat model" here, as in "the attacker might try XYZ,
> and this monitor is a defense because it does ABC, rendering XYZ ineffective"?
> 
> I'm unclear on how the monitor can provide any *real* security when it quite
> likely does *not* have access to the entire state of the system (in particular,
> if there's a security-critical value that's still in a CPU register or L1
> cache line...)
> 
> > Kernel can see the "secure" memory region, and kernel is reponsible for enabling
> > the "Bus monitor Hardware".
> 
> The problem is that you're using an unsecured kernel to initially load the secure
> memory region - so an attacker is free to load broken code into the secure
> area.  The usual "trusted system" solution for this is to ensure that the kernel
> *also* runs inside the tamper-proof evironment....
> 
> Or is the *real* question here "We have a bus analyzer that can't see all of
> the physical memory, so we need the code we're interested in to be in the
> part of physical memory it can see"?  If that's the case, totally different
> answers will probably apply (as we don't have to do things in a "secure" manner,
> we just need to get the right pages in the right frames before the analyzer is
> turned on).....
> 
> 
> 


-- 
~Sreeni
       -iDream
