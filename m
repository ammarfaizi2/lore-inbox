Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161798AbWHJNNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161798AbWHJNNv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161796AbWHJNNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:13:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:6060 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161798AbWHJNNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:13:49 -0400
Date: Thu, 10 Aug 2006 09:13:23 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060810131323.GB9888@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060804210826.GE16231@redhat.com> <m164h8p50c.fsf@ebiederm.dsl.xmission.com> <20060804234327.GF16231@redhat.com> <m1hd0rmaje.fsf@ebiederm.dsl.xmission.com> <20060807174439.GJ16231@redhat.com> <m17j1kctb8.fsf@ebiederm.dsl.xmission.com> <20060807235727.GM16231@redhat.com> <m1ejvrakhq.fsf@ebiederm.dsl.xmission.com> <20060809200642.GD7861@redhat.com> <m1u04l2kaz.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u04l2kaz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 12:09:56AM -0600, Eric W. Biederman wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> >> Looking at my build it appears bytes_out is being placed in the .bss.
> >> A little odd since it is zero initialized but no big deal.
> >> Could you confirm that bytes_out is being placed in the .bss section 
> >> by inspecting arch/x86_64/boot/compresssed/misc.o and
> >> arch/x86_64/boot_compressed/vmlinux.   "readelf -a $file" and then
> >> looking up the section number and looking at the section table to see
> >> which section it is was my technique.
> >> 
> >> If bytes_out is in the .bss for you then I suspect something is not
> >> correctly zeroing the .bss.  Or else the .bss is being stomped.
> >> 
> >> I'm not certain how rep stosb can be done wrong but some bad pointer
> >> math could have done it.
> >> 
> >> Eric
> >
> > It seems Vivek came up with a solution that works.  He sent it to me this
> > morning.  We tested a bunch of machines and things seem to work now.  It
> > looks like it mimics the i386 behaviour now.
> 
> Yes, this looks right.  It looks like I forgot to make this change when
> the logic from i386 was adopted to x86_64, ages ago.
> 
> This is exactly the place in the code I would have expected a bug
> from the symptoms you were seeing.
> 
> Thanks all I will include this in my version of the patches.

Apart from this I think something is still off on x86_64. I have not
been able to make kdump work on x86_64. Second kernel simply hangs.
Two different machines are showing different results.

- On one machine, it seems to be stuck somewhere in decompress_kernel().
  Serial console is not behaving properly even with earlyprintk(). Somehow
  I feel it is some bss corruption even after my changes.

- Other machines seems to be going till start_kernel() and even after
  that (No messages on the console, all serial debugging) and then
  either it hangs or jumps back to BIOS.

Will look more into it.

Thanks
Vivek
 
