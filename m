Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTK3VVr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 16:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbTK3VVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 16:21:47 -0500
Received: from [217.73.129.129] ([217.73.129.129]:22401 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263178AbTK3VVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 16:21:46 -0500
Date: Sun, 30 Nov 2003 23:21:42 +0200
Message-Id: <200311302121.hAULLg4Z003770@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
To: linux-kernel@vger.kernel.org
References: <20031130.093449.-1591395.2.mcmechanjw@juno.com> <20031130200615.GG19856@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

William Lee Irwin III <wli@holomorphy.com> wrote:

WLII> Could you try 2.6 with the following patch and send in the resulting
WLII> oops/BUG? Please turn on kallsyms for the run.
WLII>                         while (n && p != &file->f_dentry->d_subdirs) {
WLII>                                 struct dentry *next;
WLII>                                 next = list_entry(p, struct dentry, d_child);
WLII> +                               BUG_ON(!next);
WLII>                                 if (!d_unhashed(next) && next->d_inode)
WLII>                                         n--;
WLII>                                 p = p->next;
WLII>                         }

This loop is never run since n is 0

WLII> +                       BUG_ON(!cursor);
WLII>                         list_del(&cursor->d_child);
WLII>                         list_add_tail(&cursor->d_child, p);

The problem seems to be because &cursor->d_child is equal to p,
so on list_del we zero p->prev, and then assign to p->prev->next in
list_add_tail.
&cursor->d_child is equal to p probably because we just created it this
way in dcache_dir_open()

Bye,
    Oleg
