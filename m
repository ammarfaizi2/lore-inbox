Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUENQi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUENQi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUENQi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:38:28 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:40618 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261672AbUENQiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:38:25 -0400
Subject: Re: [PATCH] capabilites, take 2
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andy Lutomirski <luto@stanford.edu>
Cc: Andy Lutomirski <luto@myrealbox.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, olaf+list.linux-kernel@olafdietsche.de,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <40A4F163.6090802@stanford.edu>
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <fa.mu5rj3d.24gtbp@ifi.uio.no>
	 <40A4EC72.2020209@myrealbox.com>
	 <1084550518.17741.134.camel@moss-spartans.epoch.ncsc.mil>
	 <40A4F163.6090802@stanford.edu>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1084552674.17741.147.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 14 May 2004 12:37:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-14 at 12:18, Andy Lutomirski wrote:
> Does this mean I should trash my 'maximum' mask?
> 
> (I like 'cap -c = sftp-server' so it can't try to run setuid/fP apps.)
> OTOH, since SELinux accomplishes this better, it may not be worth the
> effort.

Not my call to make, but I'm not sure it is worthwhile.  Even filesystem
capabilities are questionable IMHO, as you can already authorize
capabilities based on program and call chain (typically just the
immediate caller's domain, but potentially encoding the entire call
chain in the domain transition rules to track any untrusted components
in the call chain) today using SELinux TE.  Today, the program still has
to be setuid as well, as we currently check both ordinary Linux
capability and SELinux permission for each operation to be conservative,
but eventually we would hope to drop the use of the capability module as
a secondary module and let SELinux manage the privileges entirely (once
the TE policy configuration is fully locked down and userland is fully
aware of SELinux).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

