Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVKIF2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVKIF2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 00:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVKIF2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 00:28:48 -0500
Received: from xenotime.net ([66.160.160.81]:18316 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932391AbVKIF2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 00:28:47 -0500
Date: Tue, 8 Nov 2005 21:12:56 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: adobriyan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] kernel-doc: nested structs and unions support
Message-Id: <20051108211256.27adaaeb.rdunlap@xenotime.net>
In-Reply-To: <20051108213130.GC8256@mars.ravnborg.org>
References: <20051108193810.GB14202@mipter.zuzino.mipt.ru>
	<20051108213130.GC8256@mars.ravnborg.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005 22:31:30 +0100 Sam Ravnborg wrote:

> On Tue, Nov 08, 2005 at 10:38:10PM +0300, Alexey Dobriyan wrote:
> > Sam, do you like the syntax? I hope properly indented rendering will
> > appear soon.
> Looks good. But I like someone with more kernel-doc experince to
> comment.
> Randy?

The kernel-doc syntax looks good to me.  I'm not so sure about
the presentation part, but I guess that Alexey is stil working
on that part.

I think that I'm agreeing with what Martin Waitz said, that the
implementation is good, but not so sure about the usefulness of it.

Alexey, do you see lots of nested structs (and/or unions) in
kernel APIs?  I haven't gone searching for them.  Have you?
OTOH, it's not costly, so if it works, it's fine.

~Randy


> 	Sam
> 
> > ------------------------------------
> > [PATCH 5/6] kernel-doc: nested structs and unions support
> > 
> > Now something like this
> > 
> > 	struct a {
> > 		struct b_s {
> > 			union {
> > 				int c;
> > 				int g;
> > 			} u;
> > 		} b;
> > 		struct d_s {
> > 			int e;
> > 		} d;
> > 	};
> > 
> > is possible to document with the following kernel-doc comment:
> > 
> > 	/**
> > 	 * struct a - ...
> > 	 *
> > 	 * @b: ...
> > 	 * @b.u: ...
> > 	 * @b.u.c: ...
> > 	 * @b.u.g: ...
> > 	 * @d: ...
> > 	 * @d.e: ...
> > 	 */
> > 
> > Not-Yet-Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  scripts/kernel-doc |   33 ++++++++++++++++++++++++++++-----
> >  1 file changed, 28 insertions(+), 5 deletions(-)
> > 
> > --- linux-kernel-doc-004/scripts/kernel-doc	2005-05-09 02:34:59.000000000 +0000
> > +++ linux-kernel-doc-005/scripts/kernel-doc	2005-05-09 03:46:43.000000000 +0000
> > @@ -104,19 +104,26 @@ use strict;
> >  # Beside functions you can also write documentation for structs, unions, 
> >  # enums and typedefs. Instead of the function name you must write the name 
> >  # of the declaration;  the struct/union/enum/typedef must always precede 
> > -# the name. Nesting of declarations is not supported. 
> > +# the name.
> >  # Use the argument mechanism to document members or constants.
> >  # e.g.
> >  # /**
> >  #  * struct my_struct - short description
> >  #  * @a: first member
> >  #  * @b: second member
> > +#  * @c: nested struct
> > +#  * @c.p: first member of nested struct
> > +#  * @c.q: second member of nested struct
> >  #  * 
> >  #  * Longer description
> >  #  */
> >  # struct my_struct {
> >  #     int a;
> >  #     int b;
> > +#     struct her_struct {
> > +#         char **p;
> > +#         short q;
> > +#     } c;
> >  # };
> >  #
> >  # All descriptions can be multiline, except the short function description.
