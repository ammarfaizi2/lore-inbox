Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291038AbSBNJ3o>; Thu, 14 Feb 2002 04:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291082AbSBNJ3e>; Thu, 14 Feb 2002 04:29:34 -0500
Received: from sc-gw.scientific.de ([194.121.255.233]:33725 "EHLO
	sarah.scientific.de") by vger.kernel.org with ESMTP
	id <S291038AbSBNJ3Y>; Thu, 14 Feb 2002 04:29:24 -0500
Subject: Re: [patch] tmpfs: incr. link-count on directory rename
From: Uli Martens <u.martens@scientific.de>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Christoph Rohland <cr@sap.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020214061933.GA17774@mentor.odyssey.cs.cmu.edu>
In-Reply-To: <1013648840.2317.5.camel@isax> 
	<20020214061933.GA17774@mentor.odyssey.cs.cmu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 14 Feb 2002 10:34:01 +0100
Message-Id: <1013679241.20006.21.camel@pc-um>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-14 at 07:19, Jan Harkes wrote:
> 
> ps. shouldn't the linkcount of the old_dir get decremented too? Also you
> should only change the linkcounts when the operation completed
> successfully. i.e. something more like,
Oops, you're right, the linkcount of old_dir isn't decremented at the
moment, too. I will test your patch this evening, but I think it looks
better than mine... ;)

> --- /tmp/shmem.c.orig	Thu Feb 14 01:17:23 2002
> +++ /tmp/shmem.c	Thu Feb 14 01:18:25 2002
> @@ -1100,6 +1100,10 @@
>  		error = 0;
>  		old_dentry->d_inode->i_ctime = old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
>  	}
> +	if (!error && S_ISDIR(old_dentry->d_inode->i_mode)) {
> +	    old_dir->i_nlink--;
> +	    new_dir->i_nlink++;
> +	}
>  	return error;
>  }

-- 
uli martens

