Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTKQJub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 04:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTKQJub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 04:50:31 -0500
Received: from holomorphy.com ([199.26.172.102]:24483 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263427AbTKQJu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 04:50:29 -0500
Date: Mon, 17 Nov 2003 01:50:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031117095024.GD22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20031117090339.GC22764@holomorphy.com> <Pine.LNX.4.44.0311170937550.748-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311170937550.748-100000@einstein.homenet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 09:42:09AM +0000, Tigran Aivazian wrote:
> Here are two files: simple.c kernel module and user.c user test program.  
> If you (or anyone) believe it is possible to return more than a single
> page on a read(2) please change them accordingly and let me know.

Sorry, I needed to amend that. It's not a fixed PAGE_SIZE buffer; the
buffer is only resized up to the point it allows a single ->show()
call to succeed, and then you get short reads if you try to go beyond
the buffer size in a single read.

You could (in theory) get this to succeed > PAGE_SIZE reads by doing
the operation all in a single ->show() call, but that will have some
large overheads and will also have a retry loop where the buffer size
is doubled until the ->show() call succeeds incurred at least once
per open() at the time of the first read().


-- wli
