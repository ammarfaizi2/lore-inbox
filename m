Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbTIGQDq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 12:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTIGQDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 12:03:46 -0400
Received: from pat.uio.no ([129.240.130.16]:8350 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263351AbTIGQDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 12:03:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16219.22236.521008.199583@charged.uio.no>
Date: Sun, 7 Sep 2003 12:03:40 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: NFS client problems in 2.4.18 to 2.4.20
In-Reply-To: <20030907154238.GK19977@mail.jlokier.co.uk>
References: <16218.5318.401323.630346@charged.uio.no>
	<20030906212250.64809.qmail@web40414.mail.yahoo.com>
	<20030906231401.GB12392@mail.jlokier.co.uk>
	<16218.37312.1855.652692@charged.uio.no>
	<20030907142727.GG19977@mail.jlokier.co.uk>
	<16219.19506.659542.990013@charged.uio.no>
	<20030907154238.GK19977@mail.jlokier.co.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jamie Lokier <jamie@shareable.org> writes:

    >> This is not an issue for tapes, etc. NFS has an alternative
    >> mechanisms for dealing with this in the form of the
    >> NFSERR_JUKEBOX error.

     > Oh, cool.  Perhaps the server should send these automatically,
     > when I/O operations are taking a little bit too long?

Yes. Needs a patch to knfsd, but would be very useful for people that
want to export tapes, CD exchangers, etc...

    >> By setting 'retrans=6' (5 + 1 to compensate for the bug),
    >> therefore, people can ensure that we retry for at least 6
    >> seconds before timing out. The question is: is this an adequate
    >> default?

     > That would be a big improvement.  I take it you have
     > effectively clamped the retransmit time at a minimum of 1/10
     > second, then?  (I didn't understand what you meant earlier).

Yes. When we calculate the timeout value, we add the estimated error*4
to the estimated round trip time. I've set a floor on the former value
so that the minumum timeout will be 1/10second.

     > Last time I used a soft mount, I was seeing the first
     > retransmit after some time smaller than a millisecond.  (I
     > don't remember, but 0.1ms sounds about right).  If that is the
     > retransmit time, then retrans=6 won't be enough - retrans=16
     > would be needed.  I don't think a good correct retrans=xxx
     > setting should depend on the network like that.  Setting a
     > minimum retransmit time is one way to fix that.

It is already in 2.6.0. I'm expecting to put it into 2.4.23 too, but I
want to know that this (together with a patch to 'mount' to change the
retrans default) really does solve the problem for people...

Cheers,
  Trond
