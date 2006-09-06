Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWIFPh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWIFPh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWIFPh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:37:29 -0400
Received: from ns.nankai.edu.cn ([202.113.16.11]:36224 "HELO
	mail.nankai.edu.cn") by vger.kernel.org with SMTP id S1751086AbWIFOLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:11:17 -0400
Message-ID: <357552113.05297@mail.nankai.edu.cn>
X-EYOUMAIL-SMTPAUTH: struggle@mail.nankai.edu.cn
Message-ID: <44FED70F.6080208@mail.nankai.edu.cn>
Date: Wed, 06 Sep 2006 22:11:27 +0800
From: Bo Yang <struggle@mail.nankai.edu.cn>
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

