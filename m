Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUJGRBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUJGRBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUJGRBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:01:16 -0400
Received: from smtp1.oslo.dnmi.no ([128.39.62.241]:13712 "EHLO
	smtp1.oslo.dnmi.no") by vger.kernel.org with ESMTP id S267452AbUJGQIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:08:32 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
From: Adrian Phillips <a.phillips@met.no>
In-Reply-To: <20041006203818.GD4523@pclin040.win.tue.nl> (Andries Brouwer's
 message of "Wed, 6 Oct 2004 22:38:18 +0200")
References: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
	<41644D86.4010500@nortelnetworks.com>
	<20041006130615.4f65a920.davem@davemloft.net>
	<4164530F.7020605@nortelnetworks.com>
	<20041006203818.GD4523@pclin040.win.tue.nl>
Date: Thu, 07 Oct 2004 18:08:31 +0200
Message-ID: <87lleio6io.fsf@freeze.oslo.dnmi.no>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Mail-From: a.phillips@met.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andries" == Andries Brouwer <aebr@win.tue.nl> writes:

    Andries> On Wed, Oct 06, 2004 at 02:18:23PM -0600, Chris Friesen
    Andries> wrote:
    >> In any case, the current behaviour is not compliant with the
    >> POSIX text that Andries posted.  Perhaps this should be
    >> documented somewhere?

    Andries> For the time being I wrote (in select.2)

    Andries> BUGS It has been reported (Linux 2.6) that select may
    Andries> report a socket file descriptor as "ready for reading",
    Andries> while nev- ertheless a subsequent read blocks.  This
    Andries> could perhaps happen when data has arrived but upon
    Andries> examination has wrong checksum and is discarded. Thus it
    Andries> may be safer to use non-blocking I/O.

On my Debian stable and testing boxes the following text is in man 2
select (obtained from ftp://ftp.win.tue.nl/pub/linux-local/manpages)
:-

       Three independent sets of descriptors are watched.  Those listed in readfds will be watched to
       see  if  characters  become  available  for reading (more precisely, to see if a read will not
                                                                                        ^^^^^^^^^^^^^
       block - in particular, a file descriptor is also ready on end-of-file), those in writefds will
       ^^^^^

(and seems to be the same in the latest tarball) which means that
there is a good possibility that a number of people, myself including,
rely on read not blocking on a fd after select indicates that
"characters have become available". This section should be altered in
some way as well (perhaps referencing the BUGS section).

Sincerely,

Adrian Phillips

-- 
Who really wrote the works of William Shakespeare ?
http://www.pbs.org/wgbh/pages/frontline/shakespeare/
