Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWEUAuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWEUAuU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 20:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWEUAuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 20:50:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65222 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932161AbWEUAuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 20:50:17 -0400
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       serue@us.ibm.com, linux-kernel@vger.kernel.org, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, xemul@sw.ru, clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518103430.080e3523.akpm@osdl.org>
	<20060519124235.GA32304@MAIL.13thfloor.at>
	<20060519081334.06ce452d.akpm@osdl.org>
	<1148069089.6623.197.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 20 May 2006 18:48:25 -0600
In-Reply-To: <1148069089.6623.197.camel@localhost.localdomain> (Dave
 Hansen's message of "Fri, 19 May 2006 13:04:49 -0700")
Message-ID: <m1bqtsqk2u.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Fri, 2006-05-19 at 08:13 -0700, Andrew Morton wrote:
>> snapshot/restart/migration worry me.  If they require complete
>> serialisation of complex kernel data structures then we have a problem,
>> because it means that any time anyone changes such a structure they need to
>> update (and test) the serialisation.
>
> The idea of actually serializing kernel data structures keeps me up at
> night.  This is especially true when we already have some method of
> exporting these structures to userspace.

Serialization of kernel data structures is a thorny issue, that
we are far enough away from that we don't need to tackle just yet.
I do consider it a failure to export/import things properly if you
need to use the same kernel version.

For the short term all that is interesting from a checkpoint/restart/migration
perspective is that you can have multiple instances of global identifiers,
pids, sysvipc ids, etc.

> However, the proc-maps/mmap approach would require new interfaces to be
> implemented.  There are plenty of attributes not currently readily
> visible to userspace like VM_NONLINEAR, or resources which are normally
> inaccessible to userspace like deleted files.  Those would need extended
> user/kernel interfaces.

Deleted files are accessible through /proc/<pid>/fd.

Eric
