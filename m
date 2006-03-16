Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWCPWbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWCPWbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWCPWbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:31:13 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:50581 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964866AbWCPWbM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:31:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j2jXr2YfeDYV58GMhBS/1c3wO3n/UvhSLTac8uMFizFW+1S9wPL9gbDi7djUcrJ7wuRjxFWP9uR09YShD0KD5tQ4TMZ/mYkt5tnc9eNcXH8YyMq58NdUpQgPL3tBRjjf34vCH5lT2BSaxMB3jXjMdi1L5Sn64FrBPBWR+Z3A7P0=
Message-ID: <e7aeb7c60603161431m6d873520r2b6754e115e26f80@mail.gmail.com>
Date: Fri, 17 Mar 2006 00:31:10 +0200
From: "Yitzchak Eidus" <ieidus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: puting task to TASK_INTERRUPTIBLE before adding it to an wait queue
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the function worker_thread in kernel 2.6.15.6  first put the task to
TASK_INTERRUPTIBLE and only then add itself to an wait queue:
	set_current_state(TASK_INTERRUPTIBLE);
	while (!kthread_should_stop()) {
		add_wait_queue(&cwq->more_work, &wait);
....
my question is, what will happen if the timeslice for the
worker_thread will finished just before it add itself to the wait
queue?
wont it call schedule() that will find the task is in
TASK_INTERRUPTIBLE state and remove it from the runqueue? ( that what
schedule() should do no? )
and then how will the kernel be able to call to worker_thread ever if
it isnt in any list???
thanks for the comments!
