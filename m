Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVJONTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVJONTx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 09:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVJONTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 09:19:53 -0400
Received: from [82.138.41.32] ([82.138.41.32]:26506 "EHLO foo.vault.bofh.ru")
	by vger.kernel.org with ESMTP id S1751140AbVJONTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 09:19:53 -0400
From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
To: linux-kernel@vger.kernel.org
Subject: VFS: file-max limit 50044 reached
Date: Sat, 15 Oct 2005 17:19:46 +0400
Message-ID: <87fyr2ape5.fsf@foo.vault.bofh.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This program:

#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

int main (void)
{
	int f, j;
	
	j = 0;
	while (1) {
		f = open ("/dev/null", O_RDONLY);
		if (f == -1) {
			fprintf (stderr,"open (%i): %s\n", j, strerror (errno));
			abort ();
		}
		close (f);
		j ++;
	}
	return 0;
}


fails on 2.6.14-rc4 kernel with this message:

$ ./a.out 
VFS: file-max limit 50044 reached
open (55499): Too many open files in system
Aborted
$ 

This problem was reproduced on i386 and amd64 with
kernels 2.6.14-rc1 .. 2.6.14-rc4-git4
