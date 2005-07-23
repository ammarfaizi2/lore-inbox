Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVGWSpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVGWSpw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 14:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVGWSpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 14:45:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6554 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261447AbVGWSpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 14:45:50 -0400
Date: Sat, 23 Jul 2005 14:45:40 -0400
From: Neil Horman <nhorman@redhat.com>
To: =?iso-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>
Cc: Roger Heflin <rheflin@atipa.com>, "'Neil Horman'" <nhorman@redhat.com>,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Memory Management
Message-ID: <20050723184540.GA1670@hmsendeavour.rdu.redhat.com>
References: <EXCHG2003gbLYluLCTa000004d6@EXCHG2003.microtech-ks.com> <42E17FE7.3030205@latinsourcetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42E17FE7.3030205@latinsourcetech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 08:23:19PM -0300, Márcio Oliveira wrote:
<snip>
> >
> Roger, thanks for the information.
> 
>   I'm using Update 4 kernels (2.4.21-27.ELsmp - This kernel have some 
> mm / oom fixes) and don't have big problems when create large files, 
> plus the server is a 32-bit machine. 
> 
>   Neil said that the problem can be Low Memory and I think it too.
> 
>   I read the following message on the list:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112044530919567&w=4
> 
>   The problem seems like a I/O issue. Can I/O (like storage devices) 
> consume a large amount of low memory? Neil also said that the kernel is 
> trying to move lots of data to the disk and it's a module might require 
> such large memory. Somebody know how can I identify what is using Low 
> Memory on my system?
> 
The best way I can think to do that is take a look at /proc/slabinfo.  That will
likely give you a pointer to which area of code is eating up your memory.

>   The older questions in the message are:
> 
> The server has 16GB RAM and 16GB swap. When the OOM kill conditions 
> happens, the system has ~6GB RAM used, ~10GB RAM cached and 16GB free swap. 
> Is that indicate that the server can't allocate Low Memory and starts OOM 
> conditions? Because the High Memory is OK, right?
> 
Based on the sysrq-m info you posted it looks like due to fragmentation the
largest chunk of memory you can allocate is 2MB (perhaps less depending on
address space availability).  If you can build a test kernel to do a show_state
rather than a show_mem at the beginning of oom_kil, then you should be able to
tell who is trying to do an allocation that leads to kswapd calling
out_of_memory.

> Thanks to all!
> 
> Regards,
> Márcio
> 
> 

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
