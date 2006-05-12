Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWELPqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWELPqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWELPqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:46:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17621 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751290AbWELPqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:46:03 -0400
Subject: Re: [PATCH 2/9] nsproxy: incorporate fs namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, dev@sw.ru,
       sam@vilain.net, xemul@sw.ru, clg@fr.ibm.com, frankeh@us.ibm.com
In-Reply-To: <20060512152412.GA11734@sergelap.austin.ibm.com>
References: <29vfyljM-1.2006059-s@us.ibm.com>
	 <20060510021135.GC32523@sergelap.austin.ibm.com>
	 <m1k68uvyhq.fsf@ebiederm.dsl.xmission.com>
	 <20060510132623.GB20892@sergelap.austin.ibm.com>
	 <m1ac9pwves.fsf@ebiederm.dsl.xmission.com>
	 <20060510203449.GA12215@sergelap.austin.ibm.com>
	 <m1ejz1vc2d.fsf@ebiederm.dsl.xmission.com>
	 <20060512152412.GA11734@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 12 May 2006 08:44:41 -0700
Message-Id: <1147448681.6623.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 10:24 -0500, Serge E. Hallyn wrote:
> 
> -       exit_utsname(current);
> -       exit_namespace(current);
> -       exit_nsproxy(current);
> +       exit_task_namespaces(current);
>         current->nsproxy = init_task.nsproxy;
> -       get_nsproxy(current->nsproxy);
> -       get_namespace(current->nsproxy->namespace);
> -       get_uts_ns(current->nsproxy->uts_ns);
> +       get_namespaces(current); 

That really cleans up the main path quite a bit.  Very nice.

For parity with exit_task_namespaces(), should that be called
get_task_namespaces()?

-- Dave

