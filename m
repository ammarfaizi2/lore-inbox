Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288622AbSBDHE3>; Mon, 4 Feb 2002 02:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288623AbSBDHEU>; Mon, 4 Feb 2002 02:04:20 -0500
Received: from codepoet.org ([166.70.14.212]:30919 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S288622AbSBDHEK>;
	Mon, 4 Feb 2002 02:04:10 -0500
Date: Mon, 4 Feb 2002 00:04:14 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Asynchronous CDROM Events in Userland
Message-ID: <20020204070414.GA19268@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Calin A. Culianu" <calin@ajvar.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Feb 03, 2002 at 11:41:47PM -0500, Calin A. Culianu wrote:
> 
> Is there any way, other than by polling, to have a user process be
> notified of a change in status on a cdrom drive?  (Such as if the drive
> opens, closes, gets new media, etc)?

Nope.  It would be nice, but the current crop of hardware simply
doesn't support it.  From the Mt. Fuji spec (SFF8090i) 11.5 Get
Event/Status Notification:

    The GET EVENT/STATUS NOTIFICATION Command requests the Logical Unit to
    report event(s) and status as specified in the Notification
    ClassNotification Class Request field and provides asynchronous
    notification. Two modes of operation are defined here. They are
    polling and asynchronous modes.

    In polling mode, the Host will issue GET EVENT/STATUS NOTIFICATION
    Commands at periodic intervals with an immediate (Immed) bit of 1 set.
    The Logical Unit shall complete this Command with the most recently
    available event status requested. The Logical Unit shall support
    polling mode.

    In asynchronous mode, the Host will issue a single GET EVENT/STATUS
    NOTIFICATION Command with an Immed (immediate) bit of 0 requested. If
    the Logical Unit supports Asynchronous event status notification
    (through tagged queuing) the model outlined here shall be used. If the
    Logical Unit does not support Asynchronous Mode, the Command shall
    fail as an illegal request. If the Host requests Asynchronous Mode
    using a non-queable or non-overlappable request, the Command shall
    fail with CHECK CONDITION Status, 5/24/00 INVALID FIELD IN CDB.

Jens Axboe and I wrote a little test app a year or two ago to check
for whether drives supported asynchronous mode.  We found it to be
unsupported on 100% of the drives we tested (and we tested quite a
few)...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
