Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTJWQw1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 12:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTJWQw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 12:52:27 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:16096 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263619AbTJWQwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 12:52:24 -0400
Date: Thu, 23 Oct 2003 14:52:39 -0300
From: Flavio Bruno Leitner <fbl@conectiva.com.br>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel/initrd and rootfs over LVM
Message-ID: <20031023175239.GF21031@conectiva.com.br>
References: <20031023164425.GC21031@conectiva.com.br> <200310231556.h9NFuGqm007878@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200310231556.h9NFuGqm007878@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 11:56:16AM -0400, Valdis.Kletnieks@vt.edu wrote:
> What I ended up doing to get that working back in the 2.5.4x days was to have
> my initrd's linuxrc do a 'lvm vgscan' to get the volume group online, and then
> an 'lvdisplay' - this of course wedged up after it since there wasn't a proper
> root=, but it revealed the numbers I needed.

It's an option, but I was thinking if there is no way to
name_to_dev_t() handle this case, so all rootfs devices 
will uses the same syntax.

> As far as I can tell, if you're using the device-mapper in 2.6, you'll want
> MAJOR=, and then the MINOR= seems to be stable across 2.4/2.6/lvm1/lvm2 (So if
> you're building the system under 2.4 and have LVM running there, you can get
> the minor number from lvdisplay there, and use it with major=254 to get your
> 2.6 up and running.  For lilo, I ended up using this:
> 
>         root=65029
> # magic number is major=254 * 256 + minor=5

It works too. It's just hard to upgrade many machines when you
already have root=/dev/vg../lv.. at grub config.

-- 
Flávio Bruno Leitner <fbl@conectiva.com.br>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]
