Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311024AbSCSOqZ>; Tue, 19 Mar 2002 09:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311366AbSCSOqQ>; Tue, 19 Mar 2002 09:46:16 -0500
Received: from mons.uio.no ([129.240.130.14]:65191 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S311024AbSCSOqC>;
	Tue, 19 Mar 2002 09:46:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo
To: NIIBE Yutaka <gniibe@m17n.org>
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Date: Tue, 19 Mar 2002 15:45:38 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no> <15509.47571.248407.537415@charged.uio.no> <200203182357.g2INvIB13203@mule.m17n.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16nKrq-0007uP-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19. March 2002 00:57, NIIBE Yutaka wrote:
> File handle must be unique.  But I think that it may be reused (for
> different type).  Client side cache should handle this case, IMO.

No...

>From RFC1094:
----------------
2.3.3.  fhandle

          typedef opaque fhandle[FHSIZE];

      The "fhandle" is the file handle passed between the server and the
      client.  All file operations are done using file handles to refer
      to a file or directory.  The file handle can contain whatever
      information the server needs to distinguish an individual file.
-----------------
IOW: the server is required to distinguish an individual file.

Note that there is no time limit on this: if I try to write to a file that 
was deleted behind my back, the server is supposed to be able to determine 
which file I was writing to.

This is further clarified in RFC1813:
-----------------
      If two file handles from the same server are equal, they must refer to
      the same file
------------------

Again: at no point does the RFC say that there is a timelimit on the above 
(unlike the so-called 'volatile filehandles' that were introduced for NFSv4)

Indeed if you think about it, then there is no way the RFC *can* allow the 
client to take the burden: we are talking about a stateless system. Unless 
the server has a way of notifying the client that a filehandle is invalid, 
and/or the file was deleted there is no way that the client can know...

Cheers,
  Trond
