Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130197AbRBBX25>; Fri, 2 Feb 2001 18:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130222AbRBBX2r>; Fri, 2 Feb 2001 18:28:47 -0500
Received: from mail.hsnp.com ([205.161.174.10]:20545 "HELO netc.netc.com")
	by vger.kernel.org with SMTP id <S130197AbRBBX2h>;
	Fri, 2 Feb 2001 18:28:37 -0500
Date: Fri, 2 Feb 2001 17:28:26 -0600 (CST)
From: Jeff Barrow <jeffb@netc.com>
To: David Lang <dlang@diginsite.com>
cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <Pine.LNX.4.31.0102021511330.1221-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.02.10102021718470.31280-100000@netc.netc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Let's see.... all the work being done for clustering would definitely
benefit... all the static images on your webserver--and static images
makes up most of the bandwidth from web servers (images, activeX controls,
java apps, sound clips...)... NFS servers, Samba servers (both of which
are used more than you may think)... email servers...

Once Real Networks patches their Realserver to use sendfile (which
shouldn't bee all that hard), then that would help too....

I think that sendfile can be used in a LOT of applications, and the only
ones that wouldn't benefit are mostly low-bandwidth anyway (CGI apps
almost always return either a small html file or a small image file, then
there's telnet and other interactive utilities...).

Most applications that use a lot of bandwidth (and thus a lot of CPU time
sending the packets) are capable of being patched to use sendfile.


On Fri, 2 Feb 2001, David Lang wrote:

> right, assuming that there is enough sendfile() benifit to overcome the
> write() penalty from the stuff that can't be cached or sent from a file.
> 
> my question was basicly are there enough places where sendfile would
> actually be used to make it a net gain.
> 
> David Lang
> 
> On Fri, 2 Feb 2001, David S. Miller wrote:
> 
> > Date: Fri, 2 Feb 2001 15:09:13 -0800 (PST)
> > From: David S. Miller <davem@redhat.com>
> > To: David Lang <dlang@diginsite.com>
> > Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
> >      "netdev@oss.sgi.com" <netdev@oss.sgi.com>
> > Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
> >
> >
> > David Lang writes:
> >  > Thanks, that info on sendfile makes sense for the fileserver situation.
> >  > for webservers we will have to see (many/most CGI's look at stuff from the
> >  > client so I still have doubts as to how much use cacheing will be)
> >
> > Also note that the decreased CPU utilization resulting from
> > zerocopy sendfile leaves more CPU available for CGI execution.
> >
> > This was a point I forgot to make.
> >
> > Later,
> > David S. Miller
> > davem@redhat.com
> >
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
