Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266078AbUGILnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266078AbUGILnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266079AbUGILnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:43:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30643 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266078AbUGILni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:43:38 -0400
Date: Fri, 9 Jul 2004 13:43:15 +0200
From: Jens Axboe <axboe@suse.de>
To: =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/page_alloc.c:796 (2.6.7-mm7)
Message-ID: <20040709114315.GN10114@suse.de>
References: <1089372821.3700.7.camel@juerg-p4.bitron.ch> <20040709114205.GM10114@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040709114205.GM10114@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09 2004, Jens Axboe wrote:
> On Fri, Jul 09 2004, Jürg Billeter wrote:
> > Just built and installed 2.6.7-mm7 and on startup I get the following
> > BUG message. config and lspci output to be found below. 2.6.7-mm6 didn't
> > have this problem on my computer. I can provide more information if
> > requested. Please CC me on reply.
> > 
> > kernel BUG at mm/page_alloc.c:796!
> > invalid operand: 0000 [#1]
> > PREEMPT
> > Modules linked in: ds pcmcia_core freq_table nfs lockd sunrpc ohci_hcd
> > e100 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc
> > snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ehci_hcd
> > uhci_hcd ipt_REJECT ipt_LOG ipt_MASQUERADE ip_nat_irc ip_nat_ftp
> > iptable_nat
> > ipt_state ip_conntrack_irc ip_conntrack_ftp ip_conntrack iptable_filter
> > ip_tables ext3 jbd mbcache
> > CPU:    0
> > EIP:    0060:[<c0135581>]    Not tainted VLI
> > EFLAGS: 00010256   (2.6.7-mm7-upkg1)
> > EIP is at __free_pages+0x31/0x40
> > eax: 00000000   ebx: f7faf2c0   ecx: c16e3d00   edx: 00000000
> > esi: f7fb2900   edi: f7fb28c0   ebp: 00000001   esp: f799fd70
> > ds: 007b   es: 007b   ss: 0068
> > Process hald (pid: 2748, threadinfo=f799e000 task=f7891190)
> > Stack: c015276d fffffff2 f7c02a64 00000000 f799fe18 f7c02a64 c0246a5a
> > f799fea4
> >        00007425 c0249dbe 00000020 f7fb2900 f7feda80 f7c1097c 00000246
> > 00000000
> >        00000020 00000000 00000000 00000000 00000000 00000000 00000000
> > 00000000
> > Call Trace:
> >  [<c015276d>] bio_uncopy_user+0x5d/0x90
> >  [<c0246a5a>] blk_rq_unmap_user+0x3a/0x40
> >  [<c0249dbe>] sg_io+0x23e/0x290
> >  [<c024a260>] scsi_cmd_ioctl+0x1e0/0x390
> 
> You're not using 2.6.7-mm7 virgin, it has no BUG() at that line. Care to
> fill in what code is around line 796 in mm/page_alloc.c?

Nevermind, I gather it's put_page_testzero(). Hmm double free, I'll take
a look.

-- 
Jens Axboe

