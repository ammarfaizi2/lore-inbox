Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272232AbTHDUWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272233AbTHDUWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:22:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:33196 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272232AbTHDUUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:20:54 -0400
Date: Mon, 4 Aug 2003 13:22:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 badness in 2.6.0-test2
Message-Id: <20030804132219.2e0c53b4.akpm@osdl.org>
In-Reply-To: <20030804142245.GA1627@nevyn.them.org>
References: <20030804142245.GA1627@nevyn.them.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz <dan@debian.org> wrote:
>
> I came back this morning and found:
>   EXT3-fs error (device md0) in start_transaction: Journal has aborted
>   EXT3-fs error (device md0) in start_transaction: Journal has aborted
>   EXT3-fs error (device md0) in start_transaction: Journal has aborted
> 
> Unfortunately, from the very first one, all writes failed; including all
> writes to syslog.  So I don't know what happened at the beginning.  Is this
> more likely to be something internal to ext3, or a problem with the RAID
> layer?

Could have been an IO error, or the block/MD/device layer returned
incorrect data.  ext3 used to go BUG a lot in the latter case, but nowadays
we try to abort the journal and go read-only.

Without the initial message we do not know.
