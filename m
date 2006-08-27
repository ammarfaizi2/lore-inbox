Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWH0Itw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWH0Itw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 04:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWH0Itv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 04:49:51 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:23109 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751341AbWH0Itv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 04:49:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GqbgoG/4Al/7tnqGHX7zxWWWTMHRLtJaq/XbMxzNuF+7/PuwxuRT6q8t3nQXEqr05/0VWjmsOGXGWH9dej6mXGLaBZLtE4+/s0Xj62O/RWnmPC1OXQJeKg0PimWbkaVLzEKGMAHR136oHzcZ1xgashHh4igC7UxV/C2naYChLFM=
Message-ID: <2c0942db0608270149r4755cc1dj5a970ecd44dc2350@mail.gmail.com>
Date: Sun, 27 Aug 2006 01:49:50 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Reiser4 und LZO compression
Cc: "Alexey Dobriyan" <adobriyan@gmail.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060827010428.5c9d943b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>
	 <20060827010428.5c9d943b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 27 Aug 2006 04:34:26 +0400
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > The patch below is so-called reiser4 LZO compression plugin as extracted
> > from 2.6.18-rc4-mm3.
> >
> > I think it is an unauditable piece of shit and thus should not enter
> > mainline.

Sheesh.

> Like lib/inflate.c (and this new code should arguably be in lib/).
>
> The problem is that if we clean this up, we've diverged very much from the
> upstream implementation.  So taking in fixes and features from upstream
> becomes harder and more error-prone.

Right. How about putting it in as so that everyone can track
divergences, but to not use it for a real compile. Rather, consider it
meta-source, and do mechanical, repeatable transformations only,
starting with something like:

mv minilzo.c minilzo._c
cpp 2>/dev/null -w -P -C -nostdinc -dI minilzo._c >minilzo.c
lindent minilzo.c

to generate a version that can be audited. Doing so on a version of
minilzo.c google found on the web generated something that looked much
like any other stream coder source I've read, so it approaches
readability. Of a sorts. Further cleanups could be done with cpp -D to
rename some of the more bizarre symbols.

Downside is that bugs would have to be fixed in the 'meta-source'
(horrible name, but it's late here), but at least they could be found
(potentially) easier than in the original.

Ray
