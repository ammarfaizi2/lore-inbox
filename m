Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTJQOBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 10:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263476AbTJQOBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 10:01:37 -0400
Received: from cafe.hardrock.org ([142.179.182.80]:54698 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S263475AbTJQOBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 10:01:35 -0400
Date: Fri, 17 Oct 2003 08:01:26 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: Rik van Riel <riel@surriel.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] silence warning in reiserfs_ioctl
In-Reply-To: <Pine.LNX.4.55L.0310131233460.27244@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0310170759250.20802-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Rik van Riel wrote:

> Gcc is afraid we might fall off the end of the function without returning.
> 
> diff -urNp linux-5110/fs/reiserfs/ioctl.c linux-10010/fs/reiserfs/ioctl.c
> --- linux-5110/fs/reiserfs/ioctl.c
> +++ linux-10010/fs/reiserfs/ioctl.c
> @@ -84,6 +84,7 @@ int reiserfs_ioctl (struct inode * inode
>  	default:
>  		return -ENOTTY;
>  	}
> +	return 0;
>  }

Since the default (hit in case nothing else fits and where it would return)
returns -ENOTTY, shouldn't the return be -ENOTTY?

The function could almost at that point remove the default: case and return
-ENOTTY at the end of the function and still be correct...

Of course, it's just wrong to not have the default case, but just as a
point..

Regards
James

> 
>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

