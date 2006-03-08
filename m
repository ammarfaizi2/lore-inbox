Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWCHQxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWCHQxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWCHQxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:53:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39142 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751514AbWCHQxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:53:21 -0500
Subject: Re: [2.6.16-rc5-m3 PATCH] inotify: add the monitor for the event
	source
From: Arjan van de Ven <arjan@infradead.org>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <440F075F.1030404@gmail.com>
References: <440F075F.1030404@gmail.com>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 17:53:18 +0100
Message-Id: <1141836798.12175.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 00:33 +0800, Yi Yang wrote:
> Current inotify implementation only focus on change of file system, but it doesn't
>  know who results in this change, this patch adds three fields to struct inotify_event,
>  tgid, uid and gid, they will save process ID, user ID and user group ID of the process
>  which leads to change in the file system, such software as anti-virus can make use 
> of this feature to monitor who is modifying a specific file.


this patch appears to change the ABI! That is bad bad bad.
Also, how can you guarantee that "current" is valid and meaningful at
the place you use it to get the user id ??
Also the process ID part is really bogus, after all the process may have
exited by the time the inotify client gets to it, and the PID may even
already have been reused.

