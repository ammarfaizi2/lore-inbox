Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269998AbTGLJWa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 05:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270001AbTGLJWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 05:22:30 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:25359 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S269998AbTGLJW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 05:22:28 -0400
Date: Sat, 12 Jul 2003 11:37:08 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, jcwren@jcwren.com,
       linux-kernel@vger.kernel.org
Subject: Re: Bug in open() function (?)
Message-ID: <20030712093708.GA21282@win.tue.nl>
References: <20030712011716.GB4694@bouh.unh.edu> <16143.25800.785348.314274@cargo.ozlabs.ibm.com> <20030712024216.GA399@bouh.unh.edu> <200307112309.08542.jcwren@jcwren.com> <20030711203809.3c320823.akpm@osdl.org> <200307120511.h6C5BCSe017963@turing-police.cc.vt.edu> <20030711222300.7627a811.akpm@osdl.org> <200307120614.h6C6EhSe019742@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307120614.h6C6EhSe019742@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 02:14:43AM -0400, Valdis.Kletnieks@vt.edu wrote:

> On Fri, 11 Jul 2003 22:23:00 PDT, Andrew Morton said:
> 
> > We've lived with it for this long.
> 
> Well... you have a point there..
> 
> > Given that the behaviour is undefined, the behaviour which we should
> > implement is clearly "whatever 2.4 is doing".  So let's leave it alone.
> 
> I suppose I could live with that *IF* somebody fixes 'man 2 open' to
> reflect reality.

Corrections and additions to manpages are always welcome.
Mail to aeb@cwi.nl .


(Concerning the topic under discussion, the man page says

       O_TRUNC
              If  the  file  already exists and is a regular file
              and the open mode allows writing (i.e.,  is  O_RDWR
              or  O_WRONLY) it will be truncated to length 0.  If
              the file is a FIFO or  terminal  device  file,  the
              O_TRUNC  flag  is  ignored. Otherwise the effect of
              O_TRUNC is unspecified.

which is precisely right. It continues

                                       (On many Linux versions it
              will  be  ignored; on other versions it will return
              an error.)

where someone may read this as if this is an exhaustive list of
possibilities. So adding ", or actually do the truncate" will
clarify.)


Concerning the desired behaviour: if I recall things correctly
doing the truncate was old SunOS behaviour, not doing it,
that is, honouring the O_RDONLY, is new Solaris behaviour.
Maybe someone with access to such machines can check.

Software exists that does O_RDONLY | O_TRUNC.

Andries

