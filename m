Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130570AbQJ1ODe>; Sat, 28 Oct 2000 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130694AbQJ1ODY>; Sat, 28 Oct 2000 10:03:24 -0400
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:56297 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S130570AbQJ1ODN>; Sat, 28 Oct 2000 10:03:13 -0400
Message-ID: <39FADAC9.DC1255D1@didntduck.org>
Date: Sat, 28 Oct 2000 09:55:21 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
CC: Andrew Morton <andrewm@uow.edu.au>,
        Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
In-Reply-To: <Pine.LNX.4.21.0010270945510.13233-200000@panoramix.bitwizard.nl> <39F96BE1.B9C97C20@uow.edu.au> <20001028141518.A2272@parcelfarce.linux.theplanet.co.uk> <39FAD698.2FF9C8C8@didntduck.org> <20001028145312.B2272@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Rumpf wrote:
> 
> On Sat, Oct 28, 2000 at 09:37:28AM -0400, Brian Gerst wrote:
> > Philipp Rumpf wrote:
> > >  - you can't copy_(from|to)_user in the module exit function (which would
> > > be copies from/to rmmod anyway)
> >
> > Unfortunately, you need to be able to use copy_*_user() from the network
> > ioctls, and this is the center of the current issue.
> 
> You misunderstood.  The network ioctls aren't module_exit functions, so
> copy_*_user in them is fine.

Yes, but they can be called (and sleep) with module refcount == 0.  This
is because the file descripter used to perform the ioctl isn't directly
associated with the network device, thereby not incrementing the
refcount on open.

-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
