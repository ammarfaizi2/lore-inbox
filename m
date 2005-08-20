Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVHTHeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVHTHeL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 03:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVHTHeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 03:34:11 -0400
Received: from smtp.istop.com ([66.11.167.126]:51861 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932093AbVHTHeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 03:34:10 -0400
From: Daniel Phillips <phillips@istop.com>
To: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] Permissions don't stick on ConfigFS attributes
Date: Sat, 20 Aug 2005 17:35:09 +1000
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200508201050.51982.phillips@istop.com> <20050820030117.GA775@kroah.com> <20050820063159.GB3168@ca-server1.us.oracle.com>
In-Reply-To: <20050820063159.GB3168@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508201735.09816.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 August 2005 16:31, Joel Becker wrote:
> On Fri, Aug 19, 2005 at 08:01:17PM -0700, Greg KH wrote:
> > The recent changes to sysfs should be ported to configfs to do this.
>
> 	Yeah, I've been meaning to do something, and resusing code is
> always a good plan.

Ending up with the same code in core kernel in two different places is always 
a bad plan.  Oh man.  Just look at these two bodies of code, configfs is 
mostly just large tracts that are identical to sysfs except for name changes.  
Listen to what the code is trying to tell you!

SysFS:

struct kobject {
	const char		* k_name;
	char			name[KOBJ_NAME_LEN];
	struct kref		kref;
	struct list_head	entry;
	struct kobject		* parent;
	struct kset		* kset;
	struct kobj_type	* ktype;
	struct dentry		* dentry;
};

ConfigFS:

struct config_item {
	char			*ci_name;
	char			ci_namebuf[CONFIGFS_ITEM_NAME_LEN];
	struct kref		ci_kref;
	struct list_head	ci_entry;
	struct config_item	*ci_parent;
	struct config_group	*ci_group;
	struct config_item_type	*ci_type;
	struct dentry		*ci_dentry;
};

Big difference, huh?

As designer of configfs, could you please offer your take on why it cannot be 
rolled back into sysfs, considering that it is mostly identical already?

Regards,

Daniel
