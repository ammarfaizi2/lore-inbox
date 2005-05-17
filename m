Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVEPTvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVEPTvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVEPTvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:51:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:23719 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261816AbVEPTut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:50:49 -0400
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
From: Ram <linuxram@us.ibm.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20050516111408.GA21145@mail.shareable.org>
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
	 <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
	 <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
	 <1116256279.4154.41.camel@localhost>
	 <20050516111408.GA21145@mail.shareable.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1116301843.4154.88.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 May 2005 20:50:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 04:14, Jamie Lokier wrote:
> Ram wrote:
> > > I'd rather not speculate on what Al Viro was thinking, it may have
> > > been just a misunderstanding.
> > 
> > Can somebody who know internals of Al Viro's thinking help here?
> 
> Presumably he wrote this line:
> 
> 	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
> 
> Which /explicitly/ permits bind mounts between namespaces if it's not
> recursive.  It's not accidental: that !recurse is blatantly making a
> point of allowing it.
> 
> I take that to mean that /at least at one time/ Al chose to allow it.
> 
> Then again, he also wrote this:
> 
> > > Bind mount from a foreign namespace results in
> > 
> > ... -EINVAL
> 
> Which means that /at another time/ Al thought he'd disallowed it.
> 
> This is a bit like arguing over what the Founding Fathers of the US
> Constitution meant.  Does it matter?  We really should ask what
> behaviour makes sense now.  Should we add more explicit restrictions
> to the code, making the concept of namespaces more restrictive?  Or
> remove the restrictions, on the grounds that they don't really add any
> security, it'd be useful to relax them, and the code would be simpler?
> 

Ok. less restriction without compromising security is a good idea.

Under the premise that bind mounts across namespace should be allowed;
any insight why the "founding fathers" :) allowed only bind
and not recursive bind?  What issue would that create? One can
easily workaround that restriction by manually binding recursively.
So does the recursive bind restriction serve any purpose?

I remember Miklos saying its not a security issue but a
implementation/locking issue. That can be fixed aswell.

RP


> -- Jamie

