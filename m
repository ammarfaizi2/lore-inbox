Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130256AbQJ1PGa>; Sat, 28 Oct 2000 11:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130313AbQJ1PGV>; Sat, 28 Oct 2000 11:06:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45061 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130256AbQJ1PGL>;
	Sat, 28 Oct 2000 11:06:11 -0400
Date: Sat, 28 Oct 2000 16:05:37 +0100
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
Message-ID: <20001028160537.C2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.21.0010270945510.13233-200000@panoramix.bitwizard.nl> <39F96BE1.B9C97C20@uow.edu.au> <20001028141518.A2272@parcelfarce.linux.theplanet.co.uk> <39FAD698.2FF9C8C8@didntduck.org> <20001028145312.B2272@parcelfarce.linux.theplanet.co.uk> <39FADAC9.DC1255D1@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <39FADAC9.DC1255D1@didntduck.org>; from bgerst@didntduck.org on Sat, Oct 28, 2000 at 09:55:21AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 09:55:21AM -0400, Brian Gerst wrote:
> Yes, but they can be called (and sleep) with module refcount == 0.  This
> is because the file descripter used to perform the ioctl isn't directly
> associated with the network device, thereby not incrementing the
> refcount on open.

According to my proposal, it is perfectly safe to call a function in a module
while the module's use count is 0.  This function would typically look like this:

foo()
{
	MOD_INC_USE_COUNT;

	copy_*_user() (or anything else that sleeps);
	
	MOD_DEC_USE_COUNT;

	return bar;
}

The only difference to the "old" module scheme is that the above currently isn't
safe on SMP systems.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
