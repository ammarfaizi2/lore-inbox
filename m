Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVDDKui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVDDKui (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 06:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVDDKuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 06:50:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24034 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261215AbVDDKuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 06:50:32 -0400
Date: Mon, 4 Apr 2005 11:50:29 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Isn't there race issue during fput() and the dentry_open()?
Message-ID: <20050404105029.GY8859@parcelfarce.linux.theplanet.co.uk>
References: <BF571719A4041A478005EF3F08EA6DF0D963B0@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF571719A4041A478005EF3F08EA6DF0D963B0@pcsmail03.pcs.pc.ome.toshiba.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 08:42:30AM +0900, Tomita, Haruo wrote:
> Indeed, Is there a good method of debugging this issue?
> In the check on the source, a doubtful place was not found except file_kill(). 

The obvious way would be to add a variable and do something like
#define file_list_lock() \
	do { \
		spin_lock(&files_lock); \
		holder_pid = pid; \
	} while(0)
and add a way to check its value (anything - sysrq, whatever).

That assumes that you can reproduce that deadlock at will, obviously...
