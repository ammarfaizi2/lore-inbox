Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVG1STN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVG1STN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVG1SQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:16:40 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:20727 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261874AbVG1SOj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:14:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xqp2iBBEFQ9u5PtDekZgG0k0J/4o2AFRmEiS1jPHDOtrELjOSjAsKt8Pyv0JPA+ctfAVQR1uDgdyZR8i4eXFedNYo+QUyp5yBmgovJ/L6y2kxsH8FAaZHayd4wN4yRzaWLG6YUkGkU5O++KbhNy4O/5ywie0Td6/YnZlUMvHkIQ=
Message-ID: <a4e6962a0507281114378a8d63@mail.gmail.com>
Date: Thu, 28 Jul 2005 13:14:38 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: "Ronald G. Minnich" <rminnich@lanl.gov>
Subject: Re: [V9fs-developer] Re: [PATCH 2.6.13-rc3-mm2] v9fs: add fd based transport
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0507280819210.12285@enigma.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507281358.j6SDwBRZ026263@ms-smtp-03-eri0.texas.rr.com>
	 <20050728141749.GB22173@infradead.org>
	 <Pine.LNX.4.58.0507280819210.12285@enigma.lanl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Ronald G. Minnich <rminnich@lanl.gov> wrote:
> 
> 
> On Thu, 28 Jul 2005, Christoph Hellwig wrote:
> 
> > Couldn't the two other transports be implemented ontop of this one using
> > a mount helper doing the pipe or tcp setup?
> 
> that's how we did it in the version we did for 2.4. I don't see why not.
> 

I strayed away from doing it this way originally for two reasons -
perhaps both are not really valid:

a) I really disliked requiring a helper application to mount a file
system.  I really wanted to be able to boot a diskless system with no
initrd and have just 9P serving root.  I figured if I could enable
people to use 9P without having a helper app, it would be used by more
folks -- of course the need for things like DNS resolution, etc. that
helper apps tend to provide sort of invalidates this piece of things.

b) I was concerned with additional copy overhead - one of the other
transports which isn't published yet uses shared memory (to
virtualized partitions) and it just seemed easier to deal with that in
the kernel rather than punting to a user-level application -- so in
short, I figured keeping the transport modules in the kernel made
sense.  Of course, that doesn't have anything to do with the socket
interfaces being in the kernel -- I don't think there is any
additional copy overhead when using an fd versus a sock.

That being said, many things may be much easier with a user-level
helper - have user level security modules for instance.

I guess I'm not opposed to removing the TCP and named-pipe transports
if folks think that's a reasonable thing to do -- but I'd like to keep
the modular transport infrastructure to support things like the shared
memory transport.  Of course we also need to get our act in gear and
make a reasonable mount-helper application available -- we've got
three versions right now and two of them rely on the Plan 9 from User
Space packages.

Anybody against taking this path?

         -eric
