Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSEVTQT>; Wed, 22 May 2002 15:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSEVTQS>; Wed, 22 May 2002 15:16:18 -0400
Received: from relay1.pair.com ([209.68.1.20]:49160 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S316683AbSEVTQR>;
	Wed, 22 May 2002 15:16:17 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CEBEF97.1BEBF36C@kegel.com>
Date: Wed, 22 May 2002 12:20:55 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "khttpd-users@lists.alt.org" <khttpd-users@alt.org>,
        "linuxppc-embedded@lists.linuxppc.org" 
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: khttpd and tmpfs don't get along?
In-Reply-To: <3CEAF6F2.BB70395D@kegel.com> <20020522095440.A13744@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Tue, May 21, 2002 at 06:40:02PM -0700, Dan Kegel wrote:
> > I've found that khttpd tends to oops when used with tmpfs.
> > The oops tracebacks are not especially informative.
> > So far, I've only verified this with ppc, but I should be
> > able to verify it with x86 soon.
> 
> That's because it abuses do_generic_file_read.  It' the same design mistake
> that also makes loop fail on tmpfs - do_generic_file_read should never have
> been exported from filemap.c..

I see.  Guess I should finally test that tmpfs/loop patch, eh? :-)

I just now crashed Red Hat 7.3 on x86 SMP by compiling in khttpd
and serving files out of a tmpfs.  It crashed with or without my 
earlier patch (http://www.kegel.com/linux/khttpd/khttpd-unbork.patch)
that fixes khttpd crashes with other filesystems.
Guess it wasn't a bug in linuxppc_2_4_devel after all.

I am now switching to ramfs instead of tmpfs to hold my documentroot,
and that should be the end of my khttpd problems.
(There is no disk on the embedded ppc system I'm using, so I have
to use one ram filesystem or another.)
- Dan
