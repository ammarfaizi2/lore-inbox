Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129408AbQK0WRw>; Mon, 27 Nov 2000 17:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129514AbQK0WRc>; Mon, 27 Nov 2000 17:17:32 -0500
Received: from 13dyn33.delft.casema.net ([212.64.76.33]:7952 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S129404AbQK0WRU>; Mon, 27 Nov 2000 17:17:20 -0500
Message-Id: <200011272147.WAA19696@cave.bitwizard.nl>
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <20001127134251.A8164@veritas.com> from Andries Brouwer at "Nov
 27, 2000 01:42:51 pm"
To: Andries Brouwer <aeb@veritas.com>
Date: Mon, 27 Nov 2000 22:47:06 +0100 (MET)
CC: Peter Cordes <peter@llama.nslug.ns.ca>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> > access("/dev/tty2", R_OK|W_OK)          = -1 EROFS (Read-only file system)

> You misunderstand the function of access(). The standard says
> 
> [EROFS] write access shall fail if write access is requested
>         for a file on a read-only file system

The intent of the "access" call is to tell you if you will be able to
open the given pathname for the requested permissions. That this is
inherently racey is not the fault of the access system call.

The INTENT of this paragraph from the standard is to specify when to
return the error value EROFS. The "for a -=file=-" part to me
indicates that a valid interpretation is that this does not apply to
device nodes.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
