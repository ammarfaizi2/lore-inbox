Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUJZATw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUJZATw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUJZATu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 20:19:50 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:56588 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261918AbUJYPEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:04:16 -0400
Date: Mon, 25 Oct 2004 16:04:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <michael.waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 6/28] VFS: Make expiry recursive
Message-ID: <20041025150416.GA1603@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <michael.waychison@sun.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	raven@themaw.net
References: <10987152612887@sun.com> <1098715291724@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098715291724@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:41:31AM -0400, Mike Waychison wrote:
> This patch allows for tagging of vfsmounts as being part of a sub-tree
> expiry.  It introduces a new vfsmount flag, MNT_CHILDEXPIRE which is used to
> let the system know that the given mountpoint expires with its parent.  This
> is a recursive definition.
> 
> mnt_expiry, the call used to specify that a mount should expire, now takes an
> int described as follows:
>    -  0  -   The mountpoint should not expire (default)
>    - >0  -   The value is used to specify the amount of idle time before the
>              given mountpoint expires.
>    - <0  -   The mountpoint must expire with it's immediate parent.  (parent
>              must be set to expire, or must be itself be marked to expire
>              along with _its_ parent.

so add some constant for this, ala

#define MNT_EXPIRE_RECURSIVE	(-1)

