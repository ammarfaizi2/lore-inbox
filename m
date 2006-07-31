Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWGaUZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWGaUZz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWGaUZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:25:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:64642 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932520AbWGaUZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:25:54 -0400
Date: Mon, 31 Jul 2006 16:25:20 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Horms <horms@verge.net.au>,
       Linda Wang <lwang@redhat.com>, linux-kernel@vger.kernel.org,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060731202520.GB11790@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060705222448.GC992@in.ibm.com> <aec7e5c30607051932r49bbcc7eh2c190daa06859dcc@mail.gmail.com> <20060706081520.GB28225@host0.dyn.jankratochvil.net> <aec7e5c30607070147g657d2624qa93a145dd4515484@mail.gmail.com> <20060707133518.GA15810@in.ibm.com> <20060707143519.GB13097@host0.dyn.jankratochvil.net> <20060710233219.GF16215@in.ibm.com> <20060711010815.GB1021@host0.dyn.jankratochvil.net> <m1d5c92yv4.fsf@ebiederm.dsl.xmission.com> <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 10:19:04AM -0600, Eric W. Biederman wrote:
> 
> I have spent some time and have gotten my relocatable kernel patches
> working against the latest kernels.  I intend to push this upstream
> shortly.
> 
> Could all of the people who care take a look and test this out
> to make certain that it doesn't just work on my test box?
> 
Hi Eric,

Currently I am testing your patches on i386. With CONFIG_RELOCATABLE=y
kernel boots fine and kexec also works.

But my kernel hangs on kexec on panic case. It hangs early in 
decompress_kernel(). Kernel hangs at following condition.

+       if (((u32)output - CONFIG_PHYSICAL_START) & 0x3fffff)
+               error("Destination address not 4M aligned");

I have reserved 64MB at 16M and kernel is loaded at 16M. 

I had expected that I would get "Destination address not 4M aligned" on
serial console but did not happen. Had to put outb() to get to this point.

Will look more into it.

Thanks
Vivek 
