Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279377AbRJ2TAj>; Mon, 29 Oct 2001 14:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279381AbRJ2TAa>; Mon, 29 Oct 2001 14:00:30 -0500
Received: from puce.csi.cam.ac.uk ([131.111.8.40]:17326 "EHLO
	puce.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S279377AbRJ2TAR>; Mon, 29 Oct 2001 14:00:17 -0500
Date: Mon, 29 Oct 2001 19:00:27 +0000
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: SPARC and SA_SIGINFO signal handling
Message-ID: <20011029190027.A21372@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Christophe Rhodes <csr21@cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I'm having trouble on SPARC/Linux (of both the 32 and 64 varieties)
getting at the third argument of POSIX sa_sigaction signal handlers.

Consider the following code (a simplified version of what I'm actually
trying to do):
--- Cut here ---
#include <stdlib.h>
#include <sys/ucontext.h>
#include <signal.h>

void sigsegv_handler (int signo, siginfo_t *info, void *data) {
  return;
}

int main () {
  int *foo;
  struct sigaction sa;

  sa.sa_sigaction = sigsegv_handler;
  sa.sa_flags = SA_SIGINFO | SA_RESTART;
  sigaction(SIGSEGV, &sa, NULL);

  foo = NULL;
  *foo = 3;
  return 0;
}
--- Cut here ---
Running under gdb reveals that, whereas on alpha, x86 and ppc the
third argument to sigsegv_handler is a pointer to a ucontext
structure, on sparc and sparc64 I get NULL.

Am I doing something wrong, or is the ucontext argument simply not yet
implemented on the sparc architecture?

Many thanks,

Christophe
-- 
Jesus College, Cambridge, CB5 8BL                           +44 1223 510 299
http://www-jcsu.jesus.cam.ac.uk/~csr21/                  (defun pling-dollar 
(str schar arg) (first (last +))) (make-dispatch-macro-character #\! t)
(set-dispatch-macro-character #\! #\$ #'pling-dollar)
