Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTHGPzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270321AbTHGPzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:55:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26386 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263861AbTHGPz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:55:26 -0400
Date: Thu, 7 Aug 2003 16:55:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>
Subject: Re: [patch] v4l: sysfs'ify videodev
Message-ID: <20030807165519.A32452@flint.arm.linux.org.uk>
Mail-Followup-To: Gerd Knorr <kraxel@bytesex.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>
References: <20030807154342.GA818@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030807154342.GA818@bytesex.org>; from kraxel@bytesex.org on Thu, Aug 07, 2003 at 05:43:42PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 05:43:42PM +0200, Gerd Knorr wrote:
> +static void video_release(struct class_device *cd)
> +{
> +	struct video_device *vfd = container_of(cd, struct video_device, class_dev);
>  
> -static struct proc_dir_entry *video_dev_proc_entry = NULL;
> -struct proc_dir_entry *video_proc_entry = NULL;
> -EXPORT_SYMBOL(video_proc_entry);
> -LIST_HEAD(videodev_proc_list);
> +#if 1 /* needed until all drivers are fixed */
> +	if (!vfd->release)
> +		return;
> +#endif
> +	vfd->release(vfd);
> +}

Ok, so you're allowing the release to happen elsewhere.  How are you
ensuring that the code which vfd->release points to hasn't been
unloaded before the video device has been released, or, even, how
are you preventing the module containing the above code being
removed before all video devices have been released?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

