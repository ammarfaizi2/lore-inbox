Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWESTiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWESTiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 15:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWESTiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 15:38:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:38323 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932475AbWESTiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 15:38:19 -0400
Date: Fri, 19 May 2006 14:38:02 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Hua Zhong <hzhong@gmail.com>
Cc: "'Eric W. Biederman'" <ebiederm@xmission.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Herbert Poetzl'" <herbert@13thfloor.at>, serue@us.ibm.com,
       linux-kernel@vger.kernel.org, dev@sw.ru, devel@openvz.org,
       sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-ID: <20060519193802.GB20129@sergelap.austin.ibm.com>
References: <m1iro2yo7f.fsf@ebiederm.dsl.xmission.com> <008201c67b71$fb938db0$493d010a@nuitysystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008201c67b71$fb938db0$493d010a@nuitysystems.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hua Zhong (hzhong@gmail.com):
> > snapshot/restart/migration worry me.  If they require 
> > complete serialisation of complex kernel data structures then 
> > we have a problem, because it means that any time anyone 
> > changes such a structure they need to update (and test) the 
> > serialisation.
> 
> Checkpoint/Restart/Migration could be very complicated if done at OS level (per process/process group/or any subset of an OS). But
> it is much simpler if done on virtual machine level (VMWare/Xen) because there is a natural and clear boundary, and doesn't get
> affected if the OS kernel internal changes.
> 
> It's good to see some progress in supporting virtualization in Linux, but as Andrew put it, some big decisions need to be made
> up-front. One big question is actually how many virtualization technologies Linux should support? Particularly, does it need to
> support both OS-level virtualization and VM-level virtualization? And why? And to what degree?

Because migration can be used for more than one purpose.  One such
purpose is load-balancing large numbers of jobs.  If you have large
numbers of jobs, you do not want the resource overhead of a full OS for
each migrateable job.

The reason it is deemed simpler at the vm level, as you point out, is
that resources are naturally isolated.  The same work which will prepare
the kernel for vserver/openvz functionality will isolate kernel resources
between vserver/containers, making c/r and migration at that level level
much simpler.

thanks,
-serge
