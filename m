Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265945AbUGEErU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265945AbUGEErU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 00:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUGEErU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 00:47:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:45798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265945AbUGEErT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 00:47:19 -0400
Date: Sun, 4 Jul 2004 21:46:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: vrajesh@umich.edu, linux-kernel@vger.kernel.org
Subject: Re: prio_tree generalization
Message-Id: <20040704214609.71b0084d.akpm@osdl.org>
In-Reply-To: <20040704222438.A11865@almesberger.net>
References: <20040704222438.A11865@almesberger.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> wrote:
>
> I'm currently experimenting with the prio_tree code in an elevator
>  ("IO scheduler"),

Offtopic, but that's a premature optmztn.  O(n) linear searches work just
fine for disk elevators under most circumstances - we don't get may
complaints about CPU consumption in the 2.4 elevator.

A disk isn't going to retire more than 100 requests/sec in practice, and
the cost of an all-requests search is relatively small.

Once the new design is settled in, is proven to be useful and desirable,
that's the time to start thinking about millioptimisations such as
converting the search complexity from O(n) to O(log(n)).
