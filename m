Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269160AbUJKSHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269160AbUJKSHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269162AbUJKSHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:07:53 -0400
Received: from code.and.org ([63.113.167.33]:22482 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id S269160AbUJKSHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:07:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Bug or dead code in net/unix/af_unix.c:unix_mkname()
From: James Antill <james-linux-kernel@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 11 Oct 2004 14:07:49 -0400
Message-ID: <m3zn2tcemi.fsf@code.and.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 unix_mkname() looks like (in both 2.4.x and 2.6.x)...

static int unix_mkname(struct sockaddr_un * sunaddr, int len, unsigned *hashp)
{
        if (len <= sizeof(short) || len > sizeof(*sunaddr))
                return -EINVAL;
[...]
                if (len > sizeof(*sunaddr))
                        len = sizeof(*sunaddr);


...so if you pass a "large" sockaddr_un struct bind() just returns
-EINVAL. I assume that is intentional, but that just makes the huge
comment and test later dead code.

-- 
James Antill
