Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTDTPsl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 11:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTDTPsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 11:48:40 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:19461 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263618AbTDTPsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 11:48:39 -0400
Date: Sun, 20 Apr 2003 18:00:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, linus@transmeta.com
Subject: Re: [CFT] more kdev_t-ectomy
Message-ID: <20030420160034.GA20123@win.tue.nl>
References: <20030420133143.GF10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030420133143.GF10374@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 20, 2003, viro@parcelfarce.linux.theplanet.co.uk
wrote:

[lots of useful stuff].

Happy Easter!

Concerning kdev_t vs dev_t, probably I said this before, but just to be sure:

Long ago the purpose of kdev_t was to become a pointer. Roughly speaking
we got that pointer, only it is called struct gendisk * today.

Today the purpose of kdev_t is to be a form of dev_t: taking the minor
of a kdev_t is just taking the lower 32 bits, no tests, no branches;
taking the minor of a dev_t requires tests and branches - more code,
slower code.

So, the interface with filesystems and with userspace has dev_t.
For kernel-internal numbers kdev_t is better than dev_t.

Of course it may be possible to avoid kernel-internal numbers altogether.
Sometimes that is an improvement, sometimes not. Pointers are more
complicated than numbers - they point at something that must be allocated
and freed and reference counted. A number is like a pointer without the
reference counting.

Andries

