Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbVLVHVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVLVHVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 02:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbVLVHVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 02:21:14 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:53919 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965108AbVLVHVN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 02:21:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jetM4TvrGTR+LmI07yr/57UJMQw/2LEFehUYTwIFQz6ZRf0u3gFrepN9PGhrcazXLL6D7SY6sck6RwSK7MNQnNlVSYvdkj+1MlTDywX8RqzUWzAYWWC+0PEOnwVesdsUyh86L6oXjym57Z9FxFusMZHsyGwylYWikAlNoUHTfEQ=
Message-ID: <6f48278f0512212321w3dd39ca6ldb1c814c6322127@mail.gmail.com>
Date: Thu, 22 Dec 2005 15:21:11 +0800
From: Jie Zhang <jzhang918@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Question on the current behaviour of malloc () on Linux
Cc: Linux kernel <linux-kernel@vger.kernel.org>, lars.friedrich@wago.com
In-Reply-To: <Pine.LNX.4.61.0512211259090.12113@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6f48278f0512210936y25169c37t9fb7eb13fef3a97d@mail.gmail.com>
	 <Pine.LNX.4.61.0512211259090.12113@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Wed, 21 Dec 2005, Jie Zhang wrote:
>
> > Hi,
> >
> > I first asked this question on uClinux mailing list. My first question
> > is <http://mailman.uclinux.org/pipermail/uclinux-dev/2005-December/036042.html>.
> > Although I found this issue on uClinux, it's also can be demostrated
> > on Linux. This is a small program:
> >
>
> Another FAQ....
>
> > $> cat test2.c
> > #include <stdio.h>
> > #include <stdlib.h>
> >
> > int
> > main ()
> > {
> >  char *p;
> >  int i, j;
> >  for (i = 0;; i++)
> >    {
> >      p = (char *) malloc (8 * 1024 * 1024);
> >      if (p)
> >        for (j = 0; j < 8 * 1024 * 1024; j++)
> >          p[j] = 0x55;
> >      else
> >        {
> >          printf ("%d fail\n", i);
> >          break;
> >        }
> >    }
> >  return 0;
> > }
> >
> > When I run it on my Linux notebook, it will be killed. I expect to see
> > it prints out   "fail".
>
> Your expectations are not based upon any logic, only wishes.
>
According to SuSv3, I think my expectation is completely based upon
logic. Actually, overcommitting is based upon wishes I think. It
wishes application not use all the memory it allocated.
>
>
> To make your wishes come true execute:
>      echo "1" >/proc/sys/vm/overcommit_memory
> ... as a super-user.
>
> That will make malloc() fail when there isn't any more virtual
> memory.

That's what I'm looking for. Thanks.

Jie
