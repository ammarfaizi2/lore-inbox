Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWDUNwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWDUNwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWDUNwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:52:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:49370 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932308AbWDUNwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:52:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] fix spu_callbacks BUILD_BUG_ON
Date: Fri, 21 Apr 2006 15:52:38 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, davem@davemloft.net,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
References: <20060421080239.GC4717@suse.de> <200604211245.27744.arnd@arndb.de> <Pine.LNX.4.61.0604211512370.23180@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604211512370.23180@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200604211552.38923.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 15:14, Jan Engelhardt wrote:
> +      [__NR_syscalls] = NULL,
> 
> > };
> > 

> >-      if (s->nr_ret >= __NR_syscalls) {
> >+      if (s->nr_ret >= ARRAY_SIZE(spu_syscall_table)) {
> 
> +       if(syscall == NULL) {
> 
> 
> 
> That way, syscalls could be added in the master table while spu does not 
> break. Comments?

Hmm, my idea was not having to check for NULL pointers when we know
that they are valid function calls. But you are right that your approach
is more robust. It also means that we might just leave out all
the assignments to sys_ni_syscall in order to make the source a little
shorter.

	Arnd <><
