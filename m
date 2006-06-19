Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWFSIVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWFSIVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFSIVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:21:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:2866 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932317AbWFSIVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:21:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PuunS0tEYm3NDqohKgxp/FzTHqLld+z9MDuLnywUBcpBB0FUCGZ7a2KCXcdMCdarxNJX4DHml5cqlixSY1eV4Jj/n7+jC7vRbLVAia5S4y3Jz9qY2Hz1xPnDKe3ZZ8P5wLw3lhzYUecLHHoAh89QjFzKtLAhM6Tnbaz6dbg2eSo=
Message-ID: <9a8748490606190121u3c76c6bbif707835ec7e5873c@mail.gmail.com>
Date: Mon, 19 Jun 2006 10:21:38 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Subject: Re: [PATCH 4/7] fuse: add POSIX file locking support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1FplXk-00062M-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
	 <E1FplXk-00062M-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/06, Miklos Szeredi <miklos@szeredi.hu> wrote:
> This patch adds POSIX file locking support to the fuse interface.
>
> +/*
> + * It would be nice to scramble the ID space, so that the value of the
> + * files_struct pointer is not exposed to userspace.  Symmetric crypto
> + * functions are overkill, since the inverse function doesn't need to
> + * be implemented (though it does have to exist).  Is there something
> + * simpler?
> + */
> +static inline u64 fuse_lock_owner_id(fl_owner_t id)
> +{
> +       return (unsigned long) id;
> +}
> +

How about; on fuse startup, pick some semirandom number, store it
somewhere, then do an XOR of the pointer with the saved value to
scramble it, when you need to use it, simply XOR it again with the
stored value...  Not especially strong, but better than nothing and
better than just adding a constant that people can find out from the
source (and the scramble value would be differene each time fuse
loads, so at a minimum a different scramble key every boot) - also,
XOR is a quite fast operation so overhead should be low.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
