Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVD0Ttl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVD0Ttl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 15:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVD0Ttl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 15:49:41 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:50981 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261983AbVD0Ttj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 15:49:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e93hcZ6PGgGy9Ub7k4ks2PfTXpG9JRGW71puA0NWkbj+Rq0YAsDb/vzFgn3pS7Jwpz7jnCu8hJ0B0qYLwfV73l/tCMod/ckAnO/O0z9yfYBTjKsVct+4gRwizaT3SdlW8lZ377lS3TE6aRjxVLm5DelZIfI3K2KCu6XCpKYwJXg=
Message-ID: <d120d50005042712496e6e598@mail.gmail.com>
Date: Wed, 27 Apr 2005 14:49:38 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <gregkh@suse.de>
Subject: Re: [03/07] I2C: Fix incorrect sysfs file permissions in it87 and via686a drivers
Cc: khali@linux-fr.org, sensors@stimpy.netroedge.com,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <d120d50005042712417656ba3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050427171446.GA3195@kroah.com> <20050427171617.GD3195@kroah.com>
	 <d120d50005042712417656ba3a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 4/27/05, Greg KH <gregkh@suse.de> wrote:
> >
> > -stable review patch.  If anyone has any objections, please let us know.
> >
> 
> While the patch is correct I'd have something like this as well:
> 
> --- linux-2.6.11.orig/fs/sysfs/file.c
> +++ linux-2.6.11/fs/sysfs/file.c
> @@ -36,7 +36,7 @@ subsys_attr_store(struct kobject * kobj,
> {
>        struct subsystem * s = to_subsys(kobj);
>        struct subsys_attribute * sattr = to_sattr(attr);
> -       ssize_t ret = 0;
> +       ssize_t ret = -ENOSYS;
> 
>        if (sattr->store)
>                ret = sattr->store(s,page,count);
> 
> So writes without store handler would return "not implemented".
> 

Obviously driver_sysfs_ops, bus_sysfs_ops, etc need the same treatment...

-- 
Dmitry
