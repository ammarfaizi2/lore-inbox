Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313491AbSDGXCv>; Sun, 7 Apr 2002 19:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313495AbSDGXCu>; Sun, 7 Apr 2002 19:02:50 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:9403 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313491AbSDGXCu>; Sun, 7 Apr 2002 19:02:50 -0400
Message-Id: <5.1.0.14.2.20020408000103.03cda5a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 08 Apr 2002 00:03:06 +0100
To: Muli Ben-Yehuda <mulix@actcom.co.il>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        John Levon <movement@marcelothewonderpenguin.com>,
        "Steven N. Hirsch" <shirsch@adelphia.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020407232339.B10733@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:23 07/04/02, Muli Ben-Yehuda wrote:
>On Sun, Apr 07, 2002 at 09:29:01PM +0100, Alan Cox wrote:
> > > hijacks syscall entries in the sys_call_table as well, because we
> > > want it to work as a module and not require patching the kernel. Our
> > > solution to the module unload race on syscall de-hijacking is simple,
> > > splitting the system call hijacking code into a single small module
> > > which once loaded cannot be unloaded.
> >
> > So your small module can export a function called
> >       patch_syscall(NR_foo, function);
> >
> > Now you can put the arch specific syscall patching code into your small
> > common module and its cleaner anyway ?
>
>Right, this module (syscall_hijack.o) currently has the interface:
>
>int hijack_syscall_before(int syscall_id, func_ptr func);
>int hijack_syscall_after(int syscall_id, func_ptr func);
>
>int release_syscall_before(int syscall_id);
>int release_syscall_after(int syscall_id);
>
>where 'before' and 'after' correspond to a hook which should run
>before the original system call is invoked (allowing it to specify
>that the original system call should not be executed) or after the
>original system call is invoked (allowing it access to its return
>value).
[snip]

So are you coping with someone hijacking YOU as well between calls to 
hijack_syscall_* and release_syscall_*? Or would that trash the caller chain?

 From your interface I would assume yes, but just making sure...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

