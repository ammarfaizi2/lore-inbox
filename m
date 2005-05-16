Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVEPLPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVEPLPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 07:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVEPLPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 07:15:18 -0400
Received: from mail.shareable.org ([81.29.64.88]:6871 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261523AbVEPLOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 07:14:32 -0400
Date: Mon, 16 May 2005 12:14:08 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ram <linuxram@us.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
Message-ID: <20050516111408.GA21145@mail.shareable.org>
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu> <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk> <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu> <1116005355.6248.372.camel@localhost> <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu> <1116012287.6248.410.camel@localhost> <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost> <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116256279.4154.41.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> > I'd rather not speculate on what Al Viro was thinking, it may have
> > been just a misunderstanding.
> 
> Can somebody who know internals of Al Viro's thinking help here?

Presumably he wrote this line:

	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {

Which /explicitly/ permits bind mounts between namespaces if it's not
recursive.  It's not accidental: that !recurse is blatantly making a
point of allowing it.

I take that to mean that /at least at one time/ Al chose to allow it.

Then again, he also wrote this:

> > Bind mount from a foreign namespace results in
> 
> ... -EINVAL

Which means that /at another time/ Al thought he'd disallowed it.

This is a bit like arguing over what the Founding Fathers of the US
Constitution meant.  Does it matter?  We really should ask what
behaviour makes sense now.  Should we add more explicit restrictions
to the code, making the concept of namespaces more restrictive?  Or
remove the restrictions, on the grounds that they don't really add any
security, it'd be useful to relax them, and the code would be simpler?

-- Jamie
