Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVIWHY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVIWHY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 03:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVIWHY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 03:24:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45228 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750727AbVIWHY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 03:24:26 -0400
To: vgoyal@in.ibm.com
Cc: Dave Anderson <anderson@redhat.com>, Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO
 tokernel   core dumps
References: <20050921065633.GC3780@in.ibm.com>
	<m1mzm6ebqn.fsf@ebiederm.dsl.xmission.com>
	<43317980.D6AEA859@redhat.com>
	<m1d5n1cw89.fsf@ebiederm.dsl.xmission.com>
	<20050922140824.GF3753@in.ibm.com> <4332C87C.9CE47E8D@redhat.com>
	<m1zmq5awsn.fsf@ebiederm.dsl.xmission.com>
	<20050923050950.GC3736@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 23 Sep 2005 01:22:28 -0600
In-Reply-To: <20050923050950.GC3736@in.ibm.com> (Vivek Goyal's message of
 "Fri, 23 Sep 2005 10:39:50 +0530")
Message-ID: <m1hdccb64r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> I got a concern here. Are we not breaking the convention. NT_TASKSTRUCT note
> type represents that task_sturct is stored in note data. elf_core_dump()
> and /proc/kcore already do that (That's a different story that it might not 
> be needed at all). Now if we store a null NT_TASKSTURCT, same note type will
> carry two meanings.

My impression is that NT_TASKSTRUCT has failed to define what actually appears
in the note, as the kernel task_struct is not designed to be exported to
user space, and can change without warning.

Hmm.  NT_TASKSTRUCT feels like an information leak although I haven't
a clue what kernel information you could leak that would be interesting
enough that you could compromise the kernel.  It looks like we should
export NT_TASKSTRUCT until we can decide what goes there.

> IMHO, introducing a null NT_KDUMPINFO will help in that sense, at least 
> there are no two interpretations of same note type. Also it provides the
> scope to add more elements to it if need be.

Agreed.  I was trying too hard to reuse what was already there.

Eric
