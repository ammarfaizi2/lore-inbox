Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSJQUqS>; Thu, 17 Oct 2002 16:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbSJQUqS>; Thu, 17 Oct 2002 16:46:18 -0400
Received: from code.and.org ([63.113.167.33]:10703 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S262207AbSJQUqQ>;
	Thu, 17 Oct 2002 16:46:16 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: matti.aarnio@zmailer.org, zilvinas@gemtek.lt, linux-kernel@vger.kernel.org
Subject: Re: sendfile(2) behaviour has changed ?
References: <20021016084908.GA770@gemtek.lt>
	<20021016091046.GD9644@mea-ext.zmailer.org>
	<20021016.025935.132073102.davem@redhat.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 17 Oct 2002 16:51:30 -0400
In-Reply-To: <20021016.025935.132073102.davem@redhat.com>
Message-ID: <m3it00zt4d.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: Matti Aarnio <matti.aarnio@zmailer.org>
>    Date: Wed, 16 Oct 2002 12:10:46 +0300
> 
>    On Wed, Oct 16, 2002 at 10:49:08AM +0200, Zilvinas Valinskas wrote:
>    > Is this expected behaviour ? that sendfile(2) on 2.5.4x linux kernel requires
>    > socket as an output fd paramter ? 
>    
>      It has only been intended for output to a TCP stream socket.
> 
> To be honest, I'm not so sure about this.
> 
> For example, I definitely see us supporting this in the
> opposite direction when commodity 10gbit hits the market.
> 
> Initially I thought "sys_receivefile()" but it makes no
> sense when we have a system call that is perfectly capable
> of describing the tcp_socket --> page_cache operation.

 It really needs a new interface for recvfile/copyfile/whatever
anyway, as you can only specify an off_t for the from fd at present.

 Also consider that if you have 2 network sockets you really want a
way to see which did the EAGAIN.

 Which leads to something like...

ssize_t copyfddata(int out_fd, off_t *offset, 
                   int in_fd,  off_t *offset, size_t count, int *in_errno);

...and another for the off64_t API, the errno thing looks crappy but I
think creating EREADAGAIN is even worse (and I just know that won't be
the last if it's done that way) ... unless you can think of another way.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
