Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbUKXDUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUKXDUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 22:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbUKXDUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 22:20:31 -0500
Received: from waste.org ([209.173.204.2]:50048 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261717AbUKXDUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 22:20:25 -0500
Date: Tue, 23 Nov 2004 19:20:17 -0800
From: Matt Mackall <mpm@selenic.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20041124032017.GG8040@waste.org>
References: <20041118194959.3f1a3c8e.colin@colino.net> <87653wxqij.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87653wxqij.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 05:24:36AM +0900, OGAWA Hirofumi wrote:
> Colin Leroy <colin@colino.net> writes:
> 
> > It adds MS_SYNCHRONOUS support to FAT filesystem, so that less
> > filesystem breakage happen when disconnecting an USB key, for 
> > example. I'd like to have comments about it, because as it 
> > seems to work fine here, I'm not used to fs drivers and could
> > have made mistakes.
> 
> What cases should these patches guarantee that users can unplug the
> USB key?  And can we guarantee the same cases by improving autofs or
> the similar stuff?

Well there can be no guarantees - there will always be a race between
flush and hot unplug. If we're careful with write ordering, we can
perhaps arrange to avoid the worst sorts of corruption, provided the
device does the right thing when it's in the middle of an IO.

But generally I think this is a good idea as it shrinks the window.

-- 
Mathematics is the supreme nostalgia of our time.
