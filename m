Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSIAMGd>; Sun, 1 Sep 2002 08:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSIAMGd>; Sun, 1 Sep 2002 08:06:33 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:55305 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316788AbSIAMGc>; Sun, 1 Sep 2002 08:06:32 -0400
Date: Sun, 1 Sep 2002 14:10:53 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warnkill trivia 2/2
Message-ID: <20020901121053.GA7325@louise.pinerecords.com>
References: <20020901112856.GL32122@louise.pinerecords.com> <20020901.042539.63049493.davem@redhat.com> <20020901113741.GM32122@louise.pinerecords.com> <20020901.043512.51698754.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020901.043512.51698754.davem@redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 7 days, 4:02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's keep the sparc atomic_read() how it is so more bugs
> like this can be found.

I don't know, though... scratching my head here -- Is GCC actually
able to distinguish between 'const int *a' and 'int const *a'?

Because if 'int const *a' means that the pointer is constant but
not the actual value it points to,

void a(int const *a) { *a = 1; }

shouldn't be generating 'warning: assignment of read-only location'.
Right?

> Reiserfs is buggy, it means struct  buffer_head const * bh

Okay so that gives us the third reiserfs patch of the day:

--- buffer2.c~	2002-09-01 13:52:39.000000000 +0200
+++ buffer2.c	2002-09-01 13:44:19.000000000 +0200
@@ -21,7 +21,7 @@
    hold we did free all buffers in tree balance structure
    (get_empty_nodes and get_nodes_for_preserving) or in path structure
    only (get_new_buffer) just before calling this */
-void wait_buffer_until_released (const struct buffer_head * bh)
+void wait_buffer_until_released (struct buffer_head const *bh)
 {
   int repeat_counter = 0;
 
