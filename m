Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbVKBJHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbVKBJHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbVKBJHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:07:07 -0500
Received: from [218.25.172.144] ([218.25.172.144]:41990 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932643AbVKBJHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:07:06 -0500
Date: Wed, 2 Nov 2005 17:06:56 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Hareesh Nagarajan <hnagar2@gmail.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] register_filesystem() must return -EEXIST if the filesystem with the same name is already registered
Message-ID: <20051102090656.GA12912@localhost.localdomain>
References: <43687BE4.3000708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43687BE4.3000708@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 02:42:12AM -0600, Hareesh Nagarajan wrote:
> If we have a look at the register_filesystem() function defined in 
> fs/filesystems.c, we see that if a filesystem with a same name has 
> already been registered then the find_filesystem() function will return 
> NON-NULL otherwise it will return NULL.
> 
> Hence, register_filesystem() should return EEXIST instead of EBUSY. 
> Returning EBUSY is misleading (unless of course I'm missing something 
> obvious) to the caller of register_filesystem().

This `slot' is buy, so EBUSY makes sense. Filesytem is not file, hence
EEXIST doesn't apply IMHO.

		Coywolf

> 
> Thanks,
> 
> Hareesh Nagarajan
> 

> --- linux-2.6.13.4/fs/filesystems.c	2005-10-10 13:54:29.000000000 -0500
> +++ linux-2.6.13.4-edit/fs/filesystems.c	2005-11-02 02:33:30.685600000 -0600
> @@ -76,7 +76,7 @@
>  	write_lock(&file_systems_lock);
>  	p = find_filesystem(fs->name);
>  	if (*p)
> -		res = -EBUSY;
> +		res = -EEXIST;
>  	else
>  		*p = fs;
>  	write_unlock(&file_systems_lock);

