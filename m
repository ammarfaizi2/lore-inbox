Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTJSXAy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 19:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbTJSXAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 19:00:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:6814 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262331AbTJSXAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 19:00:53 -0400
Date: Sun, 19 Oct 2003 16:01:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: piotr@member.fsf.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] D-states in test8
Message-Id: <20031019160127.191a189a.akpm@osdl.org>
In-Reply-To: <20031019205630.GA1153@81.38.200.176>
References: <20031019205630.GA1153@81.38.200.176>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Larroy <piotr@member.fsf.org> wrote:
>
> Process just started to get into D state, all subsequent ps got into D.
>  The first that got into D state was mplayer.

This might help.

--- 25/sound/core/pcm_native.c~pcm_native-deadlock-fix	2003-10-19 15:58:31.000000000 -0700
+++ 25-akpm/sound/core/pcm_native.c	2003-10-19 15:58:48.000000000 -0700
@@ -1982,9 +1982,9 @@ int snd_pcm_open(struct inode *inode, st
 		}
 	}
 	remove_wait_queue(&pcm->open_wait, &wait);
+	up(&pcm->open_mutex);
 	if (err < 0)
 		goto __error;
-	up(&pcm->open_mutex);
 	return err;
 
       __error:

_

