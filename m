Return-Path: <linux-kernel-owner+w=401wt.eu-S964807AbWLVPab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWLVPab (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 10:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbWLVPab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 10:30:31 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:39759 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964807AbWLVPaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 10:30:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YqR03h+VvTtIXACUgsVJY1szvkyXbstDIuLknOTCuEF1j5jQZSKukcEh40Lc2ybYKCdltpDBiTc0VMw68Oc0kMSV4dJKISAOiC/5pnPbpiWCeRhq2Ca+BwG7I1NdAni4H+wzLOT1rHKRUKrGvC73oART9+GwlTPY9qz/b6OKAPM=
Message-ID: <97a0a9ac0612220730r4f00c913k65a074097f981277@mail.gmail.com>
Date: Fri, 22 Dec 2006 08:30:29 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Martin Michlmayr" <tbm@cyrius.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrei Popa" <andrei.popa@i-neo.ro>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>
In-Reply-To: <20061222101055.GA12230@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
	 <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
	 <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <20061221012721.68f3934b.akpm@osdl.org>
	 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	 <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
	 <20061222100004.GC10273@deprecation.cyrius.com>
	 <20061222100637.GA12105@deprecation.cyrius.com>
	 <20061222101055.GA12230@deprecation.cyrius.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/06, Martin Michlmayr <tbm@cyrius.com> wrote:

> ... and now that we've completed this step, the apt cache has suddenly
> been reduced (see Gordon's mail for an explanation) and it segfaults:
>
> sh-3.1# ls -l /var/cache/apt/
> total 12524
> drwxr-xr-x 3 root root   12288 Dec 22 04:41 archives
> -rw-r--r-- 1 root root 6426885 Dec 22 05:03 pkgcache.bin
> -rw-r--r-- 1 root root 6426835 Dec 22 05:03 srcpkgcache.bin
> sh-3.1# apt-get -f install
> Reading package lists... Done
> Segmentation faulty tree... 50%

I think that we are seeing different manifestations of apt's response
to corrupted cache files. There does not appear to be any pattern to
which manifestation occurs. Maybe it depends on where in the cache
file the corruption is located, i.e. when the corruption occurs. Based
on the kernel gurus current knowledge of the problem, would you expect
the corruption to occur at the same point in a file, or is it possible
that the corruption could occur at different points on successive
Debian installer attempts on a UP, non PREEMPT system ?

Gordon

-- 
Gordon Farquharson
