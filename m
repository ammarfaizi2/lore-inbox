Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTI3Vfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbTI3Vfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:35:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59410 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261755AbTI3Vfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:35:36 -0400
Date: Tue, 30 Sep 2003 22:35:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Arun Sharma <arun.sharma@intel.com>, linux-kernel@vger.kernel.org,
       kevin.tian@intel.com, Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] incorrect use of sizeof() in ioctl definitions
Message-ID: <20030930223531.B10154@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Arun Sharma <arun.sharma@intel.com>, linux-kernel@vger.kernel.org,
	kevin.tian@intel.com, Matthew Wilcox <willy@debian.org>
References: <3F79ED60.2030207@intel.com> <20030930140805.0e3158e7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030930140805.0e3158e7.akpm@osdl.org>; from akpm@osdl.org on Tue, Sep 30, 2003 at 02:08:05PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 02:08:05PM -0700, Andrew Morton wrote:
> diff -puN drivers/video/aty/aty128fb.c~sizeof-in-ioctl-fix drivers/video/aty/aty128fb.c
> --- 25/drivers/video/aty/aty128fb.c~sizeof-in-ioctl-fix	Tue Sep 30 14:04:12 2003
> +++ 25-akpm/drivers/video/aty/aty128fb.c	Tue Sep 30 14:04:12 2003
> @@ -2041,9 +2041,9 @@ aty128fb_setcolreg(u_int regno, u_int re
>  #define ATY_MIRROR_CRT_ON	0x00000002
>  
>  /* out param: u32*	backlight value: 0 to 15 */
> -#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, sizeof(__u32*))
> +#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, __u32*)
>  /* in param: u32*	backlight value: 0 to 15 */
> -#define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, sizeof(__u32*))
> +#define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, __u32*)
>  
>  static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
>  			  u_long arg, struct fb_info *info)
> 
> 
> Matthew's conversion mainly converted things to size_t, but from the looks
> of it, __u32* is the right thing to use in this case, I think?

sizeof(__u32*) may not be sizeof(sizeof(__u32*)), so this would be an API
change...  Therefore, all these wrong entries need to change to size_t
(preferably with the real type following inside a comment so we don't
loose useful information.)

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
