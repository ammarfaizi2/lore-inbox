Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278085AbRJ3Uva>; Tue, 30 Oct 2001 15:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278136AbRJ3UvV>; Tue, 30 Oct 2001 15:51:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3716 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278085AbRJ3UvF>;
	Tue, 30 Oct 2001 15:51:05 -0500
Date: Tue, 30 Oct 2001 12:51:34 -0800 (PST)
Message-Id: <20011030.125134.93645850.davem@redhat.com>
To: csr21@cam.ac.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: SPARC and SA_SIGINFO signal handling
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011029190027.A21372@cam.ac.uk>
In-Reply-To: <20011029190027.A21372@cam.ac.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You're doing something really wrong, it works perfectly
fine here:

? cat test.c
#include <stdlib.h>
#include <sys/ucontext.h>
#include <signal.h>

void sigsegv_handler (int signo, siginfo_t *info, void *data) {
	if (info != 0)
		exit(1);
	exit(0);
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
? gcc -o test test.c
? ./test
? echo $?
1
? uname -a
Linux pizda.ninka.net 2.4.14-pre4 #1 SMP Mon Oct 29 18:55:18 PST 2001 sparc64 unknown
?
