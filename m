Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbTEMGPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbTEMGPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:15:00 -0400
Received: from holomorphy.com ([66.224.33.161]:4535 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263197AbTEMGO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:14:59 -0400
Date: Mon, 12 May 2003 23:27:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: 2.5.69-mjb1
Message-ID: <20030513062738.GR19053@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <9380000.1052624649@[10.10.2.4]> <20030512132939.GF19053@holomorphy.com> <21850000.1052743254@[10.10.2.4]> <3EBFB82B.8040509@us.ibm.com> <20030513012346.GQ19053@holomorphy.com> <17070000.1052797281@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17070000.1052797281@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, someone wrote:
>> I'm not 100% convinced it DTRT on modern kernels. I vaguely wonder if
>> the following would be more appropriate. Shame the typedef isn't there
>> yet; the _struct suffix is an eyesore.

On Mon, May 12, 2003 at 08:41:22PM -0700, Martin J. Bligh wrote:
> So are the new bits of the patch related to the KSTK_E* bit?
> They don't seem to be ... however, this bit looks really good:

Random incidental cleanups.

At some point in the past, someone wrote:
>> -#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
>> -#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1022])
>> +#define KSTK_EIP(task)	((task)->thread.eip)
>> +#define KSTK_ESP(task)	((task)->thread.esp)

On Mon, May 12, 2003 at 08:41:22PM -0700, Martin J. Bligh wrote:
> Can I assume it's tested, or does it need someone to do that?

Not tested. AFAICT it's returning random garbage somewhere near the
beginning of the kernel stack now but haven't checked the answers
generated at runtime to see if they look valid. This at least vaguely
resembles the intent of the code, but it might actually want
(task)->thread.esp0 or other such nonsense and so on now that I think
about it some more.

At the very least it looks plausible and doesn't perform accesses that
aren't actually on the stack as they're supposed to be when you shrink
the stack to 4KB. AIUI those kinds of out-of-bounds accesses to
potentially freed memory are oopsable with some debugging patches like
manfred's that unmaps freed pages.


-- wli
