Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262188AbSIZIlP>; Thu, 26 Sep 2002 04:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262241AbSIZIlP>; Thu, 26 Sep 2002 04:41:15 -0400
Received: from jack.stev.org ([217.79.103.51]:45851 "EHLO jack.stev.org")
	by vger.kernel.org with ESMTP id <S262188AbSIZIlO>;
	Thu, 26 Sep 2002 04:41:14 -0400
Message-ID: <008201c26539$ddd4fea0$0cfea8c0@ezdsp.com>
From: "James Stevenson" <james@stev.org>
To: "Philippe Troin" <phil@fifi.org>
Cc: <linux-kernel@vger.kernel.org>
References: <87n0q8tcs8.fsf@ceramic.fifi.org><1032891985.2035.1.camel@god.stev.org><87smzzksri.fsf@ceramic.fifi.org><1032903706.2445.4.camel@god.stev.org><87adm6kofe.fsf@ceramic.fifi.org><1032977895.1676.0.camel@god.stev.org> <87vg4tk8h5.fsf@ceramic.fifi.org>
Subject: Re: 2.4.19: oops in ide-scsi
Date: Thu, 26 Sep 2002 09:51:12 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as far as i can tell if you change the code as you suggested
it may very possible screw over the ide system.
you suggested

if (status & ERR_STAT && rq)
    rq->errors++;

which still calls idescsi_end_request
which first line uses rq again which would
cause an opps again.

in idescsi_end_request first lines are.

if (rq->cmd != IDESCSI_PC_RQ) {
    ide_end_request (uptodate, hwgroup);
    return;
}

but as far as i can tell idescsi_end_request needs
to be called or the ide drive is left in an unkown state


----- Original Message -----
From: "Philippe Troin" <phil@fifi.org>
To: "James Stevenson" <james@stev.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, September 25, 2002 11:30 PM
Subject: Re: 2.4.19: oops in ide-scsi


> James Stevenson <james@stev.org> writes:
>
> > Hi
> >
> > then i belive there are other possible problems which may by
> > just as bad
>
> Can you elaborate?
>
> Phil.


