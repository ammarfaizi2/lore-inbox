Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTFTL4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 07:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTFTL4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 07:56:12 -0400
Received: from f10.mail.ru ([194.67.57.40]:23566 "EHLO f10.mail.ru")
	by vger.kernel.org with ESMTP id S262984AbTFTL4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 07:56:12 -0400
From: "Andrey Borzenkov" <arvidjaar@mail.ru>
To: "Michael Umansky" <mishka99@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proposed fix for i_sem deadlock in devfs in 2.4.2x kernel
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Fri, 20 Jun 2003 16:10:12 +0400
Reply-To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19TKiZ-0004UU-00.arvidjaar-mail-ru@f10.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> devfs_d_revalidate_wait()
> {
>	...
>	read_lock(...)
>	...
>	add_wait_queue(&lookup_info->wait_queue, ...);
>	read_unlock(...)
>	up(&dir->i_sem);		/* add for this proposed fix */

this can be called both with and without i_sem held. i_sem is held
for directory modifications but not for simple lookups. Is it correct
to increase i_sem count above 1? Note, it will be done by every
task so it may screw up locking completely.

Look at <http://marc.theaimsgroup.com/?l=linux-kernel&m=105233420622539&w=2> for alternative fix. 

-andrey

>	schedule();
>	down(&dir->i_sem);	/* add for this proposed fix */
>	...
>}

