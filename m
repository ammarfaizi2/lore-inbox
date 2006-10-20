Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992574AbWJTICe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992574AbWJTICe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 04:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992575AbWJTICd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 04:02:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48072 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2992574AbWJTICc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 04:02:32 -0400
Date: Fri, 20 Oct 2006 04:02:16 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>,
       Cal Peake <cp@absolutedigital.net>
Subject: Re: [CFT] Grep to find users of sys_sysctl.
Message-ID: <20061020080216.GH1785@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com> <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org> <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net> <20061018124415.e45ece22.akpm@osdl.org> <m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net> <m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 01:05:18AM -0600, Eric W. Biederman wrote:
> 
> Anyone who is interested in knowing if they have an application on
> their system that actually uses sys_sysctl please run the following grep.
> 
> find / -type f  -perm /111 -exec fgrep 'sysctl@@GLIBC' '{}' ';' 

This assumes the binaries and/or libraries are not stripped, and they
usually are stripped.  So, it is better to run something like:
find / -type f -perm /111 | while read f; do readelf -Ws $f 2>/dev/null | fgrep -q sysctl@GLIBC && echo $f; done

	Jakub
