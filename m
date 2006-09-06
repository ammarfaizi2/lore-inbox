Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWIFPgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWIFPgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWIFPgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:36:23 -0400
Received: from ns.nankai.edu.cn ([202.113.16.11]:47615 "HELO
	mail.nankai.edu.cn") by vger.kernel.org with SMTP id S1751011AbWIFOJP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:09:15 -0400
Message-ID: <357551991.05297@mail.nankai.edu.cn>
X-EYOUMAIL-SMTPAUTH: struggle@mail.nankai.edu.cn
Message-ID: <44FED695.9030501@mail.nankai.edu.cn>
Date: Wed, 06 Sep 2006 22:09:25 +0800
From: =?GB2312?B?0e6yqA==?= <struggle@mail.nankai.edu.cn>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sleep for ever ?
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
    Take a look at following code :

DECLARE_WAITQUEUE(wait, current);

add_wait_queue(q, &wait);
while (!condition) {
        /* if there is an interrupt here , and the interrupt
           is just the one the sleeping process wait
           for , is this process sleep for the interrupt
           for ever ?*/
        set_current_state(TASK_INTERRUPTIBLE);
        if (signal_pending(current))
                /* handle signal */
        schedule();
}
set_current_state(TASK_RUNNING);
remove_wait_queue(q, &wait);

Suppose the process just want to sleep for an hardware
event , but before the set_current_state() call , the event
come , is the process sleep for ever ?

