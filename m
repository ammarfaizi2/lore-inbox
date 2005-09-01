Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbVIAOyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbVIAOyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVIAOyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:54:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33515 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965173AbVIAOyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:54:17 -0400
Date: Thu, 1 Sep 2005 22:59:48 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] GFS: headers
Message-ID: <20050901145948.GS25581@redhat.com>
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

Again, on-disk is fixed little endian, so we have for example:

#define gfs2_32_to_cpu le32_to_cpu
#define cpu_to_gfs2_32 cpu_to_le32

To _test_ and _verify_ the endian-handling of the code we can
#define GFS2_ENDIAN_BIG which switches the above to:

#define gfs2_32_to_cpu to be32_to_cpu
#define cpu_to_gfs2_32 to cpu_to_be32

We offered to removed this when I explained it before.  It sounds like it
would give you some comfort so I'll just go ahead and do it barring any
pleas otherwise.

Dave

