Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVFNRkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVFNRkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 13:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFNRkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 13:40:21 -0400
Received: from mail00hq.adic.com ([63.81.117.10]:43847 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261270AbVFNRjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 13:39:47 -0400
Message-ID: <42AF165E.1020702@xfs.org>
Date: Tue, 14 Jun 2005 12:39:42 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "K.R. Foley" <kr@cybsft.com>
CC: Andrew Morton <akpm@osdl.org>, pozsy@uhulinux.hu,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org>	<20050610112515.691dcb6e.akpm@osdl.org>	<20050611082642.GB17639@ojjektum.uhulinux.hu>	<42AAE5C8.9060609@xfs.org>	<20050611150525.GI17639@ojjektum.uhulinux.hu>	<42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <42AF0FA2.2050407@cybsft.com>
In-Reply-To: <42AF0FA2.2050407@cybsft.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jun 2005 17:39:44.0533 (UTC) FILETIME=[0D374450:01C57108]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
> Steve Lord wrote:
> <snip>
> 
>> So is this some P4 specific optimization which is not working as
>> intended?
>>
>> Steve
>>
>>
> 
> I'd say not since the first system I saw this on was a dual PIII Xeon. 
> While I am not 100% sure that the problems are related, the problem that 
> I saw on my 2.6 system also went away when I disabled hyper-threading in 
> the bios. It really just seems to me like it is some hard-to-trigger race.
> 

Not too hard for me :-(

Definitely a race, and it appears to be somewhere in the fork/exec/wait
complex at the very least. insmod is not built into nash, so is getting
run as a seperate process. Since module loading itself is synchronous,
the error would seem most likely to be happening in sys_wait4.

It could be the compiler doing a bad optimization, it could be
some other optimization code triggered by the Pentium 4 config
option, or, as you say, it could be a race which is being
opened up by the changed build flags.

Steve
