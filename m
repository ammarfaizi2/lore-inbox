Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbTGLLuT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 07:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbTGLLuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 07:50:19 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:28427 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S265367AbTGLLuN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 07:50:13 -0400
Date: Sat, 12 Jul 2003 05:04:49 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Bug in open() function (?)
Message-ID: <20030712120449.GB6842@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030712011716.GB4694@bouh.unh.edu> <16143.25800.785348.314274@cargo.ozlabs.ibm.com> <20030712024216.GA399@bouh.unh.edu> <200307112309.08542.jcwren@jcwren.com> <20030711203809.3c320823.akpm@osdl.org> <200307120511.h6C5BCSe017963@turing-police.cc.vt.edu> <20030711222300.7627a811.akpm@osdl.org> <200307120614.h6C6EhSe019742@turing-police.cc.vt.edu> <20030712093708.GA21282@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712093708.GA21282@win.tue.nl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 11:37:08AM +0200, Andries Brouwer wrote:
> On Sat, Jul 12, 2003 at 02:14:43AM -0400, Valdis.Kletnieks@vt.edu wrote:
> 
> > On Fri, 11 Jul 2003 22:23:00 PDT, Andrew Morton said:
> > 
> > > We've lived with it for this long.
> > 
> > Well... you have a point there..
> > 
> > > Given that the behaviour is undefined, the behaviour which we should
> > > implement is clearly "whatever 2.4 is doing".  So let's leave it alone.
> > 
> > I suppose I could live with that *IF* somebody fixes 'man 2 open' to
> > reflect reality.
> 
> Corrections and additions to manpages are always welcome.
> Mail to aeb@cwi.nl .
> 
> 
> (Concerning the topic under discussion, the man page says
> 
>        O_TRUNC
>               If  the  file  already exists and is a regular file
>               and the open mode allows writing (i.e.,  is  O_RDWR
>               or  O_WRONLY) it will be truncated to length 0.  If
>               the file is a FIFO or  terminal  device  file,  the
>               O_TRUNC  flag  is  ignored. Otherwise the effect of
>               O_TRUNC is unspecified.
> 
> which is precisely right. It continues
> 
>                                        (On many Linux versions it
>               will  be  ignored; on other versions it will return
>               an error.)
> 
> where someone may read this as if this is an exhaustive list of
> possibilities. So adding ", or actually do the truncate" will
> clarify.)

I'd be inclined to at least drop the parenthetic, it only
confuses things.  The alternative would be to tie the
parenthetic to the FIFO and device files.

I'll grant that O_RDONLY would cause one to expect that the
file would not be modified in any way so truncating it on a
read-only seems wrong but that does fall under the
definition of undefined so is not contrary to the
documentation.

Anyone depending on undefined behaviour is asking for
trouble.  Given that there is code floating around expecting
O_TRUNC|O_RDONLY to truncate, caution should be applied in
changing this.

I'd suggest replacing this text to match that of SUSv3 which
is much clearer.  Perhaps with the addition of a clause
stating "The use of O_TRUNC in combination with O_RDONLY to
truncate files is deprecated" or something to that effect.

SUSv3:
|	O_TRUNC
|		If the file exists and is a regular file,
|		and the file is successfully opened O_RDWR
|		or O_WRONLY, its length shall be truncated
|		to 0, and the mode and owner shall be
|		unchanged. It shall have no effect on FIFO
|		special files or terminal device files. Its
|		effect on other file types is
|		implementation-defined. The result of using
|		O_TRUNC with O_RDONLY is undefined.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
