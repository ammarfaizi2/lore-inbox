Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWCGSl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWCGSl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWCGSlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:41:25 -0500
Received: from bay104-f11.bay104.hotmail.com ([65.54.175.21]:64521 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751454AbWCGSlZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:41:25 -0500
Message-ID: <BAY104-F1181301637BB5A23C2C731C0EE0@phx.gbl>
X-Originating-IP: [137.207.140.83]
X-Originating-Email: [kamrankarimi@hotmail.com]
From: "Kamran Karimi" <kamrankarimi@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to find all the tasks with a Sys V shm?
Date: Tue, 07 Mar 2006 12:41:21 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Mar 2006 18:41:24.0689 (UTC) FILETIME=[BC8FC410:01C64216]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

In 2.2 kernels one could access the vma segments of a Sys V shared memory 
(shm) through:
shp->attaches. In 2.6 kernels a shm is managed through a file. The question 
is: given a Sys V  key value, how can we find all the tasks that have 
attached the corresponding shm?

We can do the following (with error checking ignored):

    id = ipc_findkey(&shm_ids, key);
    shp = shm_lock(id);

    tsk = find_task_by_pid(shp->shm_cprid);

    vma = tsk->mm->mmap;
    while(vma) {
                 if(vma->vm_file == shp->shm_file)
                  break;
                 vma = vma->vm_next;
    }
    shm_unlock(shp);

But here we only get the vma of the task that created the shm, and not any 
other task who has attached it.

How can we find all the vma structures that represent a shm?

-Kamran


