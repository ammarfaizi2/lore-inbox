Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130190AbRBBXBW>; Fri, 2 Feb 2001 18:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130564AbRBBXBO>; Fri, 2 Feb 2001 18:01:14 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:62342 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S130190AbRBBXA6>; Fri, 2 Feb 2001 18:00:58 -0500
Date: Fri, 2 Feb 2001 14:57:42 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: "David S. Miller" <davem@redhat.com>
cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <14971.14511.765806.838208@pizda.ninka.net>
Message-ID: <Pine.LNX.4.31.0102021456000.1221-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, that info on sendfile makes sense for the fileserver situation.
for webservers we will have to see (many/most CGI's look at stuff from the
client so I still have doubts as to how much use cacheing will be)

David Lang

On Fri, 2 Feb 2001, David S. Miller wrote:

> Date: Fri, 2 Feb 2001 14:46:07 -0800 (PST)
> From: David S. Miller <davem@redhat.com>
> To: David Lang <dlang@diginsite.com>
> Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
>      "netdev@oss.sgi.com" <netdev@oss.sgi.com>
> Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
>
>
> David Lang writes:
>  > 1a. for webservers that server static content (and can therefor use
>  > sendfile) I don't see this as significant becouse as your tests have been
>  > showing, even a modest machine can saturate your network (unless you are
>  > useing gigE at which time it takes a skightly larger machine)
>
> Start using more than one interface, then it begins to become
> interesting.
>
>  > 1b. for webservers that are not primarily serving static content, they
>  > have to use write() for the output from cgi's, etc and therefor pay the
>  > performance penalty without being able to use sendfile() much to get the
>  > advantages. These machines are the ones that really need the performance
>  > as the cgi's take a significant amount of your cpu.
>
> CGI's can be cached btw if the implementation is clever (f.e. CGI
> tells the web server that if the file used as input to the CGI does
> not change then the output from the CGI will not change, meaning CGI
> output is based solely on input, therefore CGI output can be cached
> by the web server).
>
>  > 2. for other fileservers sendfile() sounds like it would be useful if the
>  > client is reading the entire file, but what about the cases where the
>  > client is reading part of the file, or is writing to the file. In both of
>  > these cases it seems that the fileserver is back to the write() penalty.
>  > does anyone have stats on the types of requests that fileservers are being
>  > asked for?
>
> It helps no matter what part of the file the client reads.
>
> sendfile() can be used on an arbitrary offset+len portion of
> a file, it is not limited to just sending an entire fire.
>
> Later,
> David S. Miller
> davem@redhat.com
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
