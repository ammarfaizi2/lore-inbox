Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292941AbSCRX5l>; Mon, 18 Mar 2002 18:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293027AbSCRX5c>; Mon, 18 Mar 2002 18:57:32 -0500
Received: from tsukuba.m17n.org ([192.47.44.130]:64194 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S292941AbSCRX5Z>;
	Mon, 18 Mar 2002 18:57:25 -0500
Date: Tue, 19 Mar 2002 08:57:18 +0900 (JST)
Message-Id: <200203182357.g2INvIB13203@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: trond.myklebust@fys.uio.no
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <15509.47571.248407.537415@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
 > Rigging the client in order to cope with *all* the consequences in
 > terms of unfsd races is an exercise in futility - it cannot be
 > done.
[...]
 > The solution is not to keep flogging the dead horse that is unfsd. It
 > is to put the effort into fixing knfsd so that it can cope with all
 > those cases where people are using unfsd today.

Agreed in general.  That's the way to go.

			*	*	*

 > Sure, but it is a consequence of a badly broken server that violates
 > the NFS specs concerning file handles.

I have technical concern here.  Is the server violating specs?

Please correct me, if I am wrong.  I've read through rfc1094, rfc1813,
XNFS specification of Opengroup and NFS v3 specification by Sun, I
cannot find the description of... :
	reuse of file handle in server side is wrong.

File handle must be unique.  But I think that it may be reused (for
different type).  Client side cache should handle this case, IMO.

There is an explanation for the file handle in NFS v3 specification by Sun
(http://www.connectathon.org/nfsv3.pdf):
----------------------
Servers should try to maintain a one-to-one correspondence between
file handles and files, but this is not required.  Clients should use
file handle comparisons only to improve performance, not for correct
behavior.
----------------------

Current client implementation of Linux uses a file handle for
correctness, in the scenario I've described.
-- 
