Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUFUOMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUFUOMH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 10:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266241AbUFUOMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 10:12:07 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:11908 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264113AbUFUOMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 10:12:01 -0400
Subject: RE: [PATCH] Handle non-readable binfmt misc executables
From: Albert Cahalan <albert@users.sf.net>
To: "Zach, Yoav" <yoav.zach@intel.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <2C83850C013A2540861D03054B478C060416C175@hasmsx403.ger.corp.intel.com>
References: <2C83850C013A2540861D03054B478C060416C175@hasmsx403.ger.corp.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1087818586.8185.1006.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Jun 2004 07:49:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-21 at 07:31, Zach, Yoav wrote:
> >From: Albert Cahalan [mailto:albert@users.sourceforge.net] 

> >So the content of /proc/*/cmdline is correct?
> 
> After the translator fixes it - yes.
> 
> >At a minimum, you will have a problem at startup.
> >The process might be observed before you fix argv.
> 
> Right. It might happen once in a (long) while that
> 'ps -f' doesn't show the correct command line. 

So this is a hole in the emulation.

> >It seems cleaner to use some other mechanism.
> >Assuming your interpreter is ELF, ELF notes are good.
> 
> Using ELF notes means changing the binaries, which is not
> suitable for cases where the use of translator for running
> the binaries is not 'known' to the binaries. For example,
> an administrator might start using a translator to enhance
> performance of existing binaries. In such a case, re-building
> the binaries will probably be out of the question.

No. Well, the translator would change. The old i386
binaries would not.

ELF notes are supplied by the kernel. They provide
data like USER_HZ, the UID, a flag to indicate that
ld.so must take setuid-type precautions, and so on.
ELF notes are on the stack, beyond the environment.

> >You might use prctl().
> 
> Do you mean enhancing sys_prctl to allow for fixing 
> the argv ? 

No. I mean enhancing sys_prctl to allow asking for
the file descriptor number. That way, argv doesn't
need to get mangled in the first place.

I'm sure there are many other good ways to pass the
file descriptor number to the interpreter.


