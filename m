Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130322AbQK1OfL>; Tue, 28 Nov 2000 09:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130510AbQK1Oev>; Tue, 28 Nov 2000 09:34:51 -0500
Received: from 13dyn172.delft.casema.net ([212.64.76.172]:22033 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S130322AbQK1Oeq>; Tue, 28 Nov 2000 09:34:46 -0500
Message-Id: <200011281404.PAA24567@cave.bitwizard.nl>
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <20001128010942.A9133@veritas.com> from Andries Brouwer at "Nov
 28, 2000 01:09:42 am"
To: Andries Brouwer <aeb@veritas.com>
Date: Tue, 28 Nov 2000 15:04:31 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Peter Cordes <peter@llama.nslug.ns.ca>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Mon, Nov 27, 2000 at 10:47:06PM +0100, Rogier Wolff wrote:
> > Andries Brouwer wrote:
> > > > access("/dev/tty2", R_OK|W_OK)          = -1 EROFS (Read-only file system)
> > 
> > > You misunderstand the function of access(). The standard says
> > > 
> > > [EROFS] write access shall fail if write access is requested
> > >         for a file on a read-only file system
> > 
> > The intent of the "access" call is to tell you if you will be able to
> > open the given pathname for the requested permissions. That this is
> > inherently racey is not the fault of the access system call.
> > 
> > The INTENT of this paragraph from the standard is to specify when to
> > return the error value EROFS. The "for a -=file=-" part to me
> > indicates that a valid interpretation is that this does not apply to
> > device nodes.
> 
> You optimist!
> A standard is not a text that should be read with the attitude
> "they write this but I know that they really meant that".
> A standard is precise.
> 
> In particular it defines the concepts used. For file it says:
> 
> File
> An object that can be written to, or read from, or both.
> A file has certain attributes, including access permissions and type.
> File types include regular file, character special file, block special
> file, FIFO special file, symbolic link, socket, and directory.
> Other types of files may be supported by the implementation.

Ok, so if you read the standard carefully you get a bogus result. 

Question: Was it meant this way, or did someone just make a mistake
(which happened to slip through and get approved into the standard)? 

I happen to think the second. 

- Is it desirable to have a write-open of a device on a read-only 
fail? I don't think so. You can't open the initial console etc etc. 

- Is it desirable to have access (W_OK) and "open-for-write" return
different results? I don't think so. 

- Are there other systems that adhere to the standard as written?

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
