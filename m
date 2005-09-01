Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbVIAOaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbVIAOaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbVIAOaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:30:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48295 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965158AbVIAO3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:29:34 -0400
Date: Thu, 1 Sep 2005 15:29:37 +0100
From: viro@ZenIV.linux.org.uk
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Teigland <teigland@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] GFS: headers
Message-ID: <20050901142937.GC26264@ZenIV.linux.org.uk>
References: <20050901135442.GA25581@redhat.com> <1125584374.5025.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125584374.5025.18.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 04:19:34PM +0200, Arjan van de Ven wrote:
> > +/* Endian functions */
> 
> ehhhh again why?? 
> Why is this a compiletime hack?
> Either you care about either-endian on disk, at which point it has to be
> a runtime thing, or you make the on disk layout fixed endian, at which
> point you really shouldn't abstract be16_to_cpu etc any further!

Well...  I would disagree with the very end of it (e.g. having on-disk
block number representation declared as __bitwise, so that it wouldn't be
mixed with __be<n> + having coversion helpers consisting of
static inline u32 foo_to_cpu(foo n)
{
	return be32_to_cpu((__force __be32)n);
}
etc. may be valid technics, assuming that these objects were passed around
enough to deserve it.

Blanket "let's rename for the sake of renaming" is a BS, of course...
