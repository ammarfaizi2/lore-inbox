Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290333AbSBORtq>; Fri, 15 Feb 2002 12:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290338AbSBORtj>; Fri, 15 Feb 2002 12:49:39 -0500
Received: from ns.suse.de ([213.95.15.193]:38927 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290333AbSBORtZ>;
	Fri, 15 Feb 2002 12:49:25 -0500
To: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Redundant syscalls?
In-Reply-To: <02021517152700.01701@odyssey.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Feb 2002 18:47:48 +0100
In-Reply-To: Lorenzo Allegrucci's message of "15 Feb 2002 17:31:49 +0100"
Message-ID: <p73vgcyr60r.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci <l.allegrucci@tiscalinet.it> writes:

> I was wondering why do we need fsetxattr(2), fgetxattr(2) etc when we 
> already have setxattr(2), getxattr(2) etc working on file names
> instead of file descriptors.
> truncate(2)/ftruncate(2) is another more traditional example.

The f* variant can be race free. For example you want to stat something
first to make sure it is what you expect it to be and not a symlink
to your /etc/passwd. When you use first stat() and then do random
operation on filename with name there is a small window where someone
could replace the name with something else. This could be security relevant.
fd = open(name, ...); fstat(fd, ..); check fsomething(fd, ...); close(fd);
guarantees that you're always working on the same object without any race 
windows.

-Andi
