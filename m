Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWGVSNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWGVSNE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 14:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWGVSNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 14:13:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:11840 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750947AbWGVSND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 14:13:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e2kusnfhcFv7xCdCF5Rhu8y1m25yZhSWMLBnwHS0ER0jaOWhDu4BUEcJXM3POZnupCb0nzGeULv47QVcbizjRYZ/78h7RvGsbywkmDnkfBZ8250QQdcjxCy84R+UP3UVzqidnh4oB/eD9XVAzAbrtC72n7WDLaCID8/QLIVrafE=
Message-ID: <bda6d13a0607221113s7e583492x783651eb9613b87f@mail.gmail.com>
Date: Sat, 22 Jul 2006 11:13:01 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: what is necessary for directory hard links
In-Reply-To: <E1G4Kpi-0001Os-AK@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6ARGK-19L-5@gated-at.bofh.it> <6B8og-1iB-17@gated-at.bofh.it>
	 <E1G4Kpi-0001Os-AK@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/06, Bodo Eggert <7eggert@elstempel.de> wrote:
> Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
>
> > Joshua Hudson <joshudson@gmail.com> wrote:
> >> This patch is the sum total of all that I had to change in the kernel
> >> VFS layer to support hard links to directories
> >
> > Can't be done, as it creates the possibility of loops.
>
> Don't do that then?
Exactly.

> > Detecting unconnected subgraphs uses a /lot/ of memory; and much worse, you
> > have to stop (almost) all filesystem activity while doing it.
I know.

I just decided the price is worth it.

In my filesystem, any attempt to create a loop of hard links
is detected and cancelled. Unlinking a directory requires it
to be empty if the last link is being removed. "." and ".."
links are counted separately from real links, so that is easy.
