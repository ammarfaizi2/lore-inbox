Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUJLOAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUJLOAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUJLOAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:00:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51169 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263736AbUJLOAR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:00:17 -0400
Date: Tue, 12 Oct 2004 15:00:16 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4 Oops in s_show / prune_dcache
Message-ID: <20041012140016.GY23987@parcelfarce.linux.theplanet.co.uk>
References: <20041012122950.GA24892@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012122950.GA24892@m.safari.iki.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 03:29:50PM +0300, Sami Farin wrote:
> CPU:    0
> EIP:    0060:[<c013e798>]    Not tainted VLI
> EFLAGS: 00210006   (2.6.9-rc4) 
> EIP is at s_show+0x54/0x1b4
> eax: c0368f15   ebx: c0368f15   ecx: 14000008   edx: 0000000a
> esi: c132c860   edi: c132c874   ebp: ce5d8f2c   esp: ce5d8f00
> ds: 007b   es: 007b   ss: 0068
> Process ss (pid: 20558, threadinfo=ce5d8000 task=c3787450)
> Stack: c053da20 c132c860 00000000 c037f356 00000000 c132c7fc c132c7fc 00000008 
>        00000000 000008b2 000056f4 ce5d8f6c c0169dba c053da20 c132c860 00000000 
>        cf4fea60 ce5d8fb0 c053da38 ce5d8f64 000002ed c053da38 0000000e 00000035 

s_show() from mm/slab.c; looks like cachep->lists.slabs_full.next == 0x14000008
which is certainly not a kernel pointer...
