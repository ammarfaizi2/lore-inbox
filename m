Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUENP5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUENP5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 11:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUENP5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 11:57:48 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:26030 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261604AbUENP5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 11:57:46 -0400
Message-ID: <40A4EC72.2020209@myrealbox.com>
Date: Fri, 14 May 2004 08:57:38 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       luto@myrealbox.com, Chris Wright <chrisw@osdl.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] capabilites, take 2
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <fa.mu5rj3d.24gtbp@ifi.uio.no>
In-Reply-To: <fa.mu5rj3d.24gtbp@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Smalley wrote:

> On Fri, 2004-05-14 at 08:03, Albert Cahalan wrote:
> 
>>This would be an excellent time to reconsider how capabilities
>>are assigned to bits. You're breaking things anyway; you might
>>as well do all the breaking at once. I want local-use bits so
>>that the print queue management access isn't by magic UID/GID.
>>We haven't escaped UID-as-priv if server apps and setuid apps
>>are still making UID-based access control decisions.
> 
> 
> Capabilities are a broken model for privilege management; try RBAC/TE
> instead.  http://www.securecomputing.com/pdf/secureos.pdf has notes
> about the history and comparison of capabilities vs. TE.
> 
> Instead of adding new capability bits, replace capable() calls with LSM
> hook calls that offer you finer granularity both in operation and in
> object-based decisions, and then use a security module like SELinux to
> map that to actual permission checks.  SELinux provides a framework for
> defining security classes and permissions, including both definitions
> used by the kernel and definitions used by userspace policy enforcers
> (ala security-enhanced X).
> 

Thanks -- turning brain back on, SELinux is obviously better than any
fine-grained capability scheme I can imagine.

So unless anyone convinces me you're wrong, I'll stick with just
fixing up capabilities to work without making them finer-grained.

--Andy
