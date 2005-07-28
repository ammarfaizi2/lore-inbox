Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVG1MwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVG1MwP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVG1MwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:52:15 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:58239 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261434AbVG1MwO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:52:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ra2yXO8KksLqvR3DCJG6DPgf4FShqMkPXvzfLDHOFJonKjzLFejXWbQ8M4wgPN5+stLAn105+fJiO18kWYv32PNf4NqasGsd6ccbfW8GloeA+FlbpFf8MgqEtbxpIy8eshFp6CrTJiddggUGRJ/lMbE0K8UVN5gdQurlROJGdiY=
Message-ID: <9e47339105072805523ed958c1@mail.gmail.com>
Date: Thu, 28 Jul 2005 08:52:14 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050728054914.GA13904@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e473391050725172833617aca@mail.gmail.com>
	 <9e47339105072517561f53b2f9@mail.gmail.com>
	 <20050726015401.GA25015@kroah.com>
	 <9e473391050725201553f3e8be@mail.gmail.com>
	 <9e47339105072719057c833e62@mail.gmail.com>
	 <20050728034610.GA12123@kroah.com>
	 <9e473391050727205971b0aee@mail.gmail.com>
	 <20050728040544.GA12476@kroah.com>
	 <9e47339105072721495d3788a8@mail.gmail.com>
	 <20050728054914.GA13904@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Greg KH <greg@kroah.com> wrote:
> On Thu, Jul 28, 2005 at 12:49:21AM -0400, Jon Smirl wrote:
> > @@ -207,6 +208,28 @@ flush_write_buffer(struct dentry * dentr
> >       struct attribute * attr = to_attr(dentry);
> >       struct kobject * kobj = to_kobj(dentry->d_parent);
> >       struct sysfs_ops * ops = buffer->ops;
> > +     char *x, *y, *z;
> > +
> > +     /* locate leading white space */
> > +     x = buffer->page;
> > +     while (isspace(*x) && (x - buffer->page < count))
> > +             x++;
> 
> Ok, I can follow this.  For example
> buffer->page = "  foo  "
> 
> then x = "foo  " at the end of that .
> 
> > +     /* locate trailng white space */
> > +     z = y = x;
> > +     while (y - buffer->page < count) {
> > +             y++;
> > +             z = y;
> > +             while (isspace(*y) && (y - buffer->page < count)) {
> > +                     y++;
> > +             }
> > +     }
> > +     count = z - x;
> 
> Hm, I _think_ this works, but I need someone else to verify this...
> Anyone else?
> 
> 
> > +
> > +     /* strip the white space */
> > +     if (buffer->page != x)
> > +             memmove(buffer->page, x, count);
> > +     buffer->page[count] = '\0';
> 
> Why move the buffer?  Why not just pass in a pointer to the start of the
> "non-whitespace filled" buffer to the store() function?

That will work if you say it does. I didn't know what happens with
buffer->page in other parts of the code.

> 
> thanks,
> 
> greg k-h
> 


-- 
Jon Smirl
jonsmirl@gmail.com
