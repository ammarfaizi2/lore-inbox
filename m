Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUKVLlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUKVLlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 06:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbUKVLlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 06:41:09 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:49669 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261802AbUKVLig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 06:38:36 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] problem of cont_prepare_write()
References: <877joexjk5.fsf@devron.myhome.or.jp>
	<20041122024654.37eb5f3d.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 22 Nov 2004 20:38:12 +0900
In-Reply-To: <20041122024654.37eb5f3d.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 22 Nov 2004 02:46:54 -0800")
Message-ID: <87ekimw1uj.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Perhaps cont_prepare_write() should look to see if the zerofilled page is
> outside the current i_size and if so, advance i_size to the end of the
> zerofilled page prior to releasing the page lock.

Yes, my first patch was it.

Umm... however, if ->i_size is updated before ->commit_write(),
doesn't it allow access to those pages, before all write() work is
successful?

Doesn't this cause strange behavior?
(especially a failure case of prepare_write())
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
