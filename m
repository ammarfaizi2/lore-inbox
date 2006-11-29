Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933238AbWK2E4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933238AbWK2E4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933320AbWK2E4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:56:24 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:19917 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933238AbWK2E4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:56:24 -0500
Date: Tue, 28 Nov 2006 22:56:19 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sysctl: Simplify ipc ns specific sysctls
Message-ID: <20061129045619.GB15696@sergelap.austin.ibm.com>
References: <m1hcwlmqmp.fsf@ebiederm.dsl.xmission.com> <11646039151062-git-send-email-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11646039151062-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> This patch refactors the ipc sysctl support so that it is
> simpler, more readable, and prepares for fixing the bug
> with the wrong values being returned in the sys_sysctl interface.
> 
> The function proc_do_ipc_string was misnamed as it never handled
> strings.  It's magic of when to work with strings and when to work
> with longs belonged in the sysctl table.  I couldn't tell if the
> code would work if you disabled the ipc namespace but it certainly
> looked like it would have problems.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Hi,

A little belated (sorry), but the only comment I have right now on the
patchset is that the get_ipc() seems like it shouldn't take the write
arg.  Perhaps if consistency is the concern, get_uts() should simply
be called get_uts_locked(table, need_write) ?  This also avoids the
mysterious '1' argument in the next patch at get_ipc(table, 1);

Oh, I lied, one more comment.  It seems worth a comment at the top of
get_uts() and get_ipc() explaining that table->data points to
init_uts->data and that's why the 'which = which - init_uts + uts'
works.

thanks,
-serge
