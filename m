Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132698AbREBEaT>; Wed, 2 May 2001 00:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbREBE36>; Wed, 2 May 2001 00:29:58 -0400
Received: from AGrenoble-101-1-1-33.abo.wanadoo.fr ([193.251.23.33]:29426 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S132561AbREBE34>;
	Wed, 2 May 2001 00:29:56 -0400
To: linux-kernel@vger.kernel.org
From: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Subject: Re: 2.4.3-ac9/4 - NFS corruption
Date: 2 May 2001 04:29:41 GMT
Organization: Home, Grenoble, France
Message-ID: <9co2fl$qr9$1@lyon.ram.loc>
In-Reply-To: <9cmd8l$s38$1@lyon.ram.loc> <shsn18x6k77.fsf@charged.uio.no>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
In-Reply-To: <shsn18x6k77.fsf@charged.uio.no>
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Trond Myklebust <trond.myklebust@fys.uio.no> from ml.linux.kernel:
:>>>>> " " == Raphael Manfredi <ram@ram.fr.eu.org> writes:
:     > An "ls -l" on the file yields:
:
:     > 	-rw------- 1 ram users 1642491 May 1 00:00 inbox
:
:     > (on the server, and via NFS), which is *abnormal*, since it's
:     > 15:18 and I've just updated the file.  Therfore, the timestamp
:     > is corrupted as well in the inode.
:
:In that case you have some other task that has done a 'touch' or
:something to the file. An NFS client does not explicitly set the
:timestamp when doing ordinary reading/writing to a file - it leaves it
:to the server to do so.

Of course, I understand that.  It's *abnormal* because I told "mutt"
to delete a message from the mailbox, and then re-synchronized it,
thereby writing to it.  I expected the timestamp to be updated on
the server after that operation.  It did not happen.

:Would you happen to be delivering mail to the same file on the server
:or something like that?

Yes, mail is delivered on the server by mailagent, so with proper local
locking.

:If so it's completely normal behaviour: the userland NFS doesn't
:support file locking, so there's no way that the client can guarantee
:that some task on the server won't write to the file behind its
:back...

Does kernel-land NFS support file locking?

In any case, "mutt" does not lock the file, so yes, I'm perfectly
aware there could be a race.  But not the kind of race that would
NULL-ify 5 bytes on the file when read from the client, whilst those
same bytes are perfectly normal when read from the server.

Raphael
