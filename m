Return-Path: <linux-kernel-owner+w=401wt.eu-S965226AbXAGWTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbXAGWTY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbXAGWTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:19:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:13839 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965226AbXAGWTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:19:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gL/BiqW5NaMfGq/g3AbXbWXDx8P3BC51k3hjEvo1cBvPzJ4/T4Ll6V4do5PKLApHIgkfXr933zRfkWGCZEUnl9cL8IQ0FLOyYXaS7kIk09+Jt+G6RzFWoTp/jRq6XmkYeJHs4wQO3tzUTMY45USu2OTfyPQd4C/Fgj+LtaASgds=
Message-ID: <cd32a0620701071419sdc75ad9n348e1e96cc5a8307@mail.gmail.com>
Date: Mon, 8 Jan 2007 08:49:22 +1030
From: "Tom Lanyon" <tomlanyon@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: runaway loop modprobe binfmt-0000
In-Reply-To: <20070105164249.f79630a0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cd32a0620701051513i41e19d13k53d08d123980a717@mail.gmail.com>
	 <20070105164249.f79630a0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/07, Andrew Morton <akpm@osdl.org> wrote:
> On Sat, 6 Jan 2007 09:43:14 +1030
> "Tom Lanyon" <tomlanyon@gmail.com> wrote:
>
> > How can I discover
> > what is trying to load binfmt-0000 and why is it looping?
>
> Start with this, I guess..
>
> --- a/kernel/kmod.c~a
> +++ a/kernel/kmod.c
> @@ -98,10 +98,12 @@ int request_module(const char *fmt, ...)
>         atomic_inc(&kmod_concurrent);
>         if (atomic_read(&kmod_concurrent) > max_modprobes) {
>                 /* We may be blaming an innocent here, but unlikely */
> -               if (kmod_loop_msg++ < 5)
> +               if (kmod_loop_msg++ < 5) {
>                         printk(KERN_ERR
>                                "request_module: runaway loop modprobe %s\n",
>                                module_name);
> +                       dump_stack();
> +               }
>                 atomic_dec(&kmod_concurrent);
>                 return -ENOMEM;
>         }
> _
>
>

Thanks for the reply, Andrew.

How interesting... added that to kmod.c, rebuilt without change to
config, reboot.... machine booted perfectly!

I'm going to leave it for now, but I'll leave the dump_stack() call in
there in case further issues arise.

Regards

-- 
Tom Lanyon
