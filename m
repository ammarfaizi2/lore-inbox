Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbUCKFv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 00:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbUCKFv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 00:51:27 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:46485 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262692AbUCKFv0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 00:51:26 -0500
Date: Thu, 11 Mar 2004 06:53:10 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Daniel Mack <daniel@zonque.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.4-rc2: scripts/modpost.c
Message-ID: <20040311055310.GA2102@mars.ravnborg.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Daniel Mack <daniel@zonque.org>, lkml <linux-kernel@vger.kernel.org>
References: <20040304113749.GD5569@zonque.dyndns.org> <1078965617.23891.103.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078965617.23891.103.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 11:40:18AM +1100, Rusty Russell wrote:
> On Thu, 2004-03-04 at 22:37, Daniel Mack wrote:
> 
> > --- linux-2.6.4-rc2.orig/scripts/modpost.c      2004-03-04 11:40:21.000000000 +0100
> > +++ linux-2.6.4-rc2/scripts/modpost.c   2004-03-04 11:23:08.000000000 +0100
> > @@ -63,16 +63,16 @@
> >  new_module(char *modname)
> >  {
> >         struct module *mod;
> > -       char *p;
> > +       int len;
> >  
> >         mod = NOFAIL(malloc(sizeof(*mod)));
> >         memset(mod, 0, sizeof(*mod));
> >         mod->name = NOFAIL(strdup(modname));
> >  
> >         /* strip trailing .o */
> > -       p = strstr(mod->name, ".o");
> > -       if (p)
> > -               *p = 0;
> > +       len = strlen(mod->name);
> > +       if (len > 2 && mod->name[len-2] == '.' && mod->name[len-1] == 'o')
> > +               mod->name[len-2] = 0;
> >  
> >         /* add to list */
> >         mod->next = modules;
> 
> Please use strrchr(mod->name, '.').  More readable, simpler, and ever
> arguably more correct.
OK.
I have some pending modpost changes (to fix MODULE_VERSION with O=),
so I will include the fix there.

	Sam
