Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVAUAMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVAUAMa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVAUAMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:12:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:14816 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261546AbVAUALL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:11:11 -0500
Date: Thu, 20 Jan 2005 16:10:41 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>, ak@suse.de,
       Greg KH <greg@kroah.com>, tiwai@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, VANDROVE@vc.cvut.cz
Subject: Re: security hook missing in compat ioctl in 2.6.11-rc1-mm2
Message-ID: <20050120161040.N24171@build.pdx.osdl.net>
References: <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com> <20050112214326.GB14703@wotan.suse.de> <20050112225230.GA14590@kroah.com> <20050112151049.7473db7d.akpm@osdl.org> <20050119213818.55b14bb0.akpm@osdl.org> <20050121000935.GA341@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050121000935.GA341@mellanox.co.il>; from mst@mellanox.co.il on Fri, Jan 21, 2005 at 02:09:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael S. Tsirkin (mst@mellanox.co.il) wrote:
> Hi!
> Security hook seems to be missing before compat_ioctl in mm2.
> And, it would be nice to avoid calling it twice on some paths.
> 
> Chris Wright's patch addressed this in the most elegant way I think,
> by adding vfs_ioctl.
> 
> Accordingly, this change:
> 
> @@ -468,6 +496,11 @@ asmlinkage long compat_sys_ioctl(unsigne
>  
>   found_handler:
>  	if (t->handler) {
> +		/* RED-PEN how should LSM module know it's handling 32bit? */
> +		error = security_file_ioctl(filp, cmd, arg);
> +		if (error)
> +			goto out_fput;
> +
>  		lock_kernel();
>  		error = t->handler(fd, cmd, arg, filp);
>  		unlock_kernel();
> 
>  from Andy's "some fixes" patch wont be needed.
> 
> Chris - are you planning to update your patch to -rc1-mm2?
> I'd like to see this addressed, after this I believe logically
> we'll get everything right, then I have a couple of small
> cosmetic patches, and I believe we'll be set.

Yes, Andrew asked me to wait until mm2 came out, so I'll rediff and send
shortly.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
