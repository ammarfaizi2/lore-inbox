Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbREWSDO>; Wed, 23 May 2001 14:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263194AbREWSCy>; Wed, 23 May 2001 14:02:54 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:62304 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263193AbREWSCo>; Wed, 23 May 2001 14:02:44 -0400
Date: Wed, 23 May 2001 19:02:22 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [patch] s_maxbytes handling
Message-ID: <20010523190222.J27177@redhat.com>
In-Reply-To: <3B0A7C0F.C824FDB5@uow.edu.au> <E152Dik-00021y-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E152Dik-00021y-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 22, 2001 at 04:05:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 22, 2001 at 04:05:14PM +0100, Alan Cox wrote:

> > The s_maxbytes logic is different from the
> > MAX_NON_LFS logic:
> >         if ( pos + count > MAX_NON_LFS && !(file->f_flags&O_LARGEFILE)) {
> >                 if (pos >= MAX_NON_LFS) {
> >                         send_sig(SIGXFSZ, current, 0);
> >                         goto out;
> >                 }

> The spec says of write
>      [EFBIG]
>           The file is a regular file, nbyte is greater than 0 and the
>           starting position is greater than or equal to the offset
>           maximum established in the open file description associated
>           with fildes.
> 
> Which seems to say to me that if we write > 0 bytes and we start at or
> on the boundary we should error - which would agree with your change.

SuS also states

  If a write() requests that more bytes be written than there is room
  for (for example, the ulimit or the physical end of a medium), only as
  many bytes as there is room for will be written. For example, suppose
  there is space for 20 bytes more in a file before reaching a limit. A
  write of 512 bytes will return 20. The next write of a non-zero number
  of bytes will give a failure return (except as noted below)  and the
  implementation will generate a SIGXFSZ signal for the thread.

so SIGXFSZ plus -EFBIG returned would appear to be the correct
behaviour.  That's certainly what 2.2 used to when it encountered such
limits.

Cheers,
 Stephen
