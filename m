Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265411AbSJXMGz>; Thu, 24 Oct 2002 08:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbSJXMGz>; Thu, 24 Oct 2002 08:06:55 -0400
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:31650 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S265411AbSJXMGy>; Thu, 24 Oct 2002 08:06:54 -0400
Date: Thu, 24 Oct 2002 14:13:01 +0200 (CEST)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: linux-kernel@vger.kernel.org
cc: Frank.Cornelis@elis.rug.ac.be
Subject: Resource limits
Message-ID: <Pine.LNX.4.44.0210241357350.14267-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Wouldn't it make sense that somewhere in kernel/fork.c:dup_task_struct we 
copy the resource limits as follows.
	int i;
	for (i = 0; i < RLIM_NLIMITS; i++)
		tsk->rlim[i].rlim_cur =
			tsk->rlim[i].rlim_max =
			orig->rlim[i].rlim_cur;
This way a parent process is able to temporary drop some of its limits in 
order to make a restricted child process and restore its resource limits 
afterwards. Currenly it is not possible to make a child process with 
smaller resource limits than the parent process without the parent process 
losing its (hard) max limits (As far as I know, correct me if I'm wrong). 
I could very much use this to control core dumping of child processes in 
a better way. Of course I don't know to what extent this will break 
things. POSIX???...couldn't find anything on it.

Please CC me.

Frank.

