Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWHRBtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWHRBtc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 21:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWHRBtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 21:49:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:56252 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030264AbWHRBtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 21:49:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ezZ/v1MvXnoqubiydVOiQ3/tSFDuKjWAyFNVATXuyqmQn9hiSmSh8nwBf1HJrhOZxry8/18mNf5n9lCzugYnlsZ3V055QMW7lK3mRswWGbiXqpm/up4cGqJOFdz6tQ91lxic6N+11ZjtyVZMc+cBuMTou7O4yTVCyHWa5TV4TEA=
Date: Fri, 18 Aug 2006 05:49:22 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC-patch - make sysfs_create_group skip members with attr.mode == 0
Message-ID: <20060818014922.GA2622@martell.zuzino.mipt.ru>
References: <44E4F2B1.30408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E4F2B1.30408@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 04:50:25PM -0600, Jim Cromie wrote:
> Currently, code in hwmon/*.c uses sysfs_create_group less than it could.

Please, provide sample patch which will use this feature. And I personally
don't understand the reasoning: can i2c code use sysfs_create_group()
with elements of struct attribute_group::attrs array ifdeffed?

> A contributing reason is that many individual attr-files are created
> conditionally,
> depending upon both underlying hardware, driver configuration, etc.

> --- try1/fs/sysfs/group.c	2006-06-17 19:49:35.000000000 -0600
> +++ try2/fs/sysfs/group.c	2006-08-17 10:06:26.000000000 -0600
> @@ -32,7 +33,8 @@ static int create_files(struct dentry *
> 	int error = 0;
>
> 	for (attr = grp->attrs; *attr && !error; attr++) {
> -		error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
> +		if ((*attr)->mode)
> +			error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
> 	}

