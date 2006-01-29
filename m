Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWA2KEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWA2KEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 05:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWA2KEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 05:04:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2017 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750832AbWA2KEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 05:04:52 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid: Don't hash pid 0.
References: <m1ek2rfsu9.fsf@ebiederm.dsl.xmission.com>
	<20060129003338.28675b78.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 03:04:23 -0700
In-Reply-To: <20060129003338.28675b78.akpm@osdl.org> (Andrew Morton's
 message of "Sun, 29 Jan 2006 00:33:38 -0800")
Message-ID: <m1mzhf8i54.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> pid 0 is never exported to userspace, so hashing it servers no useful
>>  purpose.
>
> uh-huh.
>
>>  Explicitly not hashing pid 0 allows struct pid to be marked as not
>>  hashed, and it allows us to avoid checks if for pid 0 when searching
>>  for processes to signal if pid 0 does not have a special meaning.
>
> Were you planning on sending a patch to avoid those checks?  Because right
> now, this patch looks like a net loss.

Yes.

I just asked for comments on linux-kernel.

Before I go further I feel honor bound to explain my biases.

.....

I am stuck out in no man land on clusters without customary OS services.
Because of their distributed nature I have applications I cannot swap,
can barely suspend, and cannot migrate to other cpus.

To solve that problem it looks to me like I need multiple namespace support
in the OS so when I migrate an application I can capture all of the OS
state the application depends on.

With respect to namespaces I have done some proof of concept implementations
and now that I know that what I want is possible I am working on a production
quality implementation.

I am starting with working my way towards multiple instances of a PID
namespace in the kernel.

What you have seen are the first couple of cleanups to get the worst
of the offenders from being a hinderance.

The next step is to fix the problem of pid reference wrap around,
inside the kernel.  At least this looks to be a promising direction
to solve a rare case and lay the foundation that I will need for
multiple instances of the pid namespace.

I am doing my best to work with all interested parties and to provide
a good solution that works for everyone and not just me.  Taking
everything in small obviously correct patches as I go.

Eric
