Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVAGWnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVAGWnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVAGWmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:42:47 -0500
Received: from mail.aknet.ru ([217.67.122.194]:58886 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261683AbVAGWl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:41:57 -0500
Message-ID: <41DF10C8.5060603@aknet.ru>
Date: Sat, 08 Jan 2005 01:44:24 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru> <20041117131552.GA11053@in.ibm.com> <41B1FD4B.9000208@aknet.ru> <20041207055348.GA1305@in.ibm.com> <41B5FA1B.9090507@aknet.ru> <20041209124738.GB5528@in.ibm.com> <41B8A759.80806@aknet.ru> <20050107113732.GB16906@in.ibm.com>
In-Reply-To: <20050107113732.GB16906@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Prasanna S Panchamukhi wrote:
> The patch below fixes this problem.
> Please let me know your comments.
The patch works, thanks. I have no
complains to it, it fixes the problem
it is intended to fix.

The following is just a reminder about
the other problems I mentioned earlier.

This problem is still not addressed:
http://lkml.org/lkml/2004/12/4/48

Also VM86 check should be done before the
"addr" is used I think, is this true?

And dereferencing the pointer to user-space,
like "*addr", is this safe? I thought
get_user() is used for that, was this
intentional?

By the way, maybe it is possible to avoid
the removal race without checking an opcode
at all? Probably by marking the probes as
"removed", and checking the "addr" against
the "removed" ones instead of checking the
opcode? This way you'll avoid any interference
with the debuggers that can also remove their
breakpoints, and also the aforementioned
problem will get fixed automatically.

