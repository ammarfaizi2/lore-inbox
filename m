Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264904AbSJOV0C>; Tue, 15 Oct 2002 17:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264905AbSJOV0B>; Tue, 15 Oct 2002 17:26:01 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:31227 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264904AbSJOVZ6>; Tue, 15 Oct 2002 17:25:58 -0400
Date: Tue, 15 Oct 2002 17:31:53 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] aio updates
Message-ID: <20021015173153.G16156@redhat.com>
References: <200210150117.g9F1HXm26163@msglinux1.mcom.com> <20021015155738.B16156@redhat.com> <3DAC7FA0.3060600@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAC7FA0.3060600@netscape.com>; from jgmyers@netscape.com on Tue, Oct 15, 2002 at 01:50:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 01:50:40PM -0700, John Gardiner Myers wrote:
> Benjamin LaHaise wrote:
> 
> >My 
> >concern is that the way you've implemented NOOP does not allow for all 
> >possible return codes to be passed in due to the error checking the 
> >iocb submit code performs on the inputs.
> >
> Could you provide an example of a possible return code that cannot be 
> passed in?  I know you can't pass a 64 bit return code on a 32 bit 
> platform, but then neither can any other operation.

aio_nbytes is clamped to disallow negative values at present.

> Currently the operation requires a valid fd just like every other 
> operation does, so I don't consider such a failure to be spurious.

Okay, if it is documented, that makes sense.  I just wasn't sure if it 
happened to be an oversight.

> The alternative is to change the aio framework itself to support 
> operations that don't work on fds.  That would move the fget() call and 
> the overflow check to below where it sets req->ki_user_data.  The check 
> for IOCB_CMD_NOOP would then go before the fget() call and overflow check.
> 
> If you think this is the way to go, I can code up patch to do this.

That's a possibility.  I don't like the idea of splitting things out too 
much, as special cases look ugly.  The io_submit interface really does 
assume that the file descriptor exists, and removing that doesn't really 
make sense -- non-file descriptor consuming operations should most likely 
be their own syscalls (imho).  But if you're okay with requiring an fd 
for the NOOP, then that seems alright.  Does anyone else have any thoughts 
on the matter?

		-ben
-- 
"Do you seek knowledge in time travel?"
