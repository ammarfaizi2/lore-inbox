Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbTG2QEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270040AbTG2QEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:04:51 -0400
Received: from www.13thfloor.at ([212.16.59.250]:64931 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S270003AbTG2QEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:04:50 -0400
Date: Tue, 29 Jul 2003 18:04:58 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Jan Kara <jack@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Quota in 2.6.0-test2 broken ...
Message-ID: <20030729160458.GA31881@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Jan Kara <jack@ucw.cz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Honza!

Quota is definitely broken in 2.6.0-test2 because the
code tries to acquire dqio_sem in *_read_file_info, while
already holding the same sem in vfs_quota_on, which
simply deadlocks ...

removing the down(dqio_sem) in vfs_quota_on at least
allows quota to be enabled 8-) but still deadlocks on 
quota transfers? ... :(

it seems this stuff hasn't been tested since the last
update? doesn't anybody use quota anymore?

best,
Herbert

