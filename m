Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267475AbRGMNdu>; Fri, 13 Jul 2001 09:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267481AbRGMNdk>; Fri, 13 Jul 2001 09:33:40 -0400
Received: from ns.suse.de ([213.95.15.193]:41226 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267475AbRGMNd2>;
	Fri, 13 Jul 2001 09:33:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] vtund broken by tun driver changes in 2.4.6
In-Reply-To: <009601c106ff$a3cb2070$6baaa8c0@kevin.suse.lists.linux.kernel>
In-Reply-To: <Pine.LNX.4.33.0107070058350.29490-100000@mackman.net.suse.lists.linux.kernel> <009601c106ff$a3cb2070$6baaa8c0@kevin.suse.lists.linux.kernel>
Message-Id: <20010713133329.DDCEB19A57@lamarr.suse.de>
Date: Fri, 13 Jul 2001 15:33:29 +0200 (CEST)
From: jreuter@suse.de (Joerg Reuter)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Recompile your VTUND daemon with the new kernel headers (and also updated to
>2.5 vtund, it has some small patches) and you will be fine.

Probably not:

        #define TUNSETNOCSUM  _IOW('T', 200, int)
        #define TUNSETDEBUG   _IOW('T', 201, int)
        #define TUNSETIFF     _IOW('T', 202, int)
        #define TUNSETPERSIST _IOW('T', 203, int)
        #define TUNSETOWNER   _IOW('T', 204, int)

Which is (apart from some extensions) the same as it ever was. However 
adding a

	printk(KERN_INFO "tun_chr_ioctl() called with cmd=%4.4X
		(TUNSETIFF=%4.4X, tun is%s set)\n",
		cmd, TUNSETIFF, tun? "":" not");

in tun_chr_ioctl() reveals:

	tun_chr_ioctl() called with cmd=54CA (TUNSETIFF=400454CA, tun is not set)

Now, where does the 0x400454CA come from? What happened to the _IOW()
macros? (Tested with 2.4.6 vanilla kernel sources and gcc-2.95.3)

And BTW, you shouldn't include kernel headers from user space programs,
should you.

Regards,
-- 
Joerg Reuter                                    http://yaina.de/jreuter
And I make my way to where the warm scent of soil fills the evening air. 
Everything is waiting quietly out there....                 (Anne Clark)
