Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVCWWe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVCWWe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVCWWe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:34:28 -0500
Received: from main.gmane.org ([80.91.229.2]:35771 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262302AbVCWWdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:33:44 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mike Waychison <mike@waychison.com>
Subject: Re: [PATCH 1/3] Keys: Pass session keyring to =?utf-8?b?Y2FsbF91c2VybW9kZWhlbHBlcigp?=
Date: Wed, 23 Mar 2005 22:25:02 +0000 (UTC)
Message-ID: <loom.20050323T232144-412@post.gmane.org>
References: <29204.1111608899@redhat.com> <20050323130628.3a230dec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.11.176.22 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050110 Firefox/1.0 (Debian package 1.0+dfsg.1-2))
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm <at> osdl.org> writes:

> 
> David Howells <dhowells <at> redhat.com> wrote:
> >
> > The attached patch makes it possible to pass a session keyring through to the
> >  process spawned by call_usermodehelper().
> 
> hm.  Seems likely to attract angry emails due to breakage of out-of-tree
> stuff.  Did you consider
> 
> static inline int
> call_usermodehelper(char *path, char **argv, char **envp, int wait)
> {
> 	return call_usermodehelper_keys(path, argv, envp, NULL, wait);
> }
> 

An alternative is to have the execve happen in a callback, similar to the
following patch I posted a couple months ago:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109871749900732&w=2

IMHO, this is a better interface as it allows module writers to make arbitrary
changes.

(Some interface for allowing modules to 'safely' do execve is still required
though).

Mike Waychison

