Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWDRB26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWDRB26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 21:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWDRB26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 21:28:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932129AbWDRB25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 21:28:57 -0400
Date: Mon, 17 Apr 2006 18:28:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Buesch <mb@bu3sch.de>
cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Linux 2.6.16.6
In-Reply-To: <200604180052.19361.mb@bu3sch.de>
Message-ID: <Pine.LNX.4.64.0604171824020.3701@g5.osdl.org>
References: <20060417211128.GA6861@kroah.com> <20060417211206.GB6861@kroah.com>
 <200604180052.19361.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Apr 2006, Michael Buesch wrote:

> On Monday 17 April 2006 23:12, you wrote:
> > @@ -352,6 +353,10 @@ static char *make_block_name(struct gend
> >  		return NULL;
> >  	strcpy(name, block_str);
> >  	strcat(name, disk->disk_name);
> > +	/* ewww... some of these buggers have / in name... */
> > +	s = strchr(name, '/');
> > +	if (s)
> > +		*s = '!';
> >  	return name;
> >  }
> 
> Is only one / possible, or better something like this?
> 
> 	/* ewww... some of these buggers have / in name... */
> 	s = name;
> 	while ((s = strchr(s, '/')) != NULL)
> 		*s = '!';

I wonder why people like '!' as a replacement for '/'. It's nasty for 
shell expansion, and it looks visually strange too (at least to me). 
Wouldn't it be a lot nicer to just use something like '.' or ':' instead, 
which is not as visually! distracting! and! screaming!

As to whether it's simpler to just use a character-at-a-time comparison 
over strchr, I dunno. Maybe.

		Linus
