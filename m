Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135489AbRDWR53>; Mon, 23 Apr 2001 13:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135491AbRDWR5U>; Mon, 23 Apr 2001 13:57:20 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:46226 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135489AbRDWR5O>; Mon, 23 Apr 2001 13:57:14 -0400
Date: Mon, 23 Apr 2001 19:57:12 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>, mythos <papadako@csd.uoc.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.3 with agcc
Message-ID: <20010423195712.T682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010423154821.A26340@flint.arm.linux.org.uk> <Pine.GSO.4.33.0104231611090.15682-100000@iridanos.csd.uch.gr> <20010423154821.A26340@flint.arm.linux.org.uk> <24644.988041173@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <24644.988041173@redhat.com>; from dwmw2@infradead.org on Mon, Apr 23, 2001 at 04:52:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 04:52:53PM +0100, David Woodhouse wrote:
> RCS file: /inst/cvs/linux/include/asm-i386/bugs.h,v
> retrieving revision 1.2.2.16
> diff -u -r1.2.2.16 bugs.h
> --- include/asm/bugs.h	2001/01/18 13:56:53	1.2.2.16
> +++ include/asm/bugs.h	2001/04/23 15:45:28
> @@ -80,8 +80,10 @@
>  	 * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
>  	 */
>  	if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
> -		extern void __buggy_fxsr_alignment(void);
> -		__buggy_fxsr_alignment();
> +		printk(KERN_EMERG "ERROR: FXSAVE data are not 16-byte aligned in task_struct.\n");
> +		printk(KERN_EMERG "This is usually caused by a buggy compiler (perhaps pgcc?)\n");
> +		printk(KERN_EMERG "Cannot continue.\n");
> +		for (;;) ;
replace this with panic() please. Even machines, which reboot on
panic will reboot over and over again here, which surely someone
will notice ;-)
>  	}
>  	if (cpu_has_fxsr) {
>  		printk(KERN_INFO "Enabling fast FPU save and restore... ");

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
