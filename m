Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbUKWKQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbUKWKQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 05:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUKWKOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 05:14:39 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:22229 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262130AbUKWKOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 05:14:07 -0500
Subject: RE: [PATCH 2.6.9] fork: add a hook in do_fork()
From: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
To: hzhong@cisco.com
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200411230959.AUF58392@mira-sjc5-e.cisco.com>
References: <200411230959.AUF58392@mira-sjc5-e.cisco.com>
Date: Tue, 23 Nov 2004 11:14:03 +0100
Message-Id: <1101204843.6210.100.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 11:21:08,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 11:21:09,
	Serialize complete at 23/11/2004 11:21:09
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 01:59 -0800, Hua Zhong wrote:
> > +	static int fork_hook_id = 0;
> > +
> > +	/* We can set the hook if it's not already used */
> > +	if ((func != NULL) && (fork_hook_id == 0)) {
> > +		fork_hook = func;
> > +		fork_hook_id = id;
> > +		return 0;
> > +	}
> 
> What happens if two modules are calling the same function at the same time?

You are right there is a problem. I need to add a lock.
 
> > +
> > +	if (fork_hook != NULL)
> > +		fork_hook(current->pid, pid);
> > +
> >  	return pid;
> 
> What happens if the module is unloaded between the test and the call to
> fork_hook?

Again you are right and I need to protect that. 

In fact, Greg suggests to use LSM hook and it seams that it does what I
need. So my patch is obsolete now. 

Thank you to everybody for your help,
Best Regards,

Guillaume

