Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbREVNet>; Tue, 22 May 2001 09:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbREVNej>; Tue, 22 May 2001 09:34:39 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:29588 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S261685AbREVNe0>; Tue, 22 May 2001 09:34:26 -0400
Date: Tue, 22 May 2001 09:33:43 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Pavel Machek <pavel@suse.cz>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010522093342.E6103@cs.cmu.edu>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Alexander Viro <viro@math.psu.edu>, Pavel Machek <pavel@suse.cz>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	Matthew Wilcox <matthew@wil.cx>, Andrew Clausen <clausen@gnu.org>,
	Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <E151xfH-0000xg-00@the-village.bc.nu> <Pine.LNX.4.31.0105211503560.10331-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.31.0105211503560.10331-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, May 21, 2001 at 03:10:32PM -0700
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 03:10:32PM -0700, Linus Torvalds wrote:
> That, in turn, might be as simple as changing the ioctl incoming arguments
> of <cmd,arg> into a structure like <type,cmd,inbuf,inlen,outbuf,outlen>.

At least make sure that the 'kioctl' returns the number of bytes placed
into the output buffer, as userspace doesn't necessarily know how much
data would be returned. Coda's kernel module forwards control data up to
userspace and uses a reasonably messy 'pioctl' wrapper (also used by AFS
afaik) around an ioctl to inform the kernel module of how much data to
copy through.

something like,

    ssize_t kioctl(int fd, int type, int cmd, void *inbuf, size_t inlen,
		   void *outbuf, size_t outlen);

As far as functionality and errors it works like read/write in a single
call, pretty much what Richard proposed earlier with a new 'transaction'
syscall. Maybe type is not needed, and cmd can be part of the inbuf in
which case it would be identical. I guess that type is introduced to
resolve existing ioctl number collisions.

Jan

