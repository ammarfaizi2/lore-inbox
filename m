Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267313AbTAGGfI>; Tue, 7 Jan 2003 01:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267315AbTAGGfI>; Tue, 7 Jan 2003 01:35:08 -0500
Received: from h80ad273a.async.vt.edu ([128.173.39.58]:20865 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267313AbTAGGfH>; Tue, 7 Jan 2003 01:35:07 -0500
Message-Id: <200301070643.h076hWCR004411@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!) 
In-Reply-To: Your message of "Tue, 07 Jan 2003 03:16:38 -0300."
             <20030107031638.D1406@almesberger.net> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain> <20030107042045.GA10045@waste.org> <200301070538.h075cICR004033@turing-police.cc.vt.edu>
            <20030107031638.D1406@almesberger.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-775969858P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Jan 2003 01:43:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-775969858P
Content-Type: text/plain; charset=us-ascii

On Tue, 07 Jan 2003 03:16:38 -0300, Werner Almesberger said:
> Valdis.Kletnieks@vt.edu wrote:
> > is currently busticated for gigabit and higher (it takes *hours* without a
> > packet drop to get the window open *all* the way
> 
> Don't use 2.0.21 for gigabit traffic :-)
> 
> (2.0.21 and earlier initialized sstresh to zero, which would indeed
> cause the behaviour you're describing.)

That's not the problem. The problem is that TCP slow-start itself (and some of
the related congestion control stuff) has some issues scaling to the very high
end.  Floyd (of RFC3168 fame) has done some work in the area:

from http://www.ietf.org/internet-drafts/draft-floyd-tcp-highspeed-01.txt

Abstract

   This document proposes HighSpeed TCP, a modification to TCP's
   congestion control mechanism for use with TCP connections with large
   congestion windows.  The congestion control mechanisms of the current
   Standard TCP constrains the congestion windows that can be achieved
   by TCP in realistic environments.  For example, for a Standard TCP
   connection with 1500-byte packets and a 100 ms round-trip time,
   achieving a steady-state throughput of 10 Gbps would require an
   average congestion window of 83,333 segments, and a packet drop rate
   of at most one congestion event every 5,000,000,000 packet (or
   equivalently, at most one congestion event every 1 2/3 hours).  This
   is widely acknowledged as an unrealistic constraint.  To address this
   limitation of TCP, this document proposes HighSpeed TCP, and solicits
   experimentation and feedback from the wider community.

Also http://www.ietf.org/internet-drafts/draft-floyd-tcp-slowstart-01.txt

Abstract

   This note proposes a modification for TCP's slow-start for use with
   TCP connections with large congestion windows.  For TCP connections
   that are able to use congestion windows of thousands (or tens of
   thousands) of MSS-sized segments (for MSS the sender's MAXIMUM
   SEGMENT SIZE), the current slow-start procedure can result in
   increasing the congestion window by thousands of segments in a single
   round-trip time.  Such an increase can easily result in thousands of
   packets being dropped in one round-trip time.  This is often counter-
   productive for the TCP flow itself, and is also hard on the rest of
   the traffic sharing the congested link.  This note proposes Limited
   Slow-Start as an optional mechanism for limiting the number of
   segments by which the congestion window is increased for one window
   of data during slow-start, in order to improve performance for TCP
   connections with large congestion windows.





--==_Exmh_-775969858P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+GncTcC3lWbTT17ARAsufAJ9st9C3gXk9P+i5yeJ69QLDAM/FBQCgpoYa
hWEDFkuvnPC1LPoYnFD9CZk=
=rADo
-----END PGP SIGNATURE-----

--==_Exmh_-775969858P--
