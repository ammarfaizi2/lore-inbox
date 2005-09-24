Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVIXRnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVIXRnb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVIXRnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:43:31 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:3506 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932209AbVIXRna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:43:30 -0400
Date: Sat, 24 Sep 2005 19:43:17 +0200
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <20050924174317.GC3586@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050921222839.76c53ba1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921222839.76c53ba1.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.14-rc2-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 10:28:39PM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm1/
[...]
> +reiser4-ver_linux-dont-print-reiser4progs-version-if-none-found.patch
> +reiser4-atime-update-fix.patch
> +reiser4-use-try_to_freeze.patch
> 
>  reiser4 fixes

Runs good, except that reiser4 seems to do bad things in do_sendfile.
I have apache2 running here and it refuses to serve my ~/public_html
homepage. /home is running on a reiser4 partition and while apache2
serves good pages from different filesystems, stracing the process while
requesting my homepage, I get:

stat64("/home/mattia/public_html/index.html", {st_mode=S_IFREG|0644, st_size=2315, ...}) = 0
open("/home/mattia/public_html/index.html", O_RDONLY) = 12
setsockopt(11, SOL_TCP, TCP_NODELAY, [0], 4) = 0
setsockopt(11, SOL_TCP, TCP_CORK, [1], 4) = 0
writev(11, [{"HTTP/1.1 200 OK\r\nDate: Sat, 24 S"..., 328}], 1) = 328
sendfile(11, 12, [0], 2315)             = -1 EINVAL (Invalid argument)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
setsockopt(11, SOL_TCP, TCP_CORK, [0], 4) = 0
setsockopt(11, SOL_TCP, TCP_NODELAY, [1], 4) = 0
read(11, 0x82297f0, 8000)               = -1 EAGAIN (Resource temporarily unavailable)
write(10, "127.0.0.1 - - [24/Sep/2005:10:13"..., 95) = 95
close(11)                               = 0
read(5, 0xbfe4c4e3, 1)                  = -1 EAGAIN (Resource temporarily unavailable)
close(12)                               = 0

-- 
mattia
:wq!
