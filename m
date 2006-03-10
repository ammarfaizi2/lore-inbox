Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWCJFIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWCJFIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 00:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWCJFIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 00:08:17 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:45972 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751596AbWCJFIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 00:08:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Rn6wPX/bEEjLexOCT0ItfL8X+PgjH4WjuceZzphit+RWF1Z5pl2bV1ycPOAmMTcUZIUtlCL7aYfo/LfGPJZQTOEk/2cG5sCX73y40MtC2Kmyp3XTz7vANOwq6J2JbIFTyay3a26C3ayq4M3wzadyvgEi2NQ/lRiPlZMGN/WU18s=  ;
Message-ID: <441109BC.9070705@yahoo.com.au>
Date: Fri, 10 Mar 2006 16:08:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
CC: alsa-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rt20, "bad page state", jackd
References: <1141846564.5262.20.camel@cmn3.stanford.edu>	 <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>	 <1141938488.22708.28.camel@cmn3.stanford.edu>	 <4410B2D7.4090806@yahoo.com.au> <1141958866.22708.69.camel@cmn3.stanford.edu>
In-Reply-To: <1141958866.22708.69.camel@cmn3.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Lopez-Lezcano wrote:
> On Fri, 2006-03-10 at 09:57 +1100, Nick Piggin wrote:
> 
>>Fernando Lopez-Lezcano wrote:

>>Can you test with the latest mainline -git snapshot, or is it only
>>the -rt tree that causes the warnings?
> 
> 
> I found something strange although I don't know why it happens yet:
> 
>   Fedora Core 4 kernel (2.6.15 + patches) works fine.
>   Fedora Core 4 kernel + -rt21, [ahem... sorry], works fine.
>   Fedora Core 4 kernel + -rt21 + alsa kernel modules from 1.0.10 or
>      1.0.11rc3, fails[*]
>   Plain vanilla 2.6.15 + -rt21, works fine
>   Plain vanilla 2.6.15 + -rt21 + alsa kernel modules from 1.0.10 or
>      1.0.11rc3, fails[*]
> 
> So, it looks like it is some weird interaction between kernel modules
> that were not compiled as part of the kernel and the kernel itself. The
> "updated" modules are installed in a separate location (not on top of
> the built in kernel modules) and are found before the ones in the kernel
> tree.
> 
> I have been building this combination for a long long time with no
> problems, I don't know what might have happened that changed things.
> 
> Could be:
> - configuration problems?

No. It shouldn't do this even if there is a configuration problem.

> - the alsa tree is somehow incompatible with the kernel alsa tree, is
>   that even possible?
> 

Yes. Most likely this. It should be fixed before the new ALSA code is
pushed upstream.

It is probably not so much a matter of somebody breaking the ALSA code
as that it hasn't been updated for the new kernel refcounting rules.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
