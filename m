Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTFBMhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTFBMhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:37:24 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:36484 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262273AbTFBMhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:37:22 -0400
Subject: Re: [PATCH][LSM] Early init for security modules and various
	cleanups
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@digeo.com>
Cc: Chris Wright <chris@wirex.com>, gj@pointblue.com.pl,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>,
       Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <20030602034419.3776d3b7.akpm@digeo.com>
References: <20030602025450.C27233@figure1.int.wirex.com>
	 <Pine.LNX.4.44.0306021205520.27640-100000@pointblue.com.pl>
	 <20030602030946.H27233@figure1.int.wirex.com>
	 <20030602034419.3776d3b7.akpm@digeo.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1054558223.1053.105.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 08:50:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 06:44, Andrew Morton wrote:
> Chris Wright <chris@wirex.com> wrote:
> >
> > security_capable() returns 0 if that capability bit is set. 
> 
> That's just bizarre.  Is there any logic behind it?

The LSM access control hooks all return 0 on success (i.e. permission
granted) and negative error code on failure, like most of the rest of
the kernel interfaces (e.g. consider permission()).  Hence, the
security_capable() hook returns 0 when the capability is granted to the
specified task.  Naturally, the capable() function (which now internally
calls security_capable) preserves the old interface, and most callers
still invoke it rather than directly calling security_capable(). 
However, the oom killer code is performing a capability test for a task
other than current; hence, it makes a direct call to the
security_capable() hook that supports passing a particular task, unlike
the capable() function.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

