Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSEJLnO>; Fri, 10 May 2002 07:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313557AbSEJLnN>; Fri, 10 May 2002 07:43:13 -0400
Received: from waste.org ([209.173.204.2]:27052 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S310666AbSEJLnM>;
	Fri, 10 May 2002 07:43:12 -0400
Date: Fri, 10 May 2002 06:42:59 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Erik Andersen <andersen@codepoet.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Paul P Komkoff Jr <i@stingr.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Some useless cleanup
In-Reply-To: <20020509222358.GB8651@codepoet.org>
Message-ID: <Pine.LNX.4.44.0205100635130.20975-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, Erik Andersen wrote:

> On Thu May 09, 2002 at 10:36:50PM +1000, Rusty Russell wrote:
> > Um, why not simply:
> >
> > static inline void set_name(struct task_struct *tsk, const char *name)
> > {
> > 	/* comm is always nul-terminated already */
> > 	strncpy(tsk->comm, name, sizeof(tsk->comm)-1);
> > }
> >
> > Your implementation using snprintf is (wasteful and) dangerous,
> > Rusty.
>
> And both implementations suffer from the fact that if tsk->comm
> were to change from a fixed length array to a char*, allowing
> arbitrarily sized names, you would end up copying very little
> indeed.  :)  What not something more general like:
>
> char * safe_strncpy(char *dst, const char *src, size_t size)
> {
>     dst[size-1] = '\0';
>     strncpy(dst, src, size-1);
> }

If we're gonna do that, we might as well adopt OpenBSD-style strlcpy and
strlcat:

http://www.courtesan.com/todd/papers/strlcpy.html

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

