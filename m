Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316568AbSEUIeF>; Tue, 21 May 2002 04:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSEUIeE>; Tue, 21 May 2002 04:34:04 -0400
Received: from imladris.infradead.org ([194.205.184.45]:41737 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316568AbSEUIeD>; Tue, 21 May 2002 04:34:03 -0400
Date: Tue, 21 May 2002 09:33:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020521093357.A6641@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <mailman.1021642692.12772.linux-kernel2news@redhat.com> <200205191212.g4JCCLY25867@Port.imtp.ilyichevsk.odessa.ua> <20020520112232.A8983@devserv.devel.redhat.com> <200205210555.g4L5tfY29889@Port.imtp.ilyichevsk.odessa.ua> <20020521062118.GA13117@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 03:21:18AM -0300, Arnaldo Carvalho de Melo wrote:
> stay, but something like:
> 
> #define copyin(...) (copy_from_user(...) ? -EFAULT : 0)
> #define copyout(...) (copy_to_user(...) ? -EFAULT : 0)
> 
> Like several drivers already have (with these names or with other names)
> would be something interesting, that way we could clean up the ones that
> use this construct and all the others that use the longer
> 'copy_{to,from}_user(...) ? -EFAULT : 0' construct. If the powers that be
> accept this, I'd do the work 8)
> 
> Is it *BSD that have copyin/copyout with this semantic? If so it'd even
> have an extra bonus to make porting a little bit faster... 8)

FreeBSD has:
/* return 0 on success, EFAULT on failure */
int copyin(const void *udaddr, void *kaddr, size_t len);
int copyout(const void *kaddr, void *udaddr, size_t len);

System V and derivates have:
/* return 0 on success, -1 on failure */
int  copyin(const  void  *userbuf, void *driverbuf, size_t cn);
int  copyout(const  void *driverbuf, void *userbuf, size_t cn);

OSF/1 has:
/* return 0 on success, some non-specified error on failure) */
int copyin(caddr_t user_src, caddr_t kernel_dest, u_int bcount);
int copyout(caddr_t kernel_src, caddr_t user_dest, u_int bcount);

