Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTE3Ipv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 04:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTE3Ipv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 04:45:51 -0400
Received: from boden.synopsys.com ([204.176.20.19]:49150 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S263458AbTE3Ipu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 04:45:50 -0400
Date: Fri, 30 May 2003 10:59:01 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: "David S. Miller" <davem@redhat.com>
Cc: scrosby@cs.rice.edu, linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
Message-ID: <20030530085901.GB11885@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	scrosby@cs.rice.edu, linux-kernel@vger.kernel.org
References: <oydbrxlbi2o.fsf@bert.cs.rice.edu> <1054267067.2713.3.camel@rth.ninka.net> <oyd3cixc9ev.fsf@bert.cs.rice.edu> <20030529.232440.122068039.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529.232440.122068039.davem@redhat.com>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller, Fri, May 30, 2003 08:24:40 +0200:
>    From: Scott A Crosby <scrosby@cs.rice.edu>
>    Date: 30 May 2003 00:04:24 -0500
>    
>    Have you seen the current dcache function?
>    
>    /* Linux dcache */
>    #define HASH_3(hi,ho,c)  ho=(hi + (c << 4) + (c >> 4)) * 11
>    
> Awesome, moving the Jenkins will actually save us some
> cycles :-)

    static
    int hash_3(int hi, int c)
    {
	return (hi + (c << 4) + (c >> 4)) * 11;
    }

gcc-3.2.1 -O2 -march=pentium

    hash_3:
	    pushl	%ebp
	    movl	%esp, %ebp
	    movl	12(%ebp), %eax
	    movl	8(%ebp), %ecx
	    movl	%eax, %edx
	    popl	%ebp
	    sall	$4, %edx
	    sarl	$4, %eax
	    addl	%ecx, %edx
	    addl	%eax, %edx
	    leal	(%edx,%edx,4), %eax
	    leal	(%edx,%eax,2), %eax
	    ret

It is not guaranteed to be this way on all architectures, of course.
But still - no multiplications.

