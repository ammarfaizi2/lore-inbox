Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWIZRXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWIZRXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWIZRXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:23:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:36975 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932132AbWIZRXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:23:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GU/7FBzD5zoKycGc9nY/JauIjyMbK/EfuXFZKDQtnZqA/373FAXkUldvPtuj4hU1XbIA9+56TvmSBoJmo7ChAzmHhngMjr17IQETo9lRYz9uo2UCPEuOX0/xUkvDhiY8raIOL6xhyl6AsTDE6tKffvvF9dThs0nX7YY7HkokJbg=
Message-ID: <d120d5000609261023o20c29171kcba4903c9a35fffb@mail.gmail.com>
Date: Tue, 26 Sep 2006 13:23:34 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH 41/47] drivers/base: check errors
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Cornelia Huck" <cornelia.huck@de.ibm.com>,
       "Greg Kroah-Hartman" <gregkh@suse.de>
In-Reply-To: <11592492153066-git-send-email-greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060926053728.GA8970@kroah.com>
	 <11592491901464-git-send-email-greg@kroah.com>
	 <11592491924093-git-send-email-greg@kroah.com>
	 <1159249196427-git-send-email-greg@kroah.com>
	 <1159249200793-git-send-email-greg@kroah.com>
	 <11592492023883-git-send-email-greg@kroah.com>
	 <11592492061208-git-send-email-greg@kroah.com>
	 <1159249209773-git-send-email-greg@kroah.com>
	 <11592492123695-git-send-email-greg@kroah.com>
	 <11592492153066-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/06, Greg KH <greg@kroah.com> wrote:
> From: Andrew Morton <akpm@osdl.org>
>
> Add lots of return-value checking.
>
> +               if (error)
> +                       goto out;
> +               error = sysfs_create_link(&bus->devices.kobj,
> +                                               &dev->kobj, dev->bus_id);
> +               if (error)
> +                       goto out;
> +               error = sysfs_create_link(&dev->kobj,
> +                               &dev->bus->subsys.kset.kobj, "subsystem");
> +               if (error)
> +                       goto out;
> +               error = sysfs_create_link(&dev->kobj,
> +                               &dev->bus->subsys.kset.kobj, "bus");
>        }
> +out:
>        return error;

What about removing the links that were created if one of these calls fails?

-- 
Dmitry
