Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276665AbRKMQuY>; Tue, 13 Nov 2001 11:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276576AbRKMQsE>; Tue, 13 Nov 2001 11:48:04 -0500
Received: from pat.uio.no ([129.240.130.16]:399 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S276591AbRKMQrl>;
	Tue, 13 Nov 2001 11:47:41 -0500
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "David D. Hagood" <David.Hagood@ifrsys.com>, linux-kernel@vger.kernel.org
Subject: Re: Automount FS re-exported via NFS fails
In-Reply-To: <3BF0343C.2080409@ifrsys.com> <01111318193900.00801@nemo>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Nov 2001 17:47:15 +0100
In-Reply-To: <01111318193900.00801@nemo>
Message-ID: <shsy9laboto.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == vda  <vda@port.imtp.ilyichevsk.odessa.ua> writes:

     > NFS don't see mountpoints. It's a strange feature but it is
     > really done that way. I can mount my /dev/hdc on a non-empty
     > dir in NFS exported tree and I see hdc filesystem when browsing
     > it locally, but NFS clients still see old dir contents - they
     > don't see mounted drive there!

Actually, knfsd can see mountpoints: you just have to explicitly tell
it which mountpoints it is allowed to cross by using the 'nohide'
export option. (man 5 exports)

For instance:

/foo     client1
/foo/bar client1(nohide)

Should ensure that client1 can mount /foo, and expect to be able to
see the filesystem on /foo/bar as well...

     > I don't know whether it's bug or a feature.

It is an action that is recommended in the RFCs. If you didn't have
this, then you could end up with nasty things happening, for instance,
in the case where the server accidentally re-exports another NFS
partition.
In addition you quickly end up with basic wierdness such as duplicate
inode numbers and the like on the client, since that sees the whole
thing as 1 partition.

Cheers,
   Trond
