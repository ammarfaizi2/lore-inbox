Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315828AbSEEHdj>; Sun, 5 May 2002 03:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315829AbSEEHdi>; Sun, 5 May 2002 03:33:38 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:29948
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S315828AbSEEHdh>; Sun, 5 May 2002 03:33:37 -0400
Message-ID: <3CD4E04C.33E9518@eyal.emu.id.au>
Date: Sun, 05 May 2002 17:33:32 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8-aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa1 & vm-34: zftape-init.c compile error
In-Reply-To: <20020503203738.E1396@dualathlon.random> <3CD328C5.2C6D389A@eyal.emu.id.au> <20020505010804.GB2392@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Sat, May 04, 2002 at 10:18:13AM +1000, Eyal Lebedinsky wrote:
> > Andrea Arcangeli wrote:
> > >
> > > Full patchkit:
> > > http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa1.gz
> >
> > linux-2.4-pre-aa/drivers/char/ftape/zftape/zftape-init.c fails to build,
> > a declaration is put in an illegal place.
> >
> 
> Why is it illegal to put that before the ifdef instead of after?

In standard C, declarations must precede statements in a block. When the
#if is true, the declaration is exposed, and it is after an assignment,
a syntax error.

The most general solution is to always open a new block if you need a
declaration, but here the code fragment is small enough to not do so
(but one needs to be alert).

#if ...
{
	int	x;
	x = ...
}
#endif


--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
