Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129588AbQK0NmR>; Mon, 27 Nov 2000 08:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130879AbQK0NmH>; Mon, 27 Nov 2000 08:42:07 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:12548 "EHLO zikova.cvut.cz")
        by vger.kernel.org with ESMTP id <S129588AbQK0Nl6>;
        Mon, 27 Nov 2000 08:41:58 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Mon, 27 Nov 2000 14:11:36 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: OOps in exec_usermodehelper
X-mailer: Pegasus Mail v3.40
Message-ID: <E0CA73F3362@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have one small problem with 2.4.0-test11 and exec_usermodehelper.
When vmware modules shutdown (specifically vmnet-netifup), kernel tries
to load some module through call_usermodehelper, but unfortunately
from task which has current->files == NULL.

  So it prints message:
  
waitpid(19457) failed, -512

  and then it oopses in
  
for (i = 0; i < current->files->max_fds; i++) {
  if (current->files->fd[i]) close(i);
}

(In log, there is first waitpid, and then oopses from current->files == NULL,
which I do not quite understand).

Should I look into this more deeply, or is correct fix just add

if (current->files) {
  for (i = 0; ..... ) ...
}

into exec_usermodehelper?
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
