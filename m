Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129338AbRBBTyr>; Fri, 2 Feb 2001 14:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129297AbRBBTyh>; Fri, 2 Feb 2001 14:54:37 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:20229 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129338AbRBBTyb>;
	Fri, 2 Feb 2001 14:54:31 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Richard B. Johnson" <root@chaos.analogic.com>
Date: Fri, 2 Feb 2001 20:53:04 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Version 2.4.1 has ext2 problems.
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <145C05227023@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Feb 01 at 14:44, Richard B. Johnson wrote:

> # rm *
> rm: cannot remove `#1006': Value too large for defined data type
> rm: cannot remove `#1057': Value too large for defined data type
> rm: cannot remove `#1140': Value too large for defined data type
> ls: #588: Value too large for defined data type
> [SNIPPED...]
> 
> lstat("#1057", 0xbffff2c0)              = -1 EOVERFLOW (Value too large for defined data type)

Too old fileutils, and maybe glibc. They do not handle >2GB files.
And 'rm', for some strange reason, first 'lstat' file before removing
it. As workaround, do:

cd lost+found
for a in *; do echo > $a; done
rm *

BTW, who created that files? Maybe there is some way to get through
2GB limit check without saying O_LARGEFILE? But more probably stupid 
software using O_LARGEFILE without knowing consequences...
                                                      Petr Vandrovec
                                                      vandrove@vc.cvut.cz
                                                      
                                                           
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
