Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130311AbRAQCFj>; Tue, 16 Jan 2001 21:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131772AbRAQCF3>; Tue, 16 Jan 2001 21:05:29 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:2316 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130311AbRAQCFP>; Tue, 16 Jan 2001 21:05:15 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14948.64977.712237.357229@wire.cadcamlab.org>
Date: Tue, 16 Jan 2001 20:05:05 -0600 (CST)
To: "Michael Rothwell" <rothwell@holly-springs.nc.us>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <3A5E10F5.716F83B7@holly-springs.nc.us>
	<m3snmpgu8t.fsf@austin.jhcloos.com>
	<3A6466D0.6587C11A@holly-springs.nc.us>
	<20010116182806.B6364@cadcamlab.org>
	<012901c0803f$b5e62df0$8501a8c0@gromit>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Peter Samuelson]
> > What if you copy both 'filename' and 'filename:ext' onto the same
> > fs?  Do they get combined into one file?

[Michael Rothwell]
> ON Ext2, you get two files. On NTFS, you get one file, and a stream
> on that file.

Yeah.  I think that's broken.  It gets worse when you start doing other
posixy things.  Say you do 'mv foo bar:baz' on an ntfs partition.
Those strong in the force will recall that rename() is supposed to
atomically unlink 'bar:baz'.  Instead you seem to be asking it to add
an extra stream to 'bar'.  So should we still unlink the old 'bar'?
And then what if 'foo' is a multi-stream file?  Where do the extra
streams go?  Or do you just get a big fat -EINVAL for every special
case?

I think ultimately there is no posixy (or least-surprise) way to deal
with such things.  If we truly need forks, we need a new api to
manipulate them.  Cleverness with ':' or '/' only takes you so far.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
