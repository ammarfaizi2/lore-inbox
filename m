Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbUL3QQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbUL3QQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 11:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUL3QQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 11:16:56 -0500
Received: from NS1.idleaire.net ([65.220.16.2]:61165 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S261655AbUL3QQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 11:16:54 -0500
Subject: Re: [RFC 2.6.10 1/22] xfrm: Add direction information to xfrm_state
From: Dave Dillow <dave@thedillows.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041230094839.GX2460@lug-owl.de>
References: <20041230035000.01@ori.thedillows.org>
	 <20041230035000.10@ori.thedillows.org>  <20041230094839.GX2460@lug-owl.de>
Content-Type: text/plain
Message-Id: <1104423409.23254.9.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 30 Dec 2004 11:16:49 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2004 16:16:53.0581 (UTC) FILETIME=[F9B9AFD0:01C4EE8A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-30 at 04:48, Jan-Benedict Glaw wrote:
> On Thu, 2004-12-30 03:48:34 -0500, David Dillow <dave@thedillows.org>
> wrote in message <20041230035000.10@ori.thedillows.org>:
> > diff -Nru a/include/net/xfrm.h b/include/net/xfrm.h
> > --- a/include/net/xfrm.h	2004-12-30 01:12:08 -05:00
> > +++ b/include/net/xfrm.h	2004-12-30 01:12:08 -05:00
> > @@ -146,6 +146,9 @@
> >  	/* Private data of this transformer, format is opaque,
> >  	 * interpreted by xfrm_type methods. */
> >  	void			*data;
> > +
> > +	/* Intended direction of this state, used for offloading */
> > +	int			dir;
> >  };
> >  
> >  enum {
> > @@ -157,6 +160,12 @@
> >  	XFRM_STATE_DEAD
> >  };
> >  
> > +enum {
> > +	XFRM_STATE_DIR_UNKNOWN,
> > +	XFRM_STATE_DIR_IN,
> > +	XFRM_STATE_DIR_OUT,
> > +};
> 
> Any specific reason to first define such a nice enum and then using int
> in the struct?

Just following the current style in net/xfrm.h, see xfrm_state.km.state
and XFRM_STATE_*.

Though, I probably should have used a u8; easily changed if it is an
issue.
-- 
Dave Dillow <dave@thedillows.org>

