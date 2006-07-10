Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWGJOXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWGJOXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWGJOXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:23:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:12242 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030411AbWGJOXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:23:19 -0400
Date: Mon, 10 Jul 2006 09:22:40 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       Kirill Korotaev <dev@openvz.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6: kernel/sysctl.c: PROC_FS=n compile error
Message-ID: <20060710142240.GB28688@sergelap.austin.ibm.com>
References: <20060703030355.420c7155.akpm@osdl.org> <20060708202011.GD5020@stusta.de> <20060709185228.GB14100@sergelap.austin.ibm.com> <20060709233321.GY13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709233321.GY13938@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adrian Bunk (bunk@stusta.de):
> On Sun, Jul 09, 2006 at 01:52:28PM -0500, Serge E. Hallyn wrote:
> CONFIG_EMBEDDED=y is required for CONFIG_PROC_FS=n, but apart from this 
> there was no problem for me.

ok, that's what I finally ended up trying.  Tried other things first as
I wasn't sure 'embedded' and 's390' would mix well  :)  but it went
fine.

> Did you observe any other problems (besides a small ATM compile error 
> Dave has just merged my patch for) with CONFIG_PROC_FS=n?

Only in s390-specific drivers:

kernel/built-in.o(.text+0x198c0): In function `get_signal_to_deliver':
: undefined reference to `arch_vma_name'
drivers/s390/built-in.o(.text+0x5ed8c): In function
`zfcp_ccw_set_online':
: undefined reference to `statistic_create'
drivers/s390/built-in.o(.text+0x5ee20): In function
`zfcp_ccw_set_online':
: undefined reference to `statistic_remove'
drivers/s390/built-in.o(.text+0x5eef0): In function
`zfcp_ccw_set_offline':
: undefined reference to `statistic_remove'
drivers/s390/built-in.o(.text+0x66a02): In function `zfcp_erp_thread':
: undefined reference to `statistic_add'
drivers/s390/built-in.o(.text+0x66a96): In function `zfcp_erp_thread':
: undefined reference to `statistic_add'
drivers/s390/built-in.o(.text+0x68e08): In function
`zfcp_qdio_response_handler':
: undefined reference to `statistic_add'
drivers/s390/built-in.o(.text+0x690aa): In function
`zfcp_qdio_sbals_from_sg':
: undefined reference to `statistic_add'
drivers/s390/built-in.o(.text+0x693a6): In function
`zfcp_qdio_sbals_from_scsicmnd':
: undefined reference to `statistic_add'
drivers/s390/built-in.o(.text+0x69690): more undefined references to
`statistic_add' follow
make: *** [.tmp_vmlinux1] Error 1

These might be fixed in 2.6.18-rc1-mm1, haven't had a chance to check.

thanks,
-serge
