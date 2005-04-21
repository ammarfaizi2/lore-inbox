Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVDUQ1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVDUQ1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 12:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVDUQ1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 12:27:17 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:13578 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261520AbVDUQ05 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 12:26:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sUlJAfyaVed2VgSiSK5TJOcblsZ/mhNmVGsFohhkUl5/IlDqO5tv3x79s87Qt+G6PHnQpo18HXOPG/LPH173liNMJ0dIKt+PiU8sbbARJxI8IpphdbK8a3KQZ2guGEf6+neoCHbYwUPRJ5MT4BjPfr5vg1TiFMClP2XDXguyQJ8=
Message-ID: <40f323d0050421091625659f16@mail.gmail.com>
Date: Thu, 21 Apr 2005 18:16:48 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: [patch] minor syctl fix in vsyscall_init
Cc: Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050413182913.GE50241@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504131745.j3DHjIVE017612@snoqualmie.dp.intel.com>
	 <20050413182913.GE50241@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Apr 2005 20:29:13 +0200, Andi Kleen <ak@muc.de> wrote:
> On Wed, Apr 13, 2005 at 10:45:18AM -0700, Matt Tolentino wrote:
> >
> > Andi,
> >
> > If CONFIG_SYCTL is not enabled then the x86-64 tree
> > fails to build due to use of a symbol that is not
> > compiled in.  Don't bother compiling in the sysctl
> > register call if not building with sysctl.
> 
> Thanks. Actually it would be better to fix up sysctl.h
> to define dummy functions in this case. I thought it did
> that already in fact....
> 

Yes it already does that, but kernel_root_table2 is not defined when
CONFIG_SYSCTL is not set (the problem isn't with
register_sysctl_table).

With 2.6.12-rc3:
arch/x86_64/kernel/vsyscall.c: In function `vsyscall_init':
arch/x86_64/kernel/vsyscall.c:221: error: `kernel_root_table2'
undeclared (first use in this function)

If you prefer, i can send a patch which sets kernel_table_root2 to
NULL when CONFIG_SYSCTL is not set. Or maybe there a better fix (btw
is sysctl_vsyscall needed when !CONFIG_SYSCTL ?).

regards,

Benoit
