Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWDGPXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWDGPXX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWDGPXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:23:23 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:25529 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964802AbWDGPXX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:23:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ISL21nZX9jyjdl/rUgfbHCeHwFnAAxFY7Hi1bvKkAyumzrkENBVoNwul6nKuR9GLYG+eL5Z6GwU1jW8E1ZPqRAatqz2LtPgS5idsr88IvpQ0rDbw9icF9UFOaQxpmvt4NpDkcfg+BcCnHBl+WYM/kQh+OxHeCihBJRu61mEswx0=
Message-ID: <632b79000604070823s7f495d5ci416c9cef63ba11b@mail.gmail.com>
Date: Fri, 7 Apr 2006 10:23:22 -0500
From: "Don Dupuis" <dondster@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Oops at __bio_clone with 2.6.16-rc6 anyone??????
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060328113150.0acf2b60.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <632b79000603271917h4104049dh9b6b8251feac0437@mail.gmail.com>
	 <20060327200134.7369c7f8.akpm@osdl.org>
	 <632b79000603280735w1908684djab2798c3f35cfebb@mail.gmail.com>
	 <20060328113150.0acf2b60.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/06, Andrew Morton <akpm@osdl.org> wrote:
> "Don Dupuis" <dondster@gmail.com> wrote:
> >
> > Yes it does also happen on 2.6.16
> >
>
> (please don't top-post).
>
> >
> > On 3/27/06, Andrew Morton <akpm@osdl.org> wrote:
> > > "Don Dupuis" <dondster@gmail.com> wrote:
> > > >
> > > > I will get this oops during reboots. It doesn't happen everytime, but
> > > > It happens on this system at least 1 to 2 out of 10 reboots. The
> > > > machine is a Dell Powervault 745n. Here is the oops output:
> > > >
> > > > Mar 20 22:27:49 (none) kernel: EXT3-fs: mounted filesystem with
> > > > journal data mode.
> > > > Mar 20 22:27:49 (none) kernel: Unable to handle kernel paging request
> > > > at virtual address f8000000
> > > > Mar 20 22:27:49 (none) kernel: printing eip:
> > > > Mar 20 22:27:49 (none) kernel: c0156db1
> > > > Mar 20 22:27:49 (none) kernel: *pde = 00000000
> > > > Mar 20 22:27:49 (none) kernel: Oops: 0000 [#1]
> > > > Mar 20 22:27:49 (none) kernel: SMP
> > > > Mar 20 22:27:49 (none) kernel: Modules linked in:
> > > > Mar 20 22:27:49 (none) kernel: CPU: 0
> > > > Mar 20 22:27:50 (none) kernel: EIP: 0060:[<c0156db1>] Not tainted VLI
> > > > Mar 20 22:27:50 (none) kernel: EFLAGS: 00010206 (2.6.16-rc6 #3)
> > > > Mar 20 22:27:50 (none) kernel: EIP is at __bio_clone+0x29/0x9b
> > > > Mar 20 22:27:50 (none) kernel: eax: 00000300 ebx: f68f3700 ecx:
> > > > 00000002 edx: f7fffc80
> > > > Mar 20 22:27:50 (none) kernel: esi: f8000000 edi: f7f3d378 ebp:
> > > > f7c44b98 esp: f7c44b84
> > > > Mar 20 22:27:50 (none) kernel: ds: 007b es: 007b ss: 0068
> > > > Mar 20 22:27:50 (none) kernel: Process ldconfig (pid: 581,
> > > > threadinfo=f7c44000 task=f7db9070)
> > > > Mar 20 22:27:50 (none) kernel: Stack: <0>f7d3b458 f68f3700 f68f3700
> > > > f7fffc80 f65b4640 f7c44ba8 c0156e4e f7d4c664
> > > > Mar 20 22:27:50 (none) kernel: 00000010 f7c44bf4 c02c8346
> > > > 00000080 00000000 00000e00 c0154b1b 00000000
> > > > Mar 20 22:27:50 (none) kernel: 0000007f 00000080 f7fffc80
> > > > f7d4a740 f7d44400 f7fffc80 f7d3b458 c01579c3
> > > > Mar 20 22:27:50 (none) kernel: Call Trace:
> > > > Mar 20 22:27:50 (none) kernel: [<c0104260>] show_stack_log_lvl+0xa8/0xb0
> > > > Mar 20 22:27:50 (none) kernel: [<c0104397>] show_registers+0x109/0x171
> > > > Mar 20 22:27:50 (none) kernel: [<c010456e>] die+0xfb/0x16f
> > > > Mar 20 22:27:50 (none) kernel: [<c0114750>] do_page_fault+0x359/0x48b
> > > > Mar 20 22:27:50 (none) kernel: [<c0103f0b>] error_code+0x4f/0x54
> > > > Mar 20 22:27:50 (none) kernel: [<c0156e4e>] bio_clone+0x2b/0x31
> > > > Mar 20 22:27:50 (none) kernel: [<c02c8346>] make_request+0x208/0x3d4
> > > > Mar 20 22:27:50 (none) kernel: [<c02c8211>] make_request+0xd3/0x3d4
> > > > Mar 20 22:27:50 (none) kernel: [<c01d3b68>] generic_make_request+0xf5/0x105
> > > > Mar 20 22:27:50 (none) kernel: [<c01d3c19>] submit_bio+0xa1/0xa9
> > > > Mar 20 22:27:50 (none) kernel: [<c0170453>] mpage_bio_submit+0x1c/0x21
> > > > Mar 20 22:27:50 (none) kernel: [<c017085c>] do_mpage_readpage+0x30b/0x44d
> > > > Mar 20 22:27:50 (none) kernel: [<c0170a2b>] mpage_readpages+0x8d/0xf1
> > > > Mar 20 22:27:50 (none) kernel: [<c01a7ee7>] ext3_readpages+0x14/0x16
> > > > Mar 20 22:27:50 (none) kernel: [<c013e92f>] read_pages+0x26/0xc6
>
> Jens points out that the "dm: bio split bvec fix" patch which went into
> 2.6.16.1 might fix this.  Can you try it please?
>
Sorry about the late response. I have been out of town for a week and
didn't get to try it until last night. It STILL HAPPENS with 2.6.16.1

Don
