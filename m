Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263473AbTJBRbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 13:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTJBRbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 13:31:25 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:13448
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263473AbTJBRbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 13:31:24 -0400
Message-ID: <3F7C60C9.1090108@redhat.com>
Date: Thu, 02 Oct 2003 10:30:49 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: Linus Torvalds <torvalds@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>	 <3F7B9CF9.4040706@redhat.com> <1065067968.741.75.camel@cube>	 <3F7BB073.60509@redhat.com> <1065102539.741.94.camel@cube>
In-Reply-To: <1065102539.741.94.camel@cube>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:

> To the user, maybe. To the admin, no. The admin uses
> fuser and/or lsof to find out why he can't umount.
> If those programs were thread-aware (they are not),
> then they could take many minutes to run.
> 
> In other words, stuff runs faster if we can ban this.
> If not, please suggest a way to make fuser and lsof fast.

Don't you see the flaw in your argumentation?

If lsof/fuser don't always handle this situation correctly you provide a
way for some ill-minded person to hide file descriptors from the view of
sysadmins etc.  You in any case have to handle this case.


It should be possible for a program to easily check whether

  /proc/PID/fd
and
  /proc/self/fd

are the same directory.  If not, add support for that.  Then those
programs only need to iterate over the fd directories and check whether
they are the same.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

