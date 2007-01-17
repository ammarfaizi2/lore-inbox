Return-Path: <linux-kernel-owner+w=401wt.eu-S1750783AbXAQWcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbXAQWcQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXAQWcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:32:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53631 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbXAQWcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:32:15 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Daniel Hokka Zakrisson <daniel@hozac.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, akpm@osdl.org,
       trond.myklebust@fys.uio.no,
       Linux Containers <containers@lists.osdl.org>
Subject: Re: NFS causing oops when freeing namespace
References: <57238.192.168.101.6.1169029688.squirrel@intranet>
	<m18xg1akmd.fsf@ebiederm.dsl.xmission.com>
	<51072.192.168.101.6.1169039633.squirrel@intranet>
	<20070117185823.GA878@tv-sign.ru> <45AE7705.4040603@fr.ibm.com>
	<20070117194632.GA1071@tv-sign.ru> <45AE87BC.4030404@fr.ibm.com>
Date: Wed, 17 Jan 2007 15:30:16 -0700
In-Reply-To: <45AE87BC.4030404@fr.ibm.com> (Cedric Le Goater's message of
	"Wed, 17 Jan 2007 21:31:56 +0100")
Message-ID: <m1d55d8ex3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:
>
> your first analysis was correct : exit_task_namespaces() should be moved 
> above exit_notify(tsk). It will require some extra fixes for nsproxy 
> though.

I think the only issue is the child_reaper and currently we only have one of
those.  When we really do the pid namespace we are going to have to revisit
this.  My gut feel says that we won't be able to exit our pid namespace until
the process is waited on.  So we may need to break up exit_task_namespace into
individual components.

Eric
