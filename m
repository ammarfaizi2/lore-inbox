Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVEDOve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVEDOve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 10:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEDOve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 10:51:34 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:31386 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261861AbVEDOvS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 10:51:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GWQPJRNB4V1o8I9Xuji47NGCzu300tC35wC84xsi+82aDH+JzIEhzEL8aNRW7/I2e/48n9JNJE28gReJqL5ImViQ0EXRk3VnOTj7J1EP3nlI5Z4kQMR4VXRZZzSltuCsxQ1HVrXFTlHmNdnCJUTLONHV6GAb/Ws5TLf1IbqtwcY=
Message-ID: <a4e6962a0505040751359025e5@mail.gmail.com>
Date: Wed, 4 May 2005 09:51:17 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <E1DTKkd-0003rC-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu>
	 <a4e6962a05050406086e3ab83b@mail.gmail.com>
	 <E1DTKkd-0003rC-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> Where did you see 10 as the limit?  The initial global limit is zero,
> the initial per-user limit is infinity (I did actually test these ;)
> 

The verdict is: I should stop trying to read code before I've had my
coffee in the morning.  Sorry about that.

> 
> > My  major complaint is that I really think having user mounts without
> > requiring them to be in a user's private namespace creates quite a
> > mess.  It potentially pollutes the system's namespace and opens up the
> > possibility of all sorts of synthetic file system "traps".  I'd rather
> > see the private namespace stuff enforced before enabling user-mounts.
> 
> Yes, I see your point.  However the problem of malicious filesystem
> "traps" applies to private namespaces as well (because of suid
> programs).
>

I'm not sure I quite get this (perhaps I haven't had enough coffee
yet...hmmm).  There are, of course, multiple potential vulnerabilities
here -- but if you confine a user's modification to a private
namespace, system daemons and other users would be safe unless they
explicitly suid to the user and we had the per-user namespace
semantics that are being discussed in the other thread.

So, two comments here - if the per-user namespace semantics exist and
someone/something suid's to that user - they make themselves
vulnerable.  I imagine there are numerous traps you can set for
someone that suids to your profile.  Do any of the system daemons
actually do this?

The other comment is that this is why I don't like per-user namespaces
- per process namespaces avoid this vulnerability.  However, that
discussion is already being covered to some length in the other
thread, so I don't really want to go into it again here.

>  ...

I don't like any of the proposed solutions.  Invisible mounts just
aren't the right solution.  Restricting suid/sgid in a cloned
namespace seems like it would be impractical and cause lots of
problems.

Viro - you put in the private namespace stuff originally, and use it
from a user-context (binding your bin directories and what not). 
What's your vision on this?  What do we need to do to make user
mounts/binds/private-namespace a reality?
 
       -eric
