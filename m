Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135958AbRD0P44>; Fri, 27 Apr 2001 11:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136091AbRD0P4r>; Fri, 27 Apr 2001 11:56:47 -0400
Received: from t2.redhat.com ([199.183.24.243]:58877 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135958AbRD0P4h>; Fri, 27 Apr 2001 11:56:37 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3AE99CE8.BD325F52@antefacto.com> 
In-Reply-To: <3AE99CE8.BD325F52@antefacto.com>  <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se> 
To: Padraig Brady <padraig@antefacto.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Apr 2001 16:56:35 +0100
Message-ID: <15296.988386995@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


padraig@antefacto.com said:
> btw I get my initial root filesystem from a compact flash that can be
> accessed just like a hardisk. It's writeable also like a harddisk, but
> we boot with it readonly, and only mount it rw if we want to save
> config or whatever. We definitely wouldn't swap to it as it has
> limited erase/write cycles. The filesystem is compressed ext2.

Why copy it into RAM? Why not use cramfs and either turn the writable
directories into symlinks into a ramfs which you create at boot time, or 
union-mount a ramfs over the top of it?


padraig@antefacto.com said:
> As for using JFFS2 + MTD ramdisk intead of ext2+e2compr+ramdisk is not
> an option as the only advantage would be journalling, you still can't
> resize. IMHO JFFS is only required where you have flash without an IDE
> interface.

True. We are currently lacking a compact, compressing, journalling 
filesystem for use on block devices. It's been suggested that we could make 
JFFS2 work on them, by making a fake MTD device which uses a block device 
as backing store. Nobody's yet shown me the code though :)

--
dwmw2


