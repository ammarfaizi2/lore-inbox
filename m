Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263673AbUDUUKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbUDUUKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 16:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263674AbUDUUKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 16:10:40 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:12739 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263673AbUDUUKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 16:10:39 -0400
Subject: Re: compute_creds fixup in -mm
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andy Lutomirski <luto@stanford.edu>
Cc: Chris Wright <chrisw@osdl.org>, Andy Lutomirski <luto@myrealbox.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4086CD7A.8060303@stanford.edu>
References: <20040421010621.L22989@build.pdx.osdl.net>
	 <4086AEFC.5010002@myrealbox.com>
	 <1082571199.9213.61.camel@moss-spartans.epoch.ncsc.mil>
	 <20040421112827.O21045@build.pdx.osdl.net>
	 <1082572971.9213.75.camel@moss-spartans.epoch.ncsc.mil>
	 <4086CD7A.8060303@stanford.edu>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1082578211.9213.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 21 Apr 2004 16:10:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-21 at 15:37, Andy Lutomirski wrote:
> I was worried about sid changing but uid and caps staying the same if
> a ptrace_detach or _exit happens between the cap_bprm_apply_creds call
> and the rest of selinux_bprm_apply_creds.  Remember the sendmail bug --
> program failure due to lack of capabilities can cause privilege leaks
> (in this case selinux sid leaks).

That particular issue shouldn't be a problem, as SELinux security
transitions aren't controlled by Linux capabilities and SELinux
specifically controls code execution (both entry into a domain and
ability to execute anything else without changing domains).  However, I
do agree that it could yield an unexpected failure in the program that
would be harmful, so I'm in favor of checking the state only once.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

