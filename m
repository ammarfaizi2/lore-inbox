Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWJDVHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWJDVHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWJDVHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:07:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:30112 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751129AbWJDVHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:07:13 -0400
Date: Wed, 4 Oct 2006 17:06:40 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-ID: <20061004210640.GC3629@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003172511.GL3164@in.ibm.com> <20061003201340.afa7bfce.akpm@osdl.org> <20061004042850.GA27149@in.ibm.com> <45233B58.1050208@zytor.com> <20061004202244.GA3629@in.ibm.com> <45241945.2020105@zytor.com> <20061004204829.GB3629@in.ibm.com> <45241F2A.4080908@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45241F2A.4080908@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 01:52:58PM -0700, H. Peter Anvin wrote:
> Vivek Goyal wrote:
> >
> >memsz will contain the memory required to load the kernel image. And
> >probably should also include the memory used by kernel in initial boot
> >up code which is unaccounted and unbounded.
> >
> 
> Right, so that's a major project to produce.
> 

Eric is already doing that in his patch. He goes through vmlinux
headers to determine the memory to load the various segments and then
also takes into account the memory required by bootmem bitmap (128K)
and memory consumed by initial page tables (tools/build.c). We can
audit the code more closely for anything missed and can also include
some buffer amount to be safe. 

The only flip side would be that if down the line somebody changes
the initial bootup code, he shall have to also acccount it in
tools/build.c. Having said that, its not frequent that initial bootup
code changes.

Thanks
Vivek
