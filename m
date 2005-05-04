Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVEDNmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVEDNmh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVEDNmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:42:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48106 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261829AbVEDNm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:42:27 -0400
Date: Wed, 4 May 2005 09:42:24 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: System call v.s. errno
Message-ID: <20050504134224.GE17420@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 09:22:09AM -0400, Richard B. Johnson wrote:
> Does anybody know for sure if global 'errno' is supposed to
> be altered after a successful system call? I'm trying to
> track down a problem where system calls return with EINTR
> even though all signal handlers are set with SA_RESTART in
> the flags. It appears as though there may be a race somewhere
> because if I directly set errno to 0x1234, within a few
> hundred system calls, it gets set to EINTR even though all
> system calls seemed to return 'good'. This makes it
> hard to trace down the real problem.

http://www.opengroup.org/onlinepubs/009695399/functions/errno.html
is very clear on this.  Unless indicated that errno is valid after a call
(for many syscalls it is valid when the syscall returns -1), errno has
unspecified value.

	Jakub
