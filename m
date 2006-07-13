Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWGMSfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWGMSfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWGMSfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:35:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:57798 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030281AbWGMSf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:35:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=hyg6YFe9wZw4QnSAiZY/MeIZZyzPA3RshAByQfMWcAVx5OuUp1BUOpJtavcOo+A+Ud3+g3JCesgz7S7FP2xI4kreAeg+fruprW1IYlOPHIxVN5PqHH0nQ1jZzKa8i9pXP6HcaYmJO0MPYMM6xxIKbomGZeSWkGKXy7TpYahOF10=
Message-ID: <eada2a070607131135k7e361132t957bfbb78f341cc2@mail.gmail.com>
Date: Thu, 13 Jul 2006 11:35:28 -0700
From: "Tim Pepper" <lnxninja@us.ibm.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] symlink nesting level change
Cc: "Al Viro" <viro@ftp.linux.org.uk>, hpa@zytor.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20060503183554.87f0218d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <14CFC56C96D8554AA0B8969DB825FEA0012B309B@chicken.machinevisionproducts.com>
	 <44580CF2.7070602@tlinx.org> <e3966u$dje$1@terminus.zytor.com>
	 <20060503030849.GZ27946@ftp.linux.org.uk>
	 <20060503183554.87f0218d.akpm@osdl.org>
X-Google-Sender-Auth: 668d3cbc1681c62b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 3 May 2006 04:08:49 +0100
> Al Viro <viro@ftp.linux.org.uk> wrote:
>
> > No.  It's way past time to bump it to 8.  Everyone had been warned - for
> > months now.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ----
> > --- a/include/linux/namei.h   2006-03-31 20:08:42.000000000 -0500
> > +++ b/include/linux/namei.h   2006-05-02 23:06:46.000000000 -0400
> > @@ -11,7 +11,7 @@
> >       struct file *file;
> >  };
> >
> > -enum { MAX_NESTED_LINKS = 5 };
> > +enum { MAX_NESTED_LINKS = 8 };
> >
> >  struct nameidata {
> >       struct dentry   *dentry;
>
> It's a non-back-compatible change which means that people will install
> 2.6.18+, will set stuff up which uses more that five nested links and some
> will discover that they can no longer run their software on older kernels.
>
> It'll only hurt a very small number of people, but for those people, it
> will hurt a lot.  And I can't really think of anything we can do to help
> them, apart from making the new behaviour runtime-controllable, defaulting
> to "off", but add a once-off printk when we hit MAX_NESTED_LINKS, pointing
> them at a document which tells them how to turn on the new behaviour and
> which explains the problems.  Which sucks.
>
> But I guess as major distros are 2.6.16-based, this is a good time to make
> this change.

Doesn't look like this ended up in 2.6.18-rc nor -mm.  The email
thread in May was tending towards finally bumping it.  Major distros
already have it at 8 for a long time.  Is there any reason left (aside
now from possibly waiting until 2.6.19's window?) to wait?


Tim
