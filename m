Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbRJaJnn>; Wed, 31 Oct 2001 04:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280127AbRJaJnY>; Wed, 31 Oct 2001 04:43:24 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:1533 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280126AbRJaJnJ>; Wed, 31 Oct 2001 04:43:09 -0500
Date: Wed, 31 Oct 2001 09:43:43 +0000
From: Christophe Rhodes <csr21@cam.ac.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SPARC and SA_SIGINFO signal handling
Message-ID: <20011031094342.A27520@cam.ac.uk>
In-Reply-To: <20011029190027.A21372@cam.ac.uk> <20011030.125134.93645850.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011030.125134.93645850.davem@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 12:51:34PM -0800, David S. Miller wrote:
> 
> You're doing something really wrong, it works perfectly
> fine here:
> 
> ? cat test.c
> #include <stdlib.h>
> #include <sys/ucontext.h>
> #include <signal.h>
> 
> void sigsegv_handler (int signo, siginfo_t *info, void *data) {
> 	if (info != 0)
        ^^^^

This gets me the siginfo struct; this is fine, and I'm happy with this
part.

However, what I don't see to get at is the usercontext/ucontext
structure containing register contents and so on, which as far as I am
aware should be in the third (data) argument to the sa_sigaction-type
sighandler; that's where I'm getting my problems.

> 		exit(1);
> 	exit(0);
> }
> [...]

Change the info above to data, and...

[ x86 does what I expect... ]
csr21@lambda:~$ uname -a
Linux lambda 2.4.13-ac4 #1 Mon Oct 29 18:26:51 GMT 2001 i686 unknown
csr21@lambda:~$ ./foo
csr21@lambda:~$ echo $?
1

[ sparc doesn't ]
csr21@caligula:~$ uname -a
Linux caligula 2.4.6 #1 SMP Sun Sep 30 16:40:07 BST 2001 sparc64
unknown
csr21@caligula:~$ ./foo
csr21@caligula:~$ echo $?
0

Thanks,

Christophe
-- 
Jesus College, Cambridge, CB5 8BL                           +44 1223 510 299
http://www-jcsu.jesus.cam.ac.uk/~csr21/                  (defun pling-dollar 
(str schar arg) (first (last +))) (make-dispatch-macro-character #\! t)
(set-dispatch-macro-character #\! #\$ #'pling-dollar)
