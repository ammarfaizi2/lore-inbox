Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268204AbUHTPU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268204AbUHTPU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUHTPSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:18:10 -0400
Received: from herkules.viasys.com ([194.100.28.129]:29114 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S268230AbUHTPQ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:16:29 -0400
Date: Fri, 20 Aug 2004 18:16:22 +0300
From: Ville Herva <vherva@viasys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: petr@vandrovec.name, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-ID: <20040820151621.GJ23741@viasys.com>
Reply-To: vherva@viasys.com
References: <20040820104230.GH23741@viasys.com> <20040820035142.3bcdb1cb.akpm@osdl.org> <20040820131825.GI23741@viasys.com> <20040820144304.GF8307@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820144304.GF8307@viasys.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 05:43:04PM +0300, you [Ville Herva] wrote:
> On Fri, Aug 20, 2004 at 04:18:25PM +0300, you [Ville Herva] wrote:
> > 
> > I just noticed I had missed get_user_pages-handle-VM_IO.patch - I'll try
> > backing that out first. I'll report back if I find anything interesting 
> > with different patch mixtures.
> 
> Well, I just tried 2.6.8.1-mm2 minus get_user_pages-handle-VM_IO.patch but
> that didn't help with the "cannot allocate memory" problem. Curiously, I
> didn't get the "get_user_pages() returns -EFAULT" warning with this kernel.
> 
> I just put get_user_pages-handle-VM_IO.patch back and reverted
> dev-mem-restriction-patch.patch - I'll report back when it has compiled. 

Ok, 2.6.8.1-mm2 minus dev-mem-restriction-patch.patch fixes the "cannot
allocate memory" problem. 

With this kernel I still get the 

--8<-----------------------------------------------------------------------
vmmon: Your kernel is br0ken. get_user_pages(current, current->mm, b7dd1000, 1, 1, 0, &page, NULL) returned -14.
vmmon: I'll try accessing page tables directly, but you should know that your
vmmon: kernel is br0ken and you should uninstall all additional patches you vmmon: have installed!
vmmon: FYI, copy_from_user(b7dd1000) returns 0 (if not 0 maybe your kernel is not br0ken)
--8<-----------------------------------------------------------------------

warning, but vmware appears to work now (well apart from altgr not working,
but that has been broken since 2.4 -> 2.6 transition.)

I'm still not 100% which of the patches causes that get_user_pages()
warning.


-- v -- 

v@iki.fi

