Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWCVFSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWCVFSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 00:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWCVFSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 00:18:18 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:388 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1750771AbWCVFSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 00:18:17 -0500
Message-ID: <4420DE0C.3080300@vilain.net>
Date: Wed, 22 Mar 2006 17:18:04 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       OpenVZ developers list <devel@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
References: <20060321061333.27638.63963.stgit@localhost.localdomain>	 <1142967011.10906.185.camel@localhost.localdomain>	 <44206B58.5000404@vilain.net> <1142976756.10906.200.camel@localhost.localdomain> <4420885F.5070602@vilain.net>
In-Reply-To: <4420885F.5070602@vilain.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:

>Using the term "task_ns" and ID term "nsid":
>
>  CONFIG_TASK_NS - config option
>  typedef unsigned int nsid_t;
>  struct task_ns
>  task_struct->task_ns
>  task_struct->nsid
>  task_nsid(struct task*) - get an NSID from a task_struct
>  current_nsid - get NSID for current
>  task_ns_state(struct task_ns*, TASK_NS_STATE_FOO) - does task_ns hav...
>  create_task_ns - creates a new context and "hashes" it
>  lookup_task_ns - lookup a task_ns by nsid
>  get_task_ns - increase refcount of a task_ns
>     [...]
>  release_task_ns - decrease the process count for a task_ns
>  task_get_task_ns - like get_task_ns, but by process
>  task_ns_migrate_task - join task to a task_ns
>  task_ns_printk - debugging printk (for CONFIG_TASK_NS_DEBUG)
>  task_ns_hist_alloc_task_ns - history tracing (for CONFIG_TASK_NS_HI...
>  constants:
>     TASK_NS_STATE_FOO - state bits
>     TASK_NS_FLAG_FOO - task_ns flags (to select features)
>     TASK_NS_CAP_FOO - task_ns-specific capabilities
>     TASK_NS_CMD_get_version - task_ns subcommand names
>     TASK_NS_VCI_VERSION
>  
>

One more (apparently suggested by Eric Biederman, though perhaps he had
different ideas about what it would look like)

  CONFIG_SPACE - config option
  typedef unsigned int space_t;
  struct space_info;
  task_struct->space
  task_struct->space_id
  task_space_id(struct task*) - get an SPACE_ID from a task_struct
  current_space_id - get SPACE_ID for current
  space_info_state(struct space_info*, TASK_SPACE_STATE_FOO) - does ...
  create_space - creates a new space and "hashes" it
  lookup_space - lookup a space_info by space_id
  get_space_info - increase refcount of a space_info
  put_space_info - decrease refcount of a space_info
     [...]
  grab_space - increase the process count for a space
  release_space - decrease the process count for a space
  task_get_space_info - like get_space_info, but by process
  space_migrate_task - join task to a space
  space_printk - debugging printk (for CONFIG_SPACE_DEBUG)
  space_hist_alloc_space - history tracing (for CONFIG_SPACE_HI...
  constants:
     SPACE_STATE_FOO - state bits
     SPACE_FLAG_FOO - task_ns flags (to select features)
     SPACE_CAP_FOO - task_ns-specific capabilities
     SPACE_CMD_get_version - task_ns subcommand names
     SPACE_SYSCALL_VERSION


Something like that, anyway.  I must admit "Task Spaces" sounds a little
less dorky than "Task Namespaces", but doesn't roll off the tongue that
well because of the '-sk s..' combination.

Anyone?

Sam.
