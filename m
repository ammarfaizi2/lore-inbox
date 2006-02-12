Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWBLSGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWBLSGE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 13:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWBLSGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 13:06:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59319 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750826AbWBLSGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 13:06:03 -0500
Date: Sun, 12 Feb 2006 18:06:01 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linda Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
Message-ID: <20060212180601.GU27946@ftp.linux.org.uk>
References: <43ED5A7B.7040908@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ED5A7B.7040908@tlinx.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 07:31:07PM -0800, Linda Walsh wrote:
> The maximum number of followed symlinks seems to be set to 5.
> 
> This seems small when compared to other filesystem limits.
> Is there some objection to it being raised?  Should it be
> something like Glib's '20' or '255'?

	20 or 255 - not feasible (we'll get stack overflow from hell).
8 - probably can be switched already; anybody who hadn't converted their
fs ->follow_link() to new model will just lose; in-tree instances are
already OK with that and out-of-tree folks had at least half a year
of warning.

	Unless anybody yells right now, I'm switching it to 8 in post-2.6.16.
