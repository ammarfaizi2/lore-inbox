Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030617AbWFVGjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030617AbWFVGjb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030622AbWFVGjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:39:31 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:22203 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030617AbWFVGjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:39:31 -0400
Date: Thu, 22 Jun 2006 02:34:46 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: fs/binfmt_aout.o, Error: suffix or operands invalid for
  `cmp' [was Re: 2.6.1
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>
Message-ID: <200606220238_MC3-1-C321-1AC2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Morton wrote:
In-Reply-To: <4499BDB4.6060503@zytor.com>

On Wed, 21 Jun 2006 14:44:20 -0700, H. Peter Anvin wrote:

> Andrew Morton wrote:
> > On Wed, 21 Jun 2006 23:16:17 +0200
> > Mattia Dongili <malattia@linux.it> wrote:
> > 
> >> On Wed, Jun 21, 2006 at 01:42:15PM -0700, Andrew Morton wrote:
> >>> On Wed, 21 Jun 2006 21:39:32 +0200
> >>> Mattia Dongili <malattia@linux.it> wrote:
> >>>
> >>>> Thanks, this is fixed, but I have a new failure:
> >>>>   CC [M]  fs/xfs/support/move.o
> >>>>   CC [M]  fs/xfs/support/uuid.o
> >>>>   LD [M]  fs/xfs/xfs.o
> >>>>   CC      fs/dnotify.o
> >>>>   CC      fs/dcookies.o
> >>>>   LD      fs/built-in.o
> >>>>   CC [M]  fs/binfmt_aout.o
> >>>> {standard input}: Assembler messages:
> >>>> {standard input}:160: Error: suffix or operands invalid for `cmp'
> >>>> make[1]: *** [fs/binfmt_aout.o] Error 1
> >>>> make: *** [fs] Error 2
> >>> what the heck?  Can you do `make fs/binfmt_aout.s' then send the relevant
> >>> parts of that file?
> >> I can't really tell which is the relevant part other than line 160 :)
> >> Full file available here:
> >> http://oioio.altervista.org/linux/binfmt_aout.s
> >>
> > 
> > It's complaining about this:
> > 
> > #APP
> >         addl %ecx,%eax ; sbbl %edx,%edx; cmpl %eax,$-1073741824; sbbl $0,%edx   # dump.u_dsize, sum, flag,
> > #NO_APP
> 
> The cmpl should have its arguments reversed.  It's quite possible some versions of the 
> assembler accepts the form given, but they're wrong (and doubly confusing when used as 
> input to sbb.)

This was built with gcc 4.0.4 20060507 (prerelease).

I don't normally build a.out support, but I just tried and it compiled
fine with gcc 4.1.1.  SO this is probably a compiler bug (almost certainly
given that it generated illegal assembler code.)

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
