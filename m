Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVD0TmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVD0TmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 15:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVD0TmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 15:42:16 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:3880 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261980AbVD0TmA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 15:42:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f6RSitIgjsd2TZ2USbec6642pQBuPrn7NhIrXB9YwvzN+JerV3YGQKaVZN5H48UYTqcb/wvJ0vitzLTYU9Fz+oak4eybg0XMNIzPyTScpwSj5JYEa7/nicwL2nOvownxxQfbXT2xMYeJuViPvujOBHnCsVWt7Ge8UYizIAhymTY=
Message-ID: <d120d50005042712417656ba3a@mail.gmail.com>
Date: Wed, 27 Apr 2005 14:41:56 -0500
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
In-Reply-To: <20050427171617.GD3195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050427171446.GA3195@kroah.com> <20050427171617.GD3195@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/05, Greg KH <gregkh@suse.de> wrote:
> 
> -stable review patch.  If anyone has any objections, please let us know.
> 

While the patch is correct I'd have something like this as well:

--- linux-2.6.11.orig/fs/sysfs/file.c
+++ linux-2.6.11/fs/sysfs/file.c
@@ -36,7 +36,7 @@ subsys_attr_store(struct kobject * kobj,
 {
        struct subsystem * s = to_subsys(kobj);
        struct subsys_attribute * sattr = to_sattr(attr);
-       ssize_t ret = 0;
+       ssize_t ret = -ENOSYS;
 
        if (sattr->store)
                ret = sattr->store(s,page,count);

So writes without store handler would return "not implemented".

(It is whitespace-mangled and therefore not a real patch - so no
signed-off-by...)

-- 
Dmitry
