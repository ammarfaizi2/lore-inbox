Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVFRA1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVFRA1L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 20:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVFRA1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 20:27:11 -0400
Received: from fmr22.intel.com ([143.183.121.14]:1439 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261636AbVFRA1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 20:27:05 -0400
Date: Fri, 17 Jun 2005 17:25:57 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Simon Richard Grint <rgrint@tall.compsoc.man.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: arch/i386/boot/video.S hang
Message-ID: <20050617172557.A25812@unix-os.sc.intel.com>
References: <20050615220554.GA1911@srg.demon.co.uk> <20050616103340.A4951@unix-os.sc.intel.com> <20050616175851.GA22103@mrtall.compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050616175851.GA22103@mrtall.compsoc.man.ac.uk>; from rgrint@tall.compsoc.man.ac.uk on Thu, Jun 16, 2005 at 06:58:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 06:58:51PM +0100, Simon Richard Grint wrote:
> On Thu, Jun 16, 2005 at 10:33:41AM -0700, Venkatesh Pallipadi wrote:
> > What boot loader are you using. grub/lilo?
> 
> The same thing happens with either grub or lilo, but I'm using grub at 
> present
>  
> > Does it work with CONFIG_VIDEO_SELECT disabled in your kernel CONFIG?
> 
> It works fine if CONFIG_VIDEO_SELECT is disabled.  Even with 
> CONFIG_VIDEO_SELECT enabled, the problem only arises if I pass a vga= 
> parameter to the kernel
> 
> Thanks for your help
> 

This one continues to be mysterious.

One reason I could think of: VBE call 4f15:0s is storing more than 128 bytes on this platform. With the base address at 0x440, it can write much longer, without affecting anything else in zero page. But, at 0x140 it overwrites some other fields.

But, that doesn't explain why it only fails when vga=<num> is passed. For the above theory it should fail whenever VIDEO_SELECT is enabled.

Can you try some other address higher than 0x440 and less than 0x600 for and see whether it works? Or you can also try and print complete boot_params[] at some place in arch/i386/kernel/setup.c:setup_arch() in the case where it runs fine (with 0x440) and send me the log.

Thanks,
Venki
