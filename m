Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVGLXqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVGLXqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVGLXnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:43:50 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:58800 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262457AbVGLXma convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:42:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bySdLSfS4hyxN3CcZ73N/3eV8ELT/VWIPtVApkW/5Q3KO8ZegdTUZmvYCDUNCLr/Y2RIT8dTRVyPC/ujeXIcypbVcMMNq06QjfO8UyYdhm4+UvxD/tHMrxwLJ1czffiovY535D1duvExzQa+NWQQ0FlmHZNnyktJndZJONRWVC4=
Message-ID: <5a4c581d050712164214d0810@mail.gmail.com>
Date: Wed, 13 Jul 2005 01:42:29 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SLAB_DEBUG oopses 2.6.13-rc2-git3 (and seems to make BitTorrent loop)
In-Reply-To: <5a4c581d0507121523123d6ecf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0507121523123d6ecf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/05, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:

[snip]

> I also get (a byproduct of the CONFIG_SLAB_DEBUG kernel,
>  I'd assume, as it never happened before) my BitTorrent curses
>  sessions suddenly stop refreshing the download/upload stats,
>  strace looks like this:
> 
> ...
> mremap(0xb3b39000, 5246976, 5246976, MREMAP_MAYMOVE) = 0xb3b39000
> gettimeofday({1121206671, 812488}, NULL) = 0
> futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
> futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
> mremap(0xb3b39000, 5246976, 5246976, MREMAP_MAYMOVE) = 0xb3b39000
> gettimeofday({1121206671, 813010}, NULL) = 0
> futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
> futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
> mremap(0xb3b39000, 5246976, 5246976, MREMAP_MAYMOVE) = 0xb3b39000
> gettimeofday({1121206671, 813501}, NULL) = 0
> futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
> futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
> mremap(0xb3b39000, 5246976, 5246976, MREMAP_MAYMOVE) = 0xb3b39000
> ...
> 
>  forever, and ever.
> 
> uptodate FC3, K7-800, 256MB RAM, kernel 2.6.13-rc2-git3.
> 
> Is this just my DIMMs finally giving up or may this actually
>  be a legitimate kernel bug ?

Uhm. The loop seemed to be related to the Fedora zlib update,
 as both upgrading to 2.6.13-rc2-git5 without slab debugging
 and downgrading to 2.6.12-git5 still exposes the problem;
 this latter kernel didn't show this problem earlier.

Upgrading to bittorrent 4.1.2 from dag (previous was 4.1.1
 still from dag) seems to have fixed the looping issues.

Thanks,

--alessandro

 "When it comes to luck / you make your own
  Tonight I've got dirt on my hands
  But I'm building me a new home"

    (Bruce Springsteen - "Lucky Town")
