Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVBOXU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVBOXU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVBOXU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:20:56 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:22976 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261944AbVBOXUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:20:09 -0500
Date: Tue, 15 Feb 2005 15:29:39 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>,
       ext3 users list <ext3-users@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext3: Fix sparse -Wbitwise warnings.
Message-ID: <20050215232939.GD16892@gaz.sfgoth.com>
References: <200502151246.06598.adobriyan@mail.ru> <1108476729.3363.9.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108476729.3363.9.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Tue, 15 Feb 2005 15:29:40 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:
> If we want to fix this, let's fix the macros: for example, convert
> EXT3_HAS_COMPAT_FEATURE to be
> 
> 	( le32_to_cpu(EXT3_SB(sb)->s_es->s_feature_compat) & (mask) )

Of course that's less efficient though since "mask" is probably constant..
so now the endian conversion changed from compile-time to run-time.

Would something like

 	( ( EXT3_SB(sb)->s_es->s_feature_compat & cpu_to_le32(mask) ) != 0)

be enough to satisfy sparse?

-Mitch
