Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWDGTjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWDGTjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWDGTjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:39:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:2207 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964914AbWDGTjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:39:51 -0400
Date: Fri, 7 Apr 2006 14:39:37 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, "Eric W. Biederman" <ebiederm@xmission.com>,
       xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 1/5] uts namespaces: Implement utsname namespaces
Message-ID: <20060407193937.GA15494@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <20060407183600.C8A8F19B8FD@sergelap.hallyn.com> <20060407191359.GC9097@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407191359.GC9097@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Ravnborg (sam@ravnborg.org):
> > diff --git a/include/linux/utsname.h b/include/linux/utsname.h
> > index 13e1da0..cc28ac5 100644
> > --- a/include/linux/utsname.h
> > +++ b/include/linux/utsname.h
> > @@ -1,5 +1,8 @@
> >  #ifndef _LINUX_UTSNAME_H
> >  #define _LINUX_UTSNAME_H
> You can kill this include
> > +#include <linux/sched.h>
> 
> if you move this static inline to sched.h
>  +
> > +static inline struct new_utsname *utsname(void)
> > +{
> > +	return &current->uts_ns->name;
> > +}
> And since it operates on &current that may make sense.

I had it there originally.  Don't mind moving it back if that
seems more appropriate, but of course then we'll need
to #include <linux/utsname.h> in sched.h, since we need to
know struct uts_ns to get uts_ns->name.

So is moving it to sched.h the way to go?

thanks,
-serge
