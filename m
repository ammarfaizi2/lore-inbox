Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265496AbRFVTkZ>; Fri, 22 Jun 2001 15:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265499AbRFVTkP>; Fri, 22 Jun 2001 15:40:15 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:5641 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265496AbRFVTj4>; Fri, 22 Jun 2001 15:39:56 -0400
Message-Id: <200106221939.f5MJdjU78255@aslan.scsiguy.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Sat, 23 Jun 2001 03:52:04 +1000."
             <8630.993232324@ocs3.ocs-net> 
Date: Fri, 22 Jun 2001 13:39:45 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The existing build process for aic7xxx on Linux has several problems.
>
>* Users have to manually select "rebuild firmware".  Relying on users
>  to perform any action other than make *config is unacceptable.  It is
>  far too error prone.

Users don't have to manually select "rebuild firmware".  They can
rely on the generated files already in the aic7xxx directory.  This
is why the option defaults to off.

>* Rebuilding the firmware requires lex, yacc and libdb.  Not everybody
>  has these installed.

Then they shouldn't check the box "rebuild firmware".

>* The check for which libdb to use assumes that the presence of a db.h
>  is enough, but the overlap between glibc-devel and dbx-devel packages
>  means that finding a db.h is not enough, you have to confirm that the
>  corresponding libdb exists.

Such is Linux.  Those who understand what it means to rebuild the
firmware will have the necessary tools, check the box in config,
and have it work.

>* It checks if the firmware is up to date by comparing the timestamps
>  on aic7xxx_seq.h and aic7xxx_reg.h against aic7xxx.seq and
>  aic7xxx.reg.  Alas, when a patch hits those files there is no
>  guarantee which order the files are listed in the patch so the final
>  timestamp order is unreliable.  diff lists files in alphabetical
>  order but other source repository systems can generate patches in any
>  order.  This is a problem for all generated files, not just aic7xxx.

So you might get a harmless warning if you haven't checked the box.  This
is not fatal and I have yet to hear one complaint about it.

>* Shipping files which are also overwritten by users causes problems
>  for source control systems and can cause spurious differences when
>  generating patches.  This is a problem for all generated files, not
>  just aic7xxx.

Those using revision control should know how to use revision control.
The driver is developed under revision control and the current setup
causes me no grief.  Of course, I don't keep the generated files in
revision control because there is no benefit in doing so.  For those
that decide to keep the generated files in revision control, they
should pull any update to the generated files from the vendor (they
are always provided in my patches) and *never check the box*.

>The patch below fixes all of the above issues.  It does not touch the
>aic7xxx code nor sequencer input, just the generated files and the
>kbuild related files.  The patch is approx 100Kb but most of it is the
>rename of aic7xxx_{seq,reg}.h to aic7xxx_{seq,reg}.h_shipped.

I don't see this as an improvement.

>After applying this patch, normal users will not have to worry about
>generating aic7xxx firmware.

This is already true today.

>In particular they will not have to
>select "rebuild firmware" nor will they need lex, yacc or libdb.

Already true today.

>Only people who change one of these files

Today, this only applies to those that *check the rebuild firmware*
box.

What again are you trying to fix?  It looks to me like you are simply
trying to make it harder for people actually working on the aic7xxx
driver to have proper dependencies.

--
Justin
