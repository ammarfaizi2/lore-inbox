Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263551AbUERU3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUERU3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 16:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUERU3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 16:29:33 -0400
Received: from smtprelay03.ispgateway.de ([62.67.200.164]:9451 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S263551AbUERU3b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 16:29:31 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: fc scsi <scsi_fc_group@yahoo.com>
Subject: Re: _PAGE_PCD bit in DMAable memory
Date: Tue, 18 May 2004 22:29:20 +0200
User-Agent: KMail/1.6.2
References: <20040518190319.95305.qmail@web50004.mail.yahoo.com>
In-Reply-To: <20040518190319.95305.qmail@web50004.mail.yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405182229.23737.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 18 May 2004 21:03, you wrote:
> Thanks much for the reply. I forgot to mention I am on
> Linux 2.4.20. I looked into 2.6 and could see what you
> described in your email. The comment on top of
> consistent_alloc() for arm (2.4.20) says it will give
> cache-coherent memory, but i am not able to see how
> this is made possible for Xscale when if it doesn't
> set the L_PTE_CACHEABLE to 0 (for 2.4.20, again).

There it is hidden in arch/arm/mm/ioremap.c

look at the L_ flags there and how L_PTE_CACHEABLE is missing there by default.

PS: This can be found easily with grep. Try this little Bash script to grep recursively 
      through the kernel and answer your questions more quickly:

#!/bin/bash
if [ $# -lt 2 ]; then
        PROGNAME=`basename $0`
        echo -e "$PROGNAME - find a string in a tree of *.c and *.h files"
        echo -e "Usage:\t$PROGNAME <start dir> <what>\n"
        exit 1
fi

DIR=$1
shift
exec find "${DIR}" -type f -name '*.[ch]' -print0 |xargs -0 grep -A8 "$@"


Regards

Ingo Oeser
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqnIhU56oYWuOrkARAv6xAKCgcq/WebDhbLunZA9m/MnDhbKAVgCffZDE
SPn4VpSWK57wFxjmdicyIok=
=KjNv
-----END PGP SIGNATURE-----
