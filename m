Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265934AbRGJIWo>; Tue, 10 Jul 2001 04:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265916AbRGJIWX>; Tue, 10 Jul 2001 04:22:23 -0400
Received: from pat.uio.no ([129.240.130.16]:43748 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S265915AbRGJIWV>;
	Tue, 10 Jul 2001 04:22:21 -0400
MIME-Version: 1.0
Message-ID: <15178.47928.328862.678031@charged.uio.no>
Date: Tue, 10 Jul 2001 10:22:16 +0200
To: Craig Soules <soules@happyplace.pdl.cmu.edu>
Cc: jrs@world.std.com, linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <Pine.LNX.3.96L.1010709175623.16113S-100000@happyplace.pdl.cmu.edu>
In-Reply-To: <15178.3722.86802.671534@charged.uio.no>
	<Pine.LNX.3.96L.1010709175623.16113S-100000@happyplace.pdl.cmu.edu>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Craig Soules <soules@happyplace.pdl.cmu.edu> writes:

     > On Mon, 9 Jul 2001, Trond Myklebust wrote:
    >> If the client discovers that the cache is invalid, it clears
    >> it, and refills the cache. We then start off at the next cookie
    >> after the last read cookie. Test it on an ordinary filesystem
    >> and you'll see the exact same behaviour. The act of creating or
    >> deleting files is *not* supposed invalidate the readdir offset.

     > I would say that assuming that the readdir cookie is an offset
     > is a break in the spec.  In fact, there are a few things in the
     > spec which I'd like to point out.  First of all, "All of the
     > procedures in the NFS protocol are assumed to be synchronous."
     > Which means that you should not even be making asynchronous
     > remove calls.  Second, the server is meant to be "as stateless
     > as possible."  I would argue that this means that you should
     > not make assumptions about the cookie's state if another
     > operation is interposed between two readdir() operations.  As
     > an aside, by adding a translation layer to the cookies (as
     > suggested by an earlier post) would break this, as the server
     > would have to store that state in the event of a server crash,
     > thus breaking the spec.

Imagine if somebody gives you a 1Gb directory. Would it or would it
not piss you off if your file pointer got reset to 0 every time
somebody created a file?

The current semantics are scalable. Anything which resets the file
pointer upon change of a file/directory/whatever isn't...

Cheers,
  Trond
