Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268699AbUIMPxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268699AbUIMPxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268807AbUIMPpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:45:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61580 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268671AbUIMPnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:43:19 -0400
Date: Mon, 13 Sep 2004 16:43:16 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Alex Zarochentsev <zam@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: [PATCH] use S_ISDIR() in link_path_walk() to decide whether the last path component is a directory
Message-ID: <20040913154316.GC23987@parcelfarce.linux.theplanet.co.uk>
References: <20040913074921.GA2252@backtop.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913074921.GA2252@backtop.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 11:49:22AM +0400, Alex Zarochentsev wrote:
> Hi,
> 
> This patch does not allow open(name, O_DIRECTORY) to be successful for
> non-directories in reiser4.  It replaces ->i_op->lookup != NULL "is dir" check
> for the last path component by explicit S_ISDIR(->i_mode) check. 
> 
> Regardless to reiser4, S_ISDIR() looks more clear there.

The only objection here is that right now we are guaranteed that cwd and
root of every task have non-NULL ->lookup().  With your patch all we have
is S_ISDIR().

So we either need to check for non-NULL ->lookup() before the beginning of
loop in link_path_walk() or split the flag in two.  I would rather do the
former...
