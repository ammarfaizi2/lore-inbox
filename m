Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbSLKTed>; Wed, 11 Dec 2002 14:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbSLKTed>; Wed, 11 Dec 2002 14:34:33 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35083
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267235AbSLKTec>; Wed, 11 Dec 2002 14:34:32 -0500
Subject: Re: 2.5 Changes doc update.
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021211172559.GA8613@suse.de>
References: <20021211172559.GA8613@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1039635742.833.93.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 14:42:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 12:25, Dave Jones wrote:

Nice work, Dave.

> - The bdflush() system call is still there and still just causes
>   the calling process to exit.  This strangeness is presumably there
>   to support people whose initscripts are trying to start the obsolete
>   'update' daemon. It's likely this will become deprecated and usage of
>   this will start logging messages to syslog.

This is now the case in 2.5-mm - bdflush() is deprecated and will print
a stern warning on use.

I suspect this will move to mainline shortly.

> Need checking.
> ~~~~~~~~~~~~~~
> - Someone reported evolution locks up when calender/tasks/contacts is selected.
>   Further digging has revealed a change to the getpeername syscall changed
>   behaviour. See http://lists.ximian.com/archives/public/evolution-hackers/2002-October/005218.html
>   for a patch to ORBit.

Yes, Evolution is broken.  The problem is actually ORBit.  I have talked
to Elliot Lee about this and we are not sure whether it is the kernel's
or ORBit's fault.  I originally thought it was ORBit's, but it is
looking like the kernel's to be honest.  The behavior of getpeername()
wrt to sun_path seems to of changed.  If any networking hacker wants to
look into it, please do :)

In the mean time, you CAN fix the problem by patching ORBit.  I have a
patch and RPM packages available at:

	http://tech9.net/rml/orbit/

Which works just fine for me.

	Robert Love

