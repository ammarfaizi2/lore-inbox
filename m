Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVDYU20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVDYU20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVDYU2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:28:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:26552 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261162AbVDYU03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:26:29 -0400
Date: Mon, 25 Apr 2005 22:26:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Colin Leroy <colin@colino.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] hfsplus: don't oops on bad FS
In-Reply-To: <20050425220345.6b2ed6d5@jack.colino.net>
Message-ID: <Pine.LNX.4.61.0504252218570.25129@scrub.home>
References: <20050425211915.126ddab5@jack.colino.net>
 <Pine.LNX.4.61.0504252145220.25129@scrub.home> <20050425220345.6b2ed6d5@jack.colino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Apr 2005, Colin Leroy wrote:

> > Actually it looks like we are always leaking it, so actually 
> > hfsplus_put_super() needs fixing, could you add the check and kfree 
> > there and do the same fix for hfs?
> 
> Mmh, right. Here's an updated version that fixes it too.

Don't change hfsplus_fill_super, add a "if (!sb->s_fs_info) return;" to 
hfsplus_put_super (and also hfs_put_super, so you can kill kfree from 
hfs_fill_super).

bye, Roman
