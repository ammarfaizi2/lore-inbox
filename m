Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264262AbUFDCx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbUFDCx1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 22:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUFDCx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 22:53:27 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:3524 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264262AbUFDCxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 22:53:25 -0400
Date: Thu, 3 Jun 2004 19:58:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@muc.de, ashok.raj@intel.com,
       hch@infradead.org, jbarnes@sgi.com, joe.korty@ccur.com,
       manfred@colorfullife.com, colpatch@us.ibm.com, mikpe@csd.uu.se,
       nickpiggin@yahoo.com.au, rusty@rustcorp.com.au, Simon.Derr@bull.net,
       wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603195807.53d7d41c.pj@sgi.com>
In-Reply-To: <20040603172547.2880eeb0.akpm@osdl.org>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<20040603170725.4b3f8b34.akpm@osdl.org>
	<20040603172547.2880eeb0.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Although for some reason your patches shrink my sparc64 build from
> 
> 	   text    data     bss     dec     hex filename
> 	3508730  895000  302656 4706386  47d052 vmlinux
> to	3507586  895080  302656 4705322  47cc2a vmlinux

Yes - these are typical of the kernel text space reductions that
I am seeing as well.  Various little tweaks here and there, with
a careful eye to changes in the output of "nm -S".

The one exception being ia64, where I saved an additional
15000 or so kernel text bytes by uninlining find_next_bit().

Other arch's might want to try that same optimization.  I ran
out of gas, and lacked the resources, to persue that.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
