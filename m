Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271691AbTGYGOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 02:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271927AbTGYGOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 02:14:21 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:58790 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271691AbTGYGOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 02:14:19 -0400
Subject: forkpty with streams
From: Andrew Barton <andrevv@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1059089316.8596.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 24 Jul 2003 23:28:36 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got the 2.4 kernel, and I'm trying to use the forkpty() system call
with the standard I/O stream functions. The calls to forkpty() and
fdopen() and fprintf() all return successfully, but the data never seems
to get to the child process. In this simplified example, I am trying to
open a shell in a pseudo terminal and then send it the string "exit\n"
and then wait for it to die. But the shell apparently never sees the
"exit\n", and the parent waits forever.

#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>

main()
{
	int fd;
	pid_t pid;

	pid = forkpty (&fd, 0, 0, 0);
	if (pid == 0) {
		execlp ("sh", "sh", (void *)0);
		_exit (1);
	} else if (pid == -1) {
		return 1;
	} else {
		FILE *F;

		F = fdopen (fd, "w");
		fprintf (F, "exit\n");
		fflush (F);
		wait (0);
	}
	return 0;
}


