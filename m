Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262638AbREVQbE>; Tue, 22 May 2001 12:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262629AbREVQay>; Tue, 22 May 2001 12:30:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:55567 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262628AbREVQap>; Tue, 22 May 2001 12:30:45 -0400
Date: Tue, 22 May 2001 09:30:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Pavel Machek <pavel@suse.cz>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <20010522093342.E6103@cs.cmu.edu>
Message-ID: <Pine.LNX.4.21.0105220927170.19531-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 May 2001, Jan Harkes wrote:
> 
> something like,
> 
>     ssize_t kioctl(int fd, int type, int cmd, void *inbuf, size_t inlen,
> 		   void *outbuf, size_t outlen);
> 
> As far as functionality and errors it works like read/write in a single
> call, pretty much what Richard proposed earlier with a new 'transaction'
> syscall. Maybe type is not needed, and cmd can be part of the inbuf in
> which case it would be identical.

I'd rather have type and cmd there, simply because right now the
"cmd" passed in to the ioctl is not well-defined, as several different
drivers use the same numbers for different things (which is why I want to
expand that to <type,cmd> to get uniqueness).

Also, I think the cmd is separate from the data, so I don't think it
necessarily makes sense to mix the two. Even if we want to have an ASCII
command, I'd think that should be separate from the arguments, ie we'd
have 

	ssize_t kioctl(int fd, const char *cmd, const void *inbuf ...

instead of trying to mix them. This is especially true as the
"inbuf" would be a user-mode pointer, while "cmd" would come from kernel
space (whether in the form of a <type,subcmd> number pair or as a kernel
string).

		Linus

