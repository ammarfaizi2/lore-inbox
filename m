Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314420AbSEIWX7>; Thu, 9 May 2002 18:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSEIWX7>; Thu, 9 May 2002 18:23:59 -0400
Received: from codepoet.org ([166.70.14.212]:27787 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S314420AbSEIWX5>;
	Thu, 9 May 2002 18:23:57 -0400
Date: Thu, 9 May 2002 16:23:58 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Some useless cleanup
Message-ID: <20020509222358.GB8651@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020509102841.GA1125@stingr.net> <20020509223650.2d7a9f6a.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 09, 2002 at 10:36:50PM +1000, Rusty Russell wrote:
> Um, why not simply:
> 
> static inline void set_name(struct task_struct *tsk, const char *name)
> {
> 	/* comm is always nul-terminated already */
> 	strncpy(tsk->comm, name, sizeof(tsk->comm)-1);
> }
> 
> Your implementation using snprintf is (wasteful and) dangerous,
> Rusty.

And both implementations suffer from the fact that if tsk->comm
were to change from a fixed length array to a char*, allowing
arbitrarily sized names, you would end up copying very little
indeed.  :)  What not something more general like:

char * safe_strncpy(char *dst, const char *src, size_t size)
{
    dst[size-1] = '\0';
    strncpy(dst, src, size-1);
}

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
