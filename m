Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUJJXNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUJJXNP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 19:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268544AbUJJXNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 19:13:15 -0400
Received: from eth1023.nsw.adsl.internode.on.net ([150.101.206.254]:52945 "EHLO
	naya.ABOOSPLANET.COM") by vger.kernel.org with ESMTP
	id S268541AbUJJXNJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 19:13:09 -0400
Subject: RE: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 11 Oct 2004 09:13:06 +1000
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3D6FC8DFDDD0CE44A3BE652A27AD42A54569@naya.aboosplanet.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Thread-Index: AcStS0S/qdK0Dz2VR0W3R7Sc3DU3xwB0dKXg
From: "Aboo Valappil" <aboo@ABOOSPLANET.com>
To: "Luke Kenneth Casson Leighton" <lkcl@lkcl.net>,
       "Fabiano Ramos" <ramos_fabiano@yahoo.com.br>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the past I looked in to open, read and write a file from a kernel
module.  But problem I faced using the kernel function was that it
checks for the permissions of the file and path against the "current"
process. For eg: open_namei() function ... My requirement was to open
the file regardless of the permissions on the file and also not by
modifying task_struct of the current process to change the permissions
first ! I also wanted not associate the file with the current/any
processes. 

Any ideas on this ?

Then I thought of using a work around and avoid opening files in kernel
mode.

Thanks

Aboo


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Luke Kenneth
Casson Leighton
Sent: Saturday, October 09, 2004 1:35 AM
To: Fabiano Ramos
Cc: linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from
inside kernel

On Fri, Oct 08, 2004 at 10:07:04AM -0300, Fabiano Ramos wrote:
> On Fri, 2004-10-08 at 14:04 +0100, Luke Kenneth Casson Leighton wrote:
> > could someone kindly advise me on the location of some example code
in
> > the kernel which calls one of the userspace system calls from inside
the
> > kernel?
> > 
> > alternatively if this has never been considered before, please could
> > someone advise me as to how it might be achieved?
> > 
> 
> you cannot do that. For every sys_xx there is a do_xx, that can
> be called from inside the kernel.
 
 so, there's a do_rename (yes i found that and ISTRC that when
 i used it i can't exactly remember what the problem was:
 either i got an error code -14 or i got "warning symbol
 do_rename not found" when my module was linked together,
 even though it says EXPORT_SYMBOL(do_rename) in fs/namei.c,
 so i was forced to cut/paste sys_rename)

 and there's a do_open no there isn't, there's filp_open.

 and a do_pread64 no there isn't i had to cut/paste sys_pread64
 which was okay because it's pretty basic, just call vfs_read.

 and a do_mkdir no there isn't so i had to cut/paste that.


 basically what i am doing is writing a file system "proxy"
 module which re-calls back into the filesystem with a prefix
 onto the front of the pathname.

> > [p.s. i found asm/unistd.h, i found the macros syscall012345
> > etc., i believe i don't quite understand what these are for, and
> > may be on the wrong track.]
> 
> These are are available for you to make syscalls from user mode
> without library support (usually that brand new syscall you added).
> They are basically wrappers that expand into C code. _syscallx, 
> where x is the number of arguments the syscall needs.
 
 so, it's for use the other way round.  okay, thanks for keeping me off
 a broken line of enquiry.

 [oh, and i'll be abandoning this line of enquiry _entirely_ if i find
 that supermount-ng can do the same job - namely manage to keep
 userspace programs happy when users rip out media]
 
-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
