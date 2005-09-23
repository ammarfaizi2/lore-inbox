Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbVIWWzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVIWWzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 18:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVIWWzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 18:55:43 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:65499 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751338AbVIWWzm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 18:55:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rwKb18GkIG0dM0JzKP2HhpkDPw6csvfCiGCYWNmT9gc7lWy18wP/9kGFT8vih5X2uog7Vc1SfekAMknPHD+SBgPTAjuzsLP0UEyU3/VBJgKbHvN3uQmf5S9Jzuw405Xe5c7lYkumHWfcdOU32J6MzNhYQOLz+Pa7bBSKE+PtVhA=
Message-ID: <9a87484905092315556e9fc0bd@mail.gmail.com>
Date: Sat, 24 Sep 2005 00:55:41 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch] x86_64: fix tss limit (was Re: CAN-2005-0204 and 2.4)
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Horms <horms@debian.org>,
       Nikos Ntarmos <ntarmos@ceid.upatras.gr>, 329354@bugs.debian.org,
       Frederik Schueler <fs@lowpingbastards.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       ak@suse.de
In-Reply-To: <20050923151738.B12631@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1EI1tH-0006Yy-00@master.debian.org>
	 <20050922023025.GA20981@verge.net.au> <20050922200446.GB9472@dmt.cnet>
	 <20050923151738.B12631@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/05, Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
[snip]
>
> Fix the x86_64 TSS limit in TSS descriptor.
>
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
>
> --- linux-2.6.14-rc1/include/asm-x86_64/desc.h.orig     2005-09-12 20:12:09.000000000 -0700
> +++ linux-2.6.14-rc1/include/asm-x86_64/desc.h  2005-09-23 12:50:58.210135128 -0700
> @@ -129,7 +129,7 @@ static inline void set_tss_desc(unsigned
>  {
>         set_tssldt_descriptor(&cpu_gdt_table[cpu][GDT_ENTRY_TSS], (unsigned long)addr,
>                               DESC_TSS,
> -                             sizeof(struct tss_struct) - 1);
> +                             IO_BITMAP_OFFSET + IO_BITMAP_BYTES + 7);
>  }
>
[snip]

Is it just me, or would it be nice with a symbolic name for this "7" ?
For someone reading the code for the first time it seems to me that
it's non-obvious why the 7 is there, and why it's 7 exactely - a
define would make it clearer as I see it.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
