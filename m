Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVAECe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVAECe2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVAECe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:34:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36506 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262217AbVAECeJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:34:09 -0500
Date: Wed, 5 Jan 2005 02:34:05 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: James Nelson <james4765@cwazy.co.uk>
Cc: linux-kernel@vger.kernel.org, linuxsh-shmedia-dev@lists.sourceforge.net,
       lethal@linux-sh.org
Subject: Re: [PATCH /3] sh64: remove cli()/sti() from arch/sh64/*
Message-ID: <20050105023405.GE26051@parcelfarce.linux.theplanet.co.uk>
References: <20050105022304.22296.7672.51691@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105022304.22296.7672.51691@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 08:22:47PM -0600, James Nelson wrote:
> This series of patches is to remove the last cli()/sti() function calls in arch/sh64.

Wait a minute.  Is that just a blanket search-and-replace job?  There is
a reason why cli/sti is marked obsolete instead of being silently #define'd
that way.  Namely, in a lot of cases users of cli/sti are actually racy.

For such instances replacing these with local_... would not improve anything
(obviously) *and* would hide a trouble spot by silencing a warning.

I'm not familiar with the architectures in question, so it might very well
be that all replacements so far had been correct.  However, I would really
like to see rationale for each of those warning removals to go along with
the patches.

Note that basically you are doing "remove the warning in foo.c:42 and
keep the current behaviour".  The missing part is "current behaviour is,
in fact, correct in that place and does not deserve a warning because
<list of reasons>".
