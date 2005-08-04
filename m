Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVHDNxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVHDNxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVHDNxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:53:48 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:5501 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262543AbVHDNxT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:53:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MTxTUFnbptGCyKqfWVj6DozuA7155fs5Iyg+OVB0u2v6cjkuKV35PjMzMTrbySYFhIWTIxreZOYDokIylc2RgQjAz+1DxGm5/oyGjTR8T/Kzq8GWULhaY4BMmRD032uu4YmET45kN+h/94+LXRppbf/2JTH8SCnP0jJNlBfSWKc=
Message-ID: <9a87484905080406533ad143f9@mail.gmail.com>
Date: Thu, 4 Aug 2005 15:53:19 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>
Subject: Re: [PATCH 1/2] cpqfc: fix for "Using too much stach" in 2.6 kernel
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@suse.de
In-Reply-To: <4221C1B21C20854291E185D1243EA8F302623BCC@bgeexc04.asiapacific.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4221C1B21C20854291E185D1243EA8F302623BCC@bgeexc04.asiapacific.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/05, Saripalli, Venkata Ramanamurthy (STSD) <saripalli@hp.com> wrote:
> Patch 1 of 2
> 
> This patch fixes the "#error this is too much stack" in 2.6 kernel.
> Using kmalloc to allocate memory to ulFibreFrame.
> 
[snip]
>            if( fchs->pl[0] == ELS_LILP_FRAME)
>           {
> +           kfree(ulFibreFrame);
>              return 1; // found the LILP frame!
>           }
>           else
>           {
> +           kfree(ulFibreFrame);
>             // keep looking...
>           }

The first thing you do in either branch is to call
kfree(ulFibreFrame); , so instead of having the call in both branches
you might as well just have one call before the if().  Ohh and this
looks like it could do with a CodingStyle cleanup as well.

kfree(ulFibreFrame);
if (fchs->pl[0] == ELS_LILP_FRAME)
        return 1; /* found the LILP frame! */
/* keep looking */


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
