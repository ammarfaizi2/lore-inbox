Return-Path: <linux-kernel-owner+w=401wt.eu-S1946018AbWLVKLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946018AbWLVKLG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946021AbWLVKLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:11:06 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:53680 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946018AbWLVKLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:11:05 -0500
Date: Fri, 22 Dec 2006 11:10:55 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061222101055.GA12230@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org> <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> <20061221012721.68f3934b.akpm@osdl.org> <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> <20061222100004.GC10273@deprecation.cyrius.com> <20061222100637.GA12105@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222100637.GA12105@deprecation.cyrius.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Michlmayr <tbm@cyrius.com> [2006-12-22 11:06]:
> Okay, it's really weird.  So apt-get just hangs doing nothing and I
> cannot even kill it.  I just tried to download strace via wget and
> immediately when I started wget, the hanging apt-get process
> continued.

... and now that we've completed this step, the apt cache has suddenly
been reduced (see Gordon's mail for an explanation) and it segfaults:

sh-3.1# ls -l /var/cache/apt/
total 12524
drwxr-xr-x 3 root root   12288 Dec 22 04:41 archives
-rw-r--r-- 1 root root 6426885 Dec 22 05:03 pkgcache.bin
-rw-r--r-- 1 root root 6426835 Dec 22 05:03 srcpkgcache.bin
sh-3.1# apt-get -f install
Reading package lists... Done
Segmentation faulty tree... 50%

-- 
Martin Michlmayr
http://www.cyrius.com/
