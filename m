Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWILI7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWILI7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWILI7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:59:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:50210 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965150AbWILI7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:59:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PRizckD2eJibEJ1FKacbNKmyZMTAoNvNr2H5yuAsDmeBcmgtUIybqwiP8OUhP5tSVPN3IkXZv3oHmyQoO5egfyPYrPmTV30jYJNYPchjzqO08VZzlQ7HUptiKhGISgDyGLo+S251PPSXeSy8Kiza+R7PZ7YJAuAtGNldxJt3Kkg=
Message-ID: <9a8748490609120159s28968daco6e4312d141046f25@mail.gmail.com>
Date: Tue, 12 Sep 2006 10:59:46 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] fix warning: no return statement in function returning non-void in kernel/audit.c
Cc: linux-kernel@vger.kernel.org, "Rickard Faith" <faith@redhat.com>
In-Reply-To: <200609112256.k8BMuqVt006467@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <jesper.juhl@gmail.com> <200609111715.17080.jesper.juhl@gmail.com>
	 <200609112256.k8BMuqVt006467@laptop13.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/06, Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > kauditd_thread() is being used in a call to kthread_run(). kthread_run()
> > expects a function returning 'int' which is also how kauditd_thread() is
> > declared. Unfortunately kauditd_thread() neglects to return a value
>
> It is an infinite loop...

I know. I'm just trying to get gcc to shut up.


> >                                                                     which
> > results in this complaint from gcc :
>
> >   kernel/audit.c:372: warning: no return statement in function returning non-void
>
> > Easily fixed by just adding a 'return 0;' to kauditd_thread().
>
> How about marking it as never returning?

Marking it NORET_TYPE doesn't do the trick, adding a 'return 0;' does.
And gcc optimizes the return away anyway, so the object file doesn't
increase in size, so it does no harm.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
