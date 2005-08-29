Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVH2MBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVH2MBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 08:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVH2MBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 08:01:07 -0400
Received: from [81.2.110.250] ([81.2.110.250]:47762 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750808AbVH2MBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 08:01:06 -0400
Subject: Re: syscall: sys_promote
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: qiyong <qiyong@fc-cn.com>
Cc: linux-kernel@vger.kernel.org, dhommel@gmail.com
In-Reply-To: <4312870E.9000708@fc-cn.com>
References: <20050826092537.GA3416@localhost.localdomain>
	 <20050826110226.GA5184@localhost.localdomain>
	 <1125069558.4958.83.camel@localhost.localdomain>
	 <4312870E.9000708@fc-cn.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Aug 2005 13:29:27 +0100
Message-Id: <1125318568.23946.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-29 at 11:54 +0800, qiyong wrote:
> We can ignore it safely.  sys_promote is a different approach from 
> selinux.  sys_promote is to let sysadmin manually manipulate a running 
> process,

You can ignore the patch easily enough. Ignoring the locking doesn't
work because functionality like fork process counting, exec, and setuid
all make definite assumptions that are not safe to tamper without unless
you fix the uid locking.

Fixing it might be useful in some obscure cases anyway - POSIX threads
might benefit from it too, providing the functionality of changing all
thread uids at once isnt triggered for sensible threaded app behaviour.
