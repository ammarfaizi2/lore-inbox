Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTEIQ5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTEIQ5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:57:49 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:41123 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263322AbTEIQ5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:57:45 -0400
Date: Fri, 9 May 2003 13:07:13 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <200305091309_MC3-1-3826-6B65@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>   Security-sensitive upper layers like virus scanners and loggers
>> would want to do it that way.  The upper layer might even just log
>> the fact that mount happened and then stay out of the way after that.
>
> What makes you say that. If the administrator has full priviledges then
> its kind of irrelevant trying to force anything "for security reasons"

  Check out the NSA's guide for securing Win2k machines sometime.  They
go through all kinds of steps to separate auditing and administration
even though an administrator can get around them and play with the audit
trail anyway.  It raises the bar and removes the defense of plausible
deniability if an admin gets caught (he can hardly claim it was an
'accident' that he granted himself audit privileges and then used them
to tamper with the audit log.)

        1.  Create a new group: Auditors
        2.  Grant these rights to Auditors:
                Take ownership of files; Manage auditing
        3.  Create a new user: Auditor, and put it in these groups:
                Users; Auditors
        4.  Log on as Auditor and take ownership of
                %systemroot%\system32\config\SecEvent.Evt
        5.  Set permissions on that security logfile:
                a. System: full control
                b. Administrators: no access
                c. Auditors: full control
        6.  Now log on as an administrator and take away these rights:
                a. from Administrators: Manage auditing
                b. from Auditors: Take ownership of files
        7.  Enable these extra security options:
                a. crash on audit failure
                b. clear page file on shutdown
                c. full privilege auditing
                d. lots more...

After setting up auditing and ACLs (many pages of directions for that)
the audit duties are done by unprivileged users and administrators
cannot see or alter the audit trail.

  Seems like a lot of useless work given that the admins can grant
themselves any rights they want, doesn't it?
