Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVKTVHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVKTVHe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVKTVHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:07:34 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:47207 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932073AbVKTVHd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:07:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iwfb2T4xYU02irJFOA2S4137PuZMVkbTo36qMRYHbNgxi7OMc2vF32UWhCn6Id/INCuC+0C3fakbQCvHjJkeav7dT/vSUs35DMXZSmdUEY2/l5UbBjrfapoj6QmlF0E88dgSSIpH2c+CxXHv752wjsT5lXO0XxGDTIwyz3F9R3I=
Message-ID: <29495f1d0511201307n29fd2095md0d9543d5aef9968@mail.gmail.com>
Date: Sun, 20 Nov 2005 13:07:32 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: 7eggert@gmx.de
Subject: Re: I made a patch and would like feedback/testers (drivers/cdrom/aztcd.c)
Cc: =?ISO-8859-1?Q?Daniel_Marjam=E4ki?= <daniel.marjamaki@comhem.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1EdwGs-0000qv-NL@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <5aZsv-3CJ-17@gated-at.bofh.it> <E1EdwGs-0000qv-NL@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/05, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Daniel Marjamäki <daniel.marjamaki@comhem.se> wrote:
>
> > -     aztTimeOutCount = 0;
> > +     aztTimeOut = jiffies + 2;
>
> Different timeout based on HZ seems wrong.

True; I'm trying to think of a good way to emulate 8000000 iterations
of loop, though. Really, this is not terrible to use 2 jiffies of
offset, as we try to sleep 1 jiffy each time. As long as we don't get
a signal *right* away, we'll sleep probably for 2 loops. Not sure,
though, may be useful to see what happens in practice and then debug
further for the right value.

May also want to use time_after_eq() not time_after().

Thanks,
Nish
