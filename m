Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318077AbSGWOvp>; Tue, 23 Jul 2002 10:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318079AbSGWOvp>; Tue, 23 Jul 2002 10:51:45 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:60151 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318077AbSGWOvo>; Tue, 23 Jul 2002 10:51:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: axel@hh59.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.27: Software Suspend failure / JFS errors
Date: Tue, 23 Jul 2002 09:54:35 -0500
X-Mailer: KMail [version 1.4]
Cc: jfs-discussion@www-124.southbury.usf.ibm.com
References: <20020721122932.GA23552@neon.hh59.org> <20020721144212.GA23767@neon.hh59.org>
In-Reply-To: <20020721144212.GA23767@neon.hh59.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207230954.36039.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 July 2002 09:42, axel@hh59.org wrote:
> This oops occurred during build of gcc..
> Kernel 2.4.19-rc2-ac2.
> About the same happens with 2.5.27. I will post an oops of jfsCommit
> of 2.5.27 as soon as I get one.

I just built gcc on 2.4.19-rc3 + latest JFS and didn't have a problem.  
I'll repeat it on 2.4.19-rc2-ac2, but there shouldn't be more than a 
comsmetic difference in the JFS code.  I haven't tried 2.5.27 yet.

> ksymoops 2.4.5 on i686 2.4.19-rc2-ac2.  Options used
  --- ksymoops output deleted ---
>
> Trace; c0190800 <txUpdateMap+2c0/2d0>
> Trace; c0118486 <schedule+1a6/310>
> Trace; c0190fb3 <txLazyCommit+23/f0>
> Trace; c01911db <jfs_lazycommit+15b/250>
> Trace; c0105000 <_stext+0/0>
> Trace; c010739e <kernel_thread+2e/40>
> Trace; c0191080 <jfs_lazycommit+0/250>
>
> Code;  c018b565 <hold_metapage+15/70>
> 00000000 <_EIP>:
> Code;  c018b565 <hold_metapage+15/70>   <=====
>    0:   ff 41 18                  incl   0x18(%ecx)   <=====
> Code;  c018b568 <hold_metapage+18/70>
>    3:   85 d2                     test   %edx,%edx

It looks like tlck->mp was null in txUpdateMap, and hold_metapage was 
called with the null pointer.  I haven't seen this before, but I am 
looking at the code to see if I can figure out how it may have 
happened.  I'm guessing that you have built the kernel without 
CONFIG_JFS_DEBUG set.  If I'm right, can you set this before you try to 
stress JFS again.  It may help find the problem earlier.

> Regards,
> Axel Siebenwirth

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

