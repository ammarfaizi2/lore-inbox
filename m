Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264932AbUFLV6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbUFLV6h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 17:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUFLV6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 17:58:37 -0400
Received: from lakermmtao01.cox.net ([68.230.240.38]:35274 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S264932AbUFLV6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 17:58:35 -0400
In-Reply-To: <20040612144437.V21045@build.pdx.osdl.net>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <20040611201523.X22989@build.pdx.osdl.net> <C636D44C-BC2B-11D8-888F-000393ACC76E@mac.com> <20040612135302.Y22989@build.pdx.osdl.net> <ADFD1FB4-BCB5-11D8-888F-000393ACC76E@mac.com> <20040612144437.V21045@build.pdx.osdl.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A63B46CC-BCBB-11D8-888F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Sat, 12 Jun 2004 17:58:34 -0400
To: Chris Wright <chrisw@osdl.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2004, at 17:44, Chris Wright wrote:
> Typically, objects that LSM cares about include a pointer to opaque
> data (security blob) which describes the security domain for the 
> object.
> See task->security as an example.  It's not clear to me if 
> task->security
> is sufficient and you only need a back pointer to the task or if each
> PAG needs it's own security blob.

Ahh, ok.  In this case, a PAG is an independent object, not directly
associated with any specific task or other PAG, so therefore it will 
likely
need its own security blob.  Currently, in the creation of my PAG I just
copy over the UID from the calling task.  If I was to convert it to use 
LSM,
I guess I should just leave out the UID entirely, and just have a 
pointer
to a security blob.  What is the best way to portray the security blob 
to
user-space, in terms of sys-calls?  I need a way for user-space apps to
change the security context in a similar way as it is changed for a task
or process.  Do you have a link to some documentation on the kernel
API for LSM?  I basically need to copy the current task's security blob
into a new one and be able to compare two contexts to see if one
can affect the other.  Thanks!

> Sounds like an extension to rlimits.  The counters could be stored in
> ->user to limit the userwide number of tokens.

Ok, thank you very much, that's exactly what I need.  I am somewhat
new to kernel development, so finding my way around the structs is
somewhat difficult.  Is there a good guide somewhere on the net that
you can point me to?

Cheers,
Kyle Moffett

