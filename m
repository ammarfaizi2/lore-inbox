Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313868AbSDIMRm>; Tue, 9 Apr 2002 08:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313870AbSDIMRl>; Tue, 9 Apr 2002 08:17:41 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:64140 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313868AbSDIMRk>;
	Tue, 9 Apr 2002 08:17:40 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15538.55862.174959.115786@argo.ozlabs.ibm.com>
Date: Tue, 9 Apr 2002 22:10:30 +1000 (EST)
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] SET_PERSONALITY for static executables
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

The SET_PERSONALITY call which made a brief appearance in 2.4.18-rc4
(setting the personality for static binaries in fs/binfmt_elf.c) still
hasn't reappeared as of 2.4.19-pre6.  Here is the patch to put it back
in.

Thanks,
Paul.

diff -urN linux-2.4.19-pre6/fs/binfmt_elf.c linuxppc-merge/fs/binfmt_elf.c
--- linux-2.4.19-pre6/fs/binfmt_elf.c	Sun Apr  7 21:31:19 2002
+++ linuxppc-merge/fs/binfmt_elf.c	Mon Apr  8 22:27:22 2002
@@ -586,6 +586,9 @@
 		    bprm->argc++;
 		  }
 		}
+	} else {
+		/* Executables without an interpreter also need a personality  */
+		SET_PERSONALITY(elf_ex, ibcs2_interpreter);
 	}
 
 	/* Flush all traces of the currently running executable */
