Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVBOX0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVBOX0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVBOX0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:26:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16846 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261942AbVBOX0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:26:02 -0500
Subject: Re: [PATCH] ext3: Fix sparse -Wbitwise warnings.
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>,
       ext3 users list <ext3-users@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050215232939.GD16892@gaz.sfgoth.com>
References: <200502151246.06598.adobriyan@mail.ru>
	 <1108476729.3363.9.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050215232939.GD16892@gaz.sfgoth.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108509952.9776.101.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 15 Feb 2005 23:25:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-02-15 at 23:29, Mitchell Blank Jr wrote:

> Of course that's less efficient though since "mask" is probably constant..
> so now the endian conversion changed from compile-time to run-time.
> 
> Would something like
> 
>  	( ( EXT3_SB(sb)->s_es->s_feature_compat & cpu_to_le32(mask) ) != 0)
> 
> be enough to satisfy sparse?

Yes, but it breaks other places: there are a few places where callers
actually want the real return value from the "&", so that (for example)
they can tell the user which feature failed the compatibility test.

--Stephen

