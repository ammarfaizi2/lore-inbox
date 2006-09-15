Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWIOQrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWIOQrs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWIOQrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:47:48 -0400
Received: from smtp-out.google.com ([216.239.45.12]:6747 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750776AbWIOQrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:47:48 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=teyq+6l5UnDlIco5FjYTZn5nEmjgDWZErf+whvpB9vNI+ehWr9SzLCfwZ/tIkh6Ic
	HcZ95/iAba9yQOJpUvlgA==
Subject: Re: [Patch03/05]- Containers: Initialization and Configfs interface
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060915163027.GA5285@atjola.homenet>
References: <1158284486.5408.154.camel@galaxy.corp.google.com>
	 <20060915163027.GA5285@atjola.homenet>
Content-Type: text/plain; charset=utf-8
Organization: Google Inc
Date: Fri, 15 Sep 2006 09:47:26 -0700
Message-Id: <1158338846.12311.30.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 18:30 +0200, Björn Steinbrink wrote:
> On 2006.09.14 18:41:26 -0700, Rohit Seth wrote:
> > +static int __init configfs_container_init(void)
> > +{
> > +	int ret;
> > +
> > +	config_group_init(&containerfs_group.cs_subsys.su_group);
> > +	init_MUTEX(&containerfs_group.cs_subsys.su_sem);
> > +	ret = configfs_register_subsystem(&containerfs_group.cs_subsys);
> > +
> > +	if (ret) 
> > +		printk(KERN_ERR "Error %d while registering container subsystem\n", ret);
> > +	else {
> > +		container_wq = create_workqueue("Kcontainerd");
> > +		if (container_wq == NULL) {
> > +			ret = -ENOMEM;
> > +			printk(KERN_ERR "Unable to create Container controllers");
> 
> Shouldn't the subsystem be unregistered here?
> 

Yes. Indeed.  I'll fix it.

Thanks,
-rohit

> > +		}
> > +	}
> > +	return ret;
> > +}
> 
> Regards,
> Björn

