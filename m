Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262637AbREVQde>; Tue, 22 May 2001 12:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262656AbREVQdR>; Tue, 22 May 2001 12:33:17 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:42743 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262633AbREVQcx>; Tue, 22 May 2001 12:32:53 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDE89@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Philip Wang'" <PXWang@stanford.edu>
Cc: linux-kernel@vger.kernel.org, Dawson Engler <engler@cs.Stanford.EDU>
Subject: RE: [PATCH] drivers/acpi/driver.c (repost)
Date: Tue, 22 May 2001 09:32:45 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[trimmed CCs]

Hi Philip,

That code no longer exists in latest acpi snapshots, therefore it no longer
has the bug ;-)

I appreciate it, though.

Regards -- Andy

> -----Original Message-----
> From: Philip Wang [mailto:PXWang@stanford.edu]
> Sent: Monday, May 21, 2001 8:46 PM
> To: alan@lxorguk.ukuu.org.uk
> Cc: torvalds@transmeta.com; linux-kernel@vger.kernel.org; 
> Dawson Engler
> Subject: [PATCH] drivers/acpi/driver.c (repost)
> Importance: High
> 
> 
> Hello!
> 
> This is a repost of my previous message, which came out 
> garbled.  Now you 
> should be able to run patch -pO from the root linux dir on 
> the files...
> 
> There is a bug in driver.c of not freeing memory on error 
> paths.  buf.pointer is allocated but not freed if 
> copy_to_user fails.  The 
> addition I made was to kfree buf.pointer before returning 
> -EFAULT.  Thanks!
> 
> Philip
> 
> --- drivers/acpi/driver.c.orig       Mon May 21 20:36:55 2001
> +++ drivers/acpi/driver.c    Mon May 21 20:37:21 2001
> @@ -311,8 +311,10 @@
>                  size = buf.length - file->f_pos;
>                  if (size > *len)
>                          size = *len;
> -               if (copy_to_user(buffer, data, size))
> -                       return -EFAULT;
> +               if (copy_to_user(buffer, data, size)) {
> +                 kfree(buf.pointer);
> +                 return -EFAULT;
> +               }
>          }
> 
>          kfree(buf.pointer);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

