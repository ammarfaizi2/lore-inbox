Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSKTRry>; Wed, 20 Nov 2002 12:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbSKTRry>; Wed, 20 Nov 2002 12:47:54 -0500
Received: from auto-matic.ca ([216.209.85.42]:12809 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261593AbSKTRrx>;
	Wed, 20 Nov 2002 12:47:53 -0500
Date: Wed, 20 Nov 2002 13:02:27 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Steven French <sfrench@us.ibm.com>, acc@CS.Stanford.EDU,
       linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 16 more potential buffer overruns in 2.5.48
Message-ID: <20021120180227.GA30331@mark.mielke.cc>
References: <OFF1AA16C4.904AD55A-ON87256C77.00529B26@us.ibm.com> <3DDBC230.6000908@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDBC230.6000908@nortelnetworks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 12:11:12PM -0500, Chris Friesen wrote:
> Steven French wrote:
> > As long as unsigned char can never go above 255 the code should
> >work.   It might have be more readable if it were defined as a  __u8
> >instead of an unsigned char.
> Technically there is nothing that guarantees that an unsigned char is <= 
> 8 bytes in size (although in practice it often is the case).
> __u8 would definately be the way to go.

I believe C99 defines 'char' as the smallest addressable unit of
memory. Meaning -- it would be difficult to define 'u8' where 'char'
was larger than 8 bits. This is why the wchar_t stuff came about.

Is is doubtful than any new hardware would be made so difficult to
port code to. Older hardware that used 6 bit bytes (among other sizes)
should be obsoleted.

That being said... the code should probably check the size, and allow
the host compiler to choose whether or not to optimize the check away.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

