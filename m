Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312581AbSDSULp>; Fri, 19 Apr 2002 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312586AbSDSULo>; Fri, 19 Apr 2002 16:11:44 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:3339 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S312581AbSDSULo>; Fri, 19 Apr 2002 16:11:44 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Hanna Linder <hannal@us.ibm.com>
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: Re: 12 way dbench analysis: 2.5.9, dalloc and fastwalkdcache 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Apr 2002 13:11:28 -0700
Message-Id: <E16yejA-00083X-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday Apr 18 17:32:19 2002, hannal@us.ibm.com wrote:
>However, I recently found a deadlock that no one else has been able to
>reproduce. Could you try doing a find on /proc and tell me if it
>deadlocks?  

You somehow lost the call to undo_locked() before calling permission()
in the event that exec_permission_lite() failed. This would cause any
lookup where the first component referred to a dentry with a
permission() operation to deadlock (in the case of find on /proc, it was
doing a chdir("..") from inside /proc/1/fd). The call to undo_locked()
was in earlier versions of your patch.

Paul



