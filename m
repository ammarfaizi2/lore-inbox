Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130337AbRBBWsB>; Fri, 2 Feb 2001 17:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbRBBWrv>; Fri, 2 Feb 2001 17:47:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2184 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129982AbRBBWre>;
	Fri, 2 Feb 2001 17:47:34 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14971.14511.765806.838208@pizda.ninka.net>
Date: Fri, 2 Feb 2001 14:46:07 -0800 (PST)
To: David Lang <dlang@diginsite.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <Pine.LNX.4.31.0102020943270.1221-100000@dlang.diginsite.com>
In-Reply-To: <3A7A8822.CC5D8E4E@uow.edu.au>
	<Pine.LNX.4.31.0102020943270.1221-100000@dlang.diginsite.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Lang writes:
 > 1a. for webservers that server static content (and can therefor use
 > sendfile) I don't see this as significant becouse as your tests have been
 > showing, even a modest machine can saturate your network (unless you are
 > useing gigE at which time it takes a skightly larger machine)

Start using more than one interface, then it begins to become
interesting.

 > 1b. for webservers that are not primarily serving static content, they
 > have to use write() for the output from cgi's, etc and therefor pay the
 > performance penalty without being able to use sendfile() much to get the
 > advantages. These machines are the ones that really need the performance
 > as the cgi's take a significant amount of your cpu.

CGI's can be cached btw if the implementation is clever (f.e. CGI
tells the web server that if the file used as input to the CGI does
not change then the output from the CGI will not change, meaning CGI
output is based solely on input, therefore CGI output can be cached
by the web server).

 > 2. for other fileservers sendfile() sounds like it would be useful if the
 > client is reading the entire file, but what about the cases where the
 > client is reading part of the file, or is writing to the file. In both of
 > these cases it seems that the fileserver is back to the write() penalty.
 > does anyone have stats on the types of requests that fileservers are being
 > asked for?

It helps no matter what part of the file the client reads.

sendfile() can be used on an arbitrary offset+len portion of
a file, it is not limited to just sending an entire fire.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
