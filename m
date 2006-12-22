Return-Path: <linux-kernel-owner+w=401wt.eu-S1423163AbWLVPQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423163AbWLVPQQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 10:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423168AbWLVPQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 10:16:16 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:34433 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423163AbWLVPQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 10:16:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F6Ee92yYs5yevUuS0ZGl6xdVs1HxxhMVEI0DgkiKBV4lndK/Ohd491Lf3u8kagww20KB8TH6kAaQj0OMhdcHwyiWFk5tafKKW42aRVXoD8hXWahWM0o6RB0AbJpJv/HO7N/q7M9jgFzRIj+/c+94TG6ycm6zC6DKvjLE0WpvAzw=
Message-ID: <97a0a9ac0612220716h566ae2c6x35d57369780c0214@mail.gmail.com>
Date: Fri, 22 Dec 2006 08:16:14 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Martin Michlmayr" <tbm@cyrius.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrei Popa" <andrei.popa@i-neo.ro>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Heiko Carstens" <heiko.carstens@de.ibm.com>,
       "Arnd Bergmann" <arnd.bergmann@de.ibm.com>
In-Reply-To: <20061222100139.GD10273@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061220170323.GA12989@deprecation.cyrius.com>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
	 <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
	 <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <20061221012721.68f3934b.akpm@osdl.org>
	 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	 <20061222100139.GD10273@deprecation.cyrius.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/06, Martin Michlmayr <tbm@cyrius.com> wrote:

> sh-3.1# ls -l /var/cache/apt/
> total 5252
> drwxr-xr-x 3 root root    12288 Dec 22 04:41 archives
> -rw-r--r-- 1 root root 12582912 Dec 22 04:45 pkgcache.bin
> -rw-r--r-- 1 root root     8554 Dec 22 04:45 srcpkgcache.bin

This listing is a little different to what I got. For me,
srcpkgcache.bin did not exist when apt eventually finished. Did you
notice whether the install took a lot longer than usual ?

> Gordon, does it fail for you where it normally does (installing
> initramfs-tools) or much later?  For me, the installer was able to
> install initramfs-tools and the kernel, but apt now hangs at "Select
> and install software".

apt didn't hang for me, it just took 20 to 30 minutes to complete
building the package database. Usually, it takes less than a minute.
The installer stopped because it could not find a kernel to install. I
have seen this failure mde before, and as you have previously pointed
out, is probably the same problem (corrupted apt cache files), just a
different manifestation.

Gordon

-- 
Gordon Farquharson
