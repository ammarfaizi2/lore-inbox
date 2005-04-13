Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVDMIzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVDMIzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 04:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDMIzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 04:55:25 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:17841 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261261AbVDMIzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 04:55:17 -0400
X-T2-Posting-ID: dB8bZLHXm6KAmbp1mi7F+A==
Subject: Re: [PATCH] Fix reproducible SMP crash in security/keys/key.c
From: Alexander Nyberg <alexn@dsv.su.se>
To: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0504122129510.3075@x40-4.cs.helsinki.fi>
References: <Pine.LNX.4.58.0504122129510.3075@x40-4.cs.helsinki.fi>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 10:55:15 +0200
Message-Id: <1113382515.917.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tis 2005-04-12 klockan 21:58 +0300 skrev Jani Jaakkola:
> SMP race handling is broken in key_user_lookup() in security/keys/key.c
> (if CONFIG_KEYS is set to 'y'). This came up on our Samba servers, but is
> not restricted to samba, though samba is probably the only software which
> is likely to trigger this repeatedly (and it did happen allready four 
> times here in University of Helsinki, CS department).
> 
> However, it only takes two setreuid() calls at the same instant, so this
> may be responsible for some other mysterious random crashes.
> 
> This is the same bug which was previously raported to LKML here (found by 
> google):
> http://www.ussg.iu.edu/hypermail/linux/kernel/0502.2/0521.html
> 
> Here is a small test program, which can be used to trigger the bug and 
> crash the machine where it is run. It might take a few seconds:
> 
> #include<unistd.h>
> #include<stdio.h>
> int main() {
>         int i;
>         fork();
>         while(1) {
>                 for(i=0;i<60000;i++) { setreuid(i,0); } 
>                 putchar('.'); fflush(stdout);
>         };
> }
> 
> The (rather obvious) problem is that key_user_lookup() does not properly 
> re-initialize the user lookup if there was a race.
> 
> This patch applies to vanilla 2.6.11.7 and latest fedora kernel
> 2.6.11-1.14_FC3. When applied, the test program runs just fine (and does
> nothing useful).

A fix went into mainline for this two months ago (post 2.6.11), but I
probably should have sent it into -stable aswell.

For your own sake always use the latest kernel when looking at
problems/fixes, things move fast around here :)

