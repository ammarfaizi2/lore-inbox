Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752040AbWJWWJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbWJWWJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 18:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbWJWWJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 18:09:33 -0400
Received: from hu-out-0506.google.com ([72.14.214.234]:21421 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752040AbWJWWJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 18:09:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tlhG0+CM29j3sSztd+CRO0KT7jDR/F0lLH9K6SUH8co7YIUnBSO+L8ecAXFFoC0H/rypqgygSU/H7HwHSlj4vAj7byuABEGXtWR7v5gWW2oOUNzslnjLRbKP109KqzZL+LoyCCm4aeUwelw4X7OuZjPhKL+xBBA+NsXd2wF6D04=
Message-ID: <9a8748490610231509j1ec4dab6p8c5872c527e99dbf@mail.gmail.com>
Date: Tue, 24 Oct 2006 00:09:31 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Rientjes" <rientjes@cs.washington.edu>
Subject: Re: [PATCH] Fix use of uninitialized variable in drivers/video/sis/init301.c::SiS_DDC2Delay()
Cc: linux-kernel@vger.kernel.org,
       "Thomas Winischhofer" <thomas@winischhofer.net>
In-Reply-To: <200610232342.07458.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610232326.11288.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64N.0610231425510.9588@attu2.cs.washington.edu>
	 <200610232342.07458.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On Monday 23 October 2006 23:26, David Rientjes wrote:
> > On Mon, 23 Oct 2006, Jesper Juhl wrote:
> >
> > > The variable 'j' is used uninitialized in the loop. Fix by initializing it to zero.
> > >
> [snip]
> >
> > I doubt this patch compile tested.
> >
> You are right. I hang my head in shame and admit I did not compile test this one.
> Fixed patch below.
>
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
>
>  drivers/video/sis/init301.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/sis/init301.c b/drivers/video/sis/init301.c
> index f13fadd..45a5969 100644
> --- a/drivers/video/sis/init301.c
> +++ b/drivers/video/sis/init301.c
> @@ -445,7 +445,8 @@ #endif
>  void
>  SiS_DDC2Delay(struct SiS_Private *SiS_Pr, unsigned int delaytime)
>  {
> -   unsigned int i, j;
> +   unsigned int i;
> +   unsigned int j = 0;
>
>     for(i = 0; i < delaytime; i++) {
>        j += SiS_GetReg(SiS_Pr->SiS_P3c4,0x05);
>
Damn it, my brain seems to be non-functional tonight.
'j' is not used at all. just ignore this patch. I'll come up with
something proper some other day - right now it's obviously time for me
to get some sleep.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
