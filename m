Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWDUUn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWDUUn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWDUUn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:43:26 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:21414 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932431AbWDUUnZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:43:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WGfr2/qSLkJz//fdawwryadm1OOBSqbIMbV262CjNloGx4dh7+C8WUk3HkQbH04m9UXWKjSQH8hJqprCVl5pFJpljrA9PJfzVfwsfEpV3ezBBVEqCm9qKig9FCqerk0WfnbrCuUAODpkVDLYmqJDLyASjjHHnCOU6sdmPxwobGM=
Message-ID: <a4403ff60604211343r45be01c0n2c97e10023978635@mail.gmail.com>
Date: Fri, 21 Apr 2006 14:43:25 -0600
From: "David Wilk" <davidwilk@gmail.com>
To: "Chris Wright" <chrisw@sous-sol.org>
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
Cc: "Hugh Dickins" <hugh@veritas.com>, "Greg KH" <greg@kroah.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060421192743.GH3061@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com>
	 <20060419192803.GA19852@kroah.com>
	 <Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0604201706540.14395@blonde.wat.veritas.com>
	 <a4403ff60604211208gf64dfe2v7282a493f4853c@mail.gmail.com>
	 <20060421192743.GH3061@sorel.sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

right, sorry, I forgot to try strace.  let me see what I can do.

On 4/21/06, Chris Wright <chrisw@sous-sol.org> wrote:
> * David Wilk (davidwilk@gmail.com) wrote:
> > Ok, on my first test system (lowest amount of ram) a 2.6.16.9 kernel
> > patched with the patch you provided works fine.  I'll throw it on some
> > other systems and we'll see how it does.
>
> Was that same (lowest amount of ram) system failing before Hugh's patch
> with vanilla 2.6.16.9?  What we're looking for is to see if the app
> was doing:
>
> 1) shmget(0444) [RDONLY], shmat(SHM_RDONLY), mprotect(PROT_WRITE)
> or
> 2) shmget(0666) [RDWR], shmat(SHM_RDONLY), mprotect(PROT_WRITE)
>
> The first is definitely a bug, and that's what the original patch
> was closing.  The second is technically (as in POSIX) undefined, and
> the original patch treated it as a bug as well.  Hugh's additional
> patch allows this behaviour, as it's vaguely similar to open(RDWR),
> mmap(PROT_READ), mprotect(PROT_WRITE), which is legitimate.  So we're
> trying to determine if that's what your app is doing.  strace output
> may be unwieldy, but that (or using syscall audit) would be helpful
> to clarify.
>
> thanks,
> -chris
>
