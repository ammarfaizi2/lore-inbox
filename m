Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262920AbTCKN0Y>; Tue, 11 Mar 2003 08:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262921AbTCKN0Y>; Tue, 11 Mar 2003 08:26:24 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:8145 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S262920AbTCKN0X>; Tue, 11 Mar 2003 08:26:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Helge Hafting <helgehaf@aitel.hist.no>, Hans Reiser <reiser@namesys.com>
Subject: Re: [RFC] Improved inode number allocation for HTree
Date: Tue, 11 Mar 2003 14:41:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <11490000.1046367063@[10.10.2.4]> <3E6DBE3B.8030007@namesys.com> <3E6DDDD2.3050709@aitel.hist.no>
In-Reply-To: <3E6DDDD2.3050709@aitel.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030311133705.2157A102100@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11 Mar 03 14:00, Helge Hafting wrote:
> Hans Reiser wrote:
> > Let's make noatime the default for VFS.
> >
> > Daniel Phillips wrote:
>
> [...]
>
> >> If I were able to design Unix over again, I'd state that if you don't
> >> lock a directory before traversing it then it's your own fault if
> >> somebody changes it under you, and I would have provided an interface
> >> to inform you about your bad luck.  Strictly wishful thinking.
> >> (There, it feels better now.)
>
> I'm happy nobody _can_ lock a directory like that.  Think of it - unable
> to create or delete files while some slow-moving program is traversing
> the directory?  Ouch.  Plenty of options for DOS attacks too.
> And how to do "rm *.bak" if rm locks the dir for traversal?

<wishful thinking>
Now that you mention it, just locking out create and rename during directory 
traversal would eliminate the pain.  Delete is easy enough to handle during 
traversal.  For a B-Tree, coalescing could simply be deferred until the 
traversal is finished, so reading the directory in physical storage order 
would be fine.  Way, way cleaner than what we have to do now.
</wishful thinking>

Regards,

Daniel
