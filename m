Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVEPUXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVEPUXY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVEPUUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:20:23 -0400
Received: from serv4.servweb.de ([82.96.83.76]:34540 "EHLO serv4.servweb.de")
	by vger.kernel.org with ESMTP id S261849AbVEPURJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:17:09 -0400
Date: Mon, 16 May 2005 22:17:04 +0200
From: Patrick Plattes <patrick@erdbeere.net>
To: linux-kernel@vger.kernel.org
Subject: semaphore understanding: sys_semtimedop()
Message-ID: <20050516201704.GA9836@erdbeere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i have a question about this little code snippet, found in
sys_semtimedop() (ipc/sem.c):

        for (sop = sops; sop < sops + nsops; sop++) {
                if (sop->sem_num >= max)
                        max = sop->sem_num;
                if (sop->sem_flg & SEM_UNDO)
                        undos++;
                if (sop->sem_op < 0)
                        decrease = 1;
                if (sop->sem_op > 0)
                        alter = 1;
        }
        alter |= decrease;

The variable decrease will never be used again in this 
function, so why this intricate code? Isn't this much easier and works
also:

        for (sop = sops; sop < sops + nsops; sop++) {
                if (sop->sem_num >= max)
                        max = sop->sem_num;
                if (sop->sem_flg & SEM_UNDO)
                        undos++;
                if (sop->sem_op != 0)
                        alter = 1;
        }

Maybe i'm totally wrong, so please correct me and don't shoot me up,
'cause i'm not a os developer.

Thanks,
  Patrick
