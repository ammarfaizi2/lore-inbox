Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272962AbTHFAFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272961AbTHFAFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:05:30 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:20486
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S272960AbTHFAF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:05:26 -0400
Subject: Re: [PATCH] autofs4 doesn't expire
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dick Streefland <dick.streefland@xs4all.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>
In-Reply-To: <20030805164904.36b5d2cc.akpm@osdl.org>
References: <4b0c.3f302ca5.93873@altium.nl>
	 <20030805164904.36b5d2cc.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1060128203.14615.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 05 Aug 2003 17:03:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-05 at 16:49, Andrew Morton wrote:
> Probably we should hold onto that ref because we play with the vfsmount
> later on.  So something like this?

We're of one mind.

> +	if (vfs) {
> +		if (is_vfsmnt_tree_busy(vfs))
> +			ret = 0;
> +		mntput(vfs);
> +	}

mntput will cheerfully ignore a NULL vfs, so I don't think the code
needs this much mashing.

	J

