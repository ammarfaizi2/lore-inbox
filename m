Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUKSQuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUKSQuj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbUKSQud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:50:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:63655 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261500AbUKSQtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:49:42 -0500
Date: Fri, 19 Nov 2004 08:47:05 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Fabio Coatti <cova@ferrara.linux.it>, Pete Zaitcev <zaitcev@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.10-rc2-mm2 usb storage still oopses
Message-ID: <20041119164705.GB19407@kroah.com>
References: <200411182203.02176.cova@ferrara.linux.it> <20041118133557.72f3b369.akpm@osdl.org> <20041118135809.3314ce41@lembas.zaitcev.lan> <200411190042.41199.cova@ferrara.linux.it> <1100832070.15138.10.camel@chavez.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100832070.15138.10.camel@chavez.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 08:41:10PM -0600, Maneesh Soni wrote:
> > Nov 18 20:35:24 kefk kernel: Unable to handle kernel NULL pointer dereference 
> > at virtual address 00000050
> > Nov 18 20:35:24 kefk kernel:  printing eip:
> > Nov 18 20:35:24 kefk kernel: c0186e32
> > Nov 18 20:35:24 kefk kernel: *pde = 00000000
> > Nov 18 20:35:24 kefk kernel: Oops: 0000 [#1]
> > Nov 18 20:35:24 kefk kernel: PREEMPT SMP
> > Nov 18 20:35:24 kefk kernel: Modules linked in: nls_cp850 usb_storage md5 ipv6 
> > rfcomm l2cap bluetooth snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec
> > snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore 
> > ipt_REJECT iptable_filter ip_tables loop nls_utf8 ide_cd i2c_dev w83781d 
> > i2c_sensor i2c_isa i2c_i801 isofs zlib_inflate e1000 parport_pc ppa parport 
> > ehci_hcd usblp uhci_hcd genrtc
> > Nov 18 20:35:24 kefk kernel: CPU:    0
> > Nov 18 20:35:24 kefk kernel: EIP:    0060:[sysfs_hash_and_remove+174/241]    
> > Not tainted VLI
> > Nov 18 20:35:24 kefk kernel: EIP:    0060:[<c0186e32>]    Not tainted VLI
> > Nov 18 20:35:24 kefk kernel: EFLAGS: 00010246   (2.6.10-rc2-mm2)
> > Nov 18 20:35:24 kefk kernel: EIP is at sysfs_remove_dir+0x1d/0x10b
> > Nov 18 20:35:24 kefk kernel: eax: f6e79988   ebx: f6e79988   ecx: c18ff480   
> > edx: c1000000
> > Nov 18 20:35:24 kefk kernel: esi: f78b8b00   edi: 00000000   ebp: f7bd5d24   
> > esp: c1b7ddd8
> > Nov 18 20:35:24 kefk kernel: ds: 007b   es: 007b   ss: 0068
> 
> The following patch should avoid the sysfs_remove_dir() oops you are
> seeing while device removal. It anyway fixes the obvious error and is
> needed. But it will not make any change to the first error you are
> seeing while connecting the device.
> 
> Andrew, Greg, please include this.
> 
> Thanks
> Maneesh
> 
> 
> o Following patch avoids the sysfs_remove_dir() oops when it is passed
>   a kobject with NULL dentry.

Applied, thanks,

greg k-h
