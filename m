Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129749AbQKWLD3>; Thu, 23 Nov 2000 06:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129765AbQKWLDS>; Thu, 23 Nov 2000 06:03:18 -0500
Received: from styx.suse.cz ([195.70.145.226]:10742 "EHLO kerberos.suse.cz")
        by vger.kernel.org with ESMTP id <S129749AbQKWLDG>;
        Thu, 23 Nov 2000 06:03:06 -0500
Date: Thu, 23 Nov 2000 11:32:48 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rogier Wolff <R.E.Wolff@bitwizard.nl>
Cc: Peter Samuelson <peter@cadcamlab.org>,
        Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
Message-ID: <20001123113248.A2897@suse.cz>
In-Reply-To: <20001122234047.N2918@wire.cadcamlab.org> <200011230822.JAA05965@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011230822.JAA05965@cave.bitwizard.nl>; from R.E.Wolff@bitwizard.nl on Thu, Nov 23, 2000 at 09:22:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 09:22:09AM +0100, Rogier Wolff wrote:
> Peter Samuelson wrote:
> 
> > > +int loopback = 0;
> > > +int fs_debug = 0;
> > > +struct fs_dev *fs_boards = NULL;
>  
> > Aside from the 'static' issue already mentioned, these should be left
> > uninitialized.  ('gcc -fassume-bss-zero' would be nice, but then again
> > in userspace it rarely matters.)
> 
> Hi Peter, thanks for the feedback. 
> 
> Actually, I have an opinion on this matter: If the initialization
> value doesn't really matter that much, I like leave out the
> initialization, as you suggest.
> 
> However, if my code assumes that the compiler needs to initialize the
> variable one way or another, I want to put in the initialization, even
> if that means an "= 0;" which is already the default.
> 
> This is a form of documentation.

If it didn't matter in the object code, it would be just documentation.
But uninitialized variables are put into the .bss segment, which is not
included in the object (and is assumed to be zero on start), while
initialized ones (even to zero) are put into the .data segment, which
*is* in the object file.

Thus a difference of 12 bytes code size in your case (on a 32 bit system).

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
