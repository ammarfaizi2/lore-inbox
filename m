Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWEBPE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWEBPE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWEBPE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:04:27 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:33807 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S964863AbWEBPE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:04:27 -0400
Message-ID: <445774F7.5030106@argo.co.il>
Date: Tue, 02 May 2006 18:04:23 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Willy Tarreau <willy@w.ods.org>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <20060502133416.GT27946@ftp.linux.org.uk> <4457668F.8080605@argo.co.il> <20060502143430.GW27946@ftp.linux.org.uk>
In-Reply-To: <20060502143430.GW27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 15:04:25.0460 (UTC) FILETIME=[B3A11340:01C66DF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Tue, May 02, 2006 at 05:02:55PM +0300, Avi Kivity wrote:
>   
>> Hey, I agree 100%, except for the last 6 words :) C++ is the very worst 
>> language I know in terms of badly thought out features, internal 
>> inconsistencies, ways to shoot one's feet off, and general ugliness. It 
>> will require _very_ tight control to avoid parts of the kernel going off 
>> in mutually incompatible directions.
>>
>> But I think that the control is there; and if C++ is introduced slowly, 
>> one feature at a time, it can be kept sane. And I think there is 
>> definitely a payoff to be won out of a switch.
>>     
>
> You are far too optimistic.  In the best case it'll end up with higher
> artificial entry barrier for contributors.  In the worst (and much more
> realistic) the crap will leak all over the tree in addition to the
> already present classes of bugs.
>
> "Everyone has his pet subset/extension" is a killer for anything that isn't
> done by 5-6 people, or, at least reviewed by 5-6 people who really can
> read through _all_ incoming code.  For something like Linux kernel...
> forget it.  It's far outside of the area where that would work.
>   
If it has 'template' or 'operator' in it, make sure some sane people 
look at it.

IIRC, when the gcc people discussed this, they raised the possibility of 
adding compiler switches to allow subsetting the language. But there's 
nothing real out there that I know of.

BTW, C++ could take over some of sparse's function:

int foo(user_ptr<struct fugly_ioctl_arg> arg)
{
    return bar(arg->field); // won't compile
    struct fugly_ioctl_arg s;
    if (arg->copy_from_user(&s))
        return -EFAULT;
    return bar(&s); // yes!
}

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

