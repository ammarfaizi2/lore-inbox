Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132738AbREBLZZ>; Wed, 2 May 2001 07:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132757AbREBLZO>; Wed, 2 May 2001 07:25:14 -0400
Received: from mons.uio.no ([129.240.130.14]:9941 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S132738AbREBLY5>;
	Wed, 2 May 2001 07:24:57 -0400
To: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3-ac9/4 - NFS corruption
In-Reply-To: <9cmd8l$s38$1@lyon.ram.loc> <shsn18x6k77.fsf@charged.uio.no>
	<9co2fl$qr9$1@lyon.ram.loc>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 02 May 2001 13:24:48 +0200
In-Reply-To: Raphael_Manfredi@pobox.com's message of "2 May 2001 04:29:41 GMT"
Message-ID: <shsr8y8c7sv.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Raphael Manfredi <Raphael_Manfredi@pobox.com> writes:

     > Yes, mail is delivered on the server by mailagent, so with
     > proper local locking.

That's not good enough. The NFS client needs to know when it is in
sync with the server...

     > :If so it's completely normal behaviour: the userland NFS
     > doesn't :support file locking, so there's no way that the
     > client can guarantee :that some task on the server won't write
     > to the file behind its :back...

     > Does kernel-land NFS support file locking?

Yes. See the NFS-HOWTO for details.

     > In any case, "mutt" does not lock the file, so yes, I'm
     > perfectly aware there could be a race.  But not the kind of
     > race that would NULL-ify 5 bytes on the file when read from the
     > client, whilst those same bytes are perfectly normal when read
     > from the server.

That can easily happen if the client thinks that the file is longer
than it is on the server. A client has to rely on its cached value of
the file length in order to append to a file, since it has to specify
an offset at which to write. If that offset exceeds the current file
length, the server does the equivalent of a truncate() to extend the
file.

See RFC1094 and RFC1813 for further details on how NFS implements
reading and writing...

Cheers,
   Trond
