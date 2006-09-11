Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWIKTWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWIKTWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWIKTWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:22:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:9132 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964938AbWIKTWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:22:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cJva9N/4Q5UVnSAgD5ckwLMfxwj0fpnJgM6giz/hb9e6lJEpA22wuX7MKF8QefbpKRxKmjN+/fzy9/qDjj5REP3tzk/xh+52qdvnFKT7zxBirXHEU+ZivpcBOD+kihH6vnjfp9IUX05OVNBTkmxqb71iRlsJ5Zgbaq/+QraqcFc=
Message-ID: <9a8748490609111222w2dd313e3hc64cb36bca7f646a@mail.gmail.com>
Date: Mon, 11 Sep 2006 21:22:15 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Jesper Juhl" <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, "Rickard Faith" <faith@redhat.com>
Subject: Re: [PATCH] fix warning: no return statement in function returning non-void in kernel/audit.c
In-Reply-To: <20060911160328.GJ4743@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609111715.17080.jesper.juhl@gmail.com>
	 <20060911160328.GJ4743@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/06, Dave Jones <davej@redhat.com> wrote:
> On Mon, Sep 11, 2006 at 05:15:16PM +0200, Jesper Juhl wrote:
>  >
>  > kauditd_thread() is being used in a call to kthread_run(). kthread_run() expects
>  > a function returning 'int' which is also how kauditd_thread() is declared. Unfortunately
>  > kauditd_thread() neglects to return a value which results in this complaint from gcc :
>  >
>  >   kernel/audit.c:372: warning: no return statement in function returning non-void
>  >
>  > Easily fixed by just adding a 'return 0;' to kauditd_thread().
>
> Which will never be reached.

True, and gcc even seems to optimize it out, since the size of audit.o
doesn't change with the patch applied... So, it does no harm and it
silences the warning - so why not?
I guess one could add a small /* never reached */ comment...


> Does marking the function NORET_TYPE
> also silence the warning?
>

Nope :(

This is with gcc 4.1.1 btw.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
