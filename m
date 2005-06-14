Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVFNPlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVFNPlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 11:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVFNPlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 11:41:11 -0400
Received: from mail2.utc.com ([192.249.46.191]:6311 "EHLO mail2.utc.com")
	by vger.kernel.org with ESMTP id S261170AbVFNPlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 11:41:03 -0400
Message-ID: <42AEF8D2.7070507@cybsft.com>
Date: Tue, 14 Jun 2005 10:33:38 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Lord <lord@xfs.org>
CC: Andrew Morton <akpm@osdl.org>, pozsy@uhulinux.hu,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org>	<20050610112515.691dcb6e.akpm@osdl.org>	<20050611082642.GB17639@ojjektum.uhulinux.hu>	<42AAE5C8.9060609@xfs.org>	<20050611150525.GI17639@ojjektum.uhulinux.hu>	<42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org>
In-Reply-To: <42AEDCFB.8080002@xfs.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> Andrew Morton wrote:
> 
>> Stephen Lord <lord@xfs.org> wrote:
>>
>>> Pozsár Balázs wrote:
>>> > On Sat, Jun 11, 2005 at 08:23:20AM -0500, Steve Lord wrote:
>>> > >>I think this is not actually module loading itself, but a problem
>>> >>between the fork/exec/wait code in nash and the kernel.
>>> > > > I do not use nash, only bash, so this is not a nash-specific 
>>> issue.
>>> > >
>>> I disabled hyperthreading and things started working, so are there any
>>> HT related scheduling bugs right now?
>>
>>
>>
>> There haven't been any scheduler changes for some time.  There have 
>> been a
>> few low-level SMT changes I think.
>>
>> Are you able to identify which kernel version broke it?
>>
> 
> Still have not narrowed this down too far, disabling SMT made no
> difference, disabling SMP did, which I was expecting.
> 
> Steve
> 

I initially saw this with 2.6.12-rc1 and every version up through rc3. I
haven't tried with later versions. :-/ I initially reported here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111235814529008&w=2

The way that I got around it was to compile in my aic7xxx driver instead
of making it a module. I have also recently received an email from
someone saying that disabling module unloading would also solve it. That
very well may be true since I did run into another booting problem
(2.6.12-rc5) that disabling module unloading fixed :-/ I haven't had a
chance to go back and check this out though.

So to summarize: I have a dual 933 with aic7xxx compiled in to get
passed the problem described above. I have a dual 2.6 w/HT that I have
disabled module unloading to get passed another boot condition.


-- 
    kr

