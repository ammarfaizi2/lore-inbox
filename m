Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVEYDoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVEYDoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 23:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVEYDoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 23:44:44 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:976 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262263AbVEYDoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 23:44:24 -0400
X-ORBL: [63.202.173.158]
Date: Tue, 24 May 2005 20:44:18 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "Clifford T. Matthews" <ctm@ardi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: surprisingly slow accept/connect cycle time
Message-ID: <6ddc8bfa62357b6b3813facf21b223f9.ANY@taniwha.stupidest.org>
References: <17043.37997.993745.877259@newbie.ardi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17043.37997.993745.877259@newbie.ardi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 02:54:05PM -0600, Clifford T. Matthews wrote:

> static void
> listen_or_die (int fd, int backlog)
> {
>   DIE_IF (listen (fd, backlog) != 0);
> 
> }

[...]

>   listen_or_die (accept_fd, 10);

the backlog is 10, so my guess is that the parent does 10+ connection
attempts before the child can accept them so some SYN packets get
dropped --- and you have to wait for TCP to retry hence the delay you
see

a larger backlog would make things seem to go faster, as would
tweaking the TCP timers

