Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUHHP4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUHHP4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 11:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUHHP4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 11:56:40 -0400
Received: from pop.gmx.de ([213.165.64.20]:31972 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265684AbUHHP4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 11:56:37 -0400
X-Authenticated: #1725425
Date: Sun, 8 Aug 2004 17:58:34 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: dynamic /dev security hole?
Message-Id: <20040808175834.59758fc0.Ballarin.Marc@gmx.de>
In-Reply-To: <1091969260.5759.125.camel@cube>
References: <1091969260.5759.125.camel@cube>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Aug 2004 08:47:40 -0400
Albert Cahalan <albert@users.sf.net> wrote:

> Suppose I have access to a device, for whatever legit
> reason. Maybe I'm given access to a USB key with
> some particular serial number.
> 
> I hard link this to somewhere else. Never mind that an
> admin could in theory use 42 separate partitions and
> mount most of the system with the "nodev" option. This
> is rarely done.
> 
> Now the device is removed. The /dev entry goes away.
> A new device is added, and it gets the same device
> number as the device I had legit access to. Hmmm?

This would require (1) /dev to be inside the root filesystem and (2) users
having write access somewhere in that filesystem.

(1) is uncommon, often a separate filesystem is used for udev
(2) is very bad practice anyway and should never be seen on a true
multi-user machine

Besides, this is nothing new. Dynamic permission updates through PAM have
the same issue, and anyone calling themselves "admin" should be well aware
of those issues. This is basic Unix-security, after all.

Yet, this issue should probably mentioned in documentation. It certainly
should be mentioned in the udev-HOWTO.

Regards
