Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280766AbRKGEYs>; Tue, 6 Nov 2001 23:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280764AbRKGEYh>; Tue, 6 Nov 2001 23:24:37 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:61125 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S280762AbRKGEYZ>; Tue, 6 Nov 2001 23:24:25 -0500
Message-ID: <3BE8B0B1.9000501@neta.com>
Date: Tue, 06 Nov 2001 20:55:29 -0700
From: Art Wagner <awagner@neta.com>
Reply-To: awagner@westek-systems.com
Organization: W.E.S. Tek 
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011106
X-Accept-Language: en-us
MIME-Version: 1.0
To: mlist-linux-kernel@nntp-server.caltech.edu
Subject: [Fwd: How can I know the number of current users in the system?]
Content-Type: multipart/mixed;
 boundary="------------080604080504020808060304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080604080504020808060304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Many messages originating at;
mlist-linux-kernel@NNTP-SERVER.CALTECH.EDU
are being auto-posted to "linux-kernel@vger.kernel.org". Can you please do
what you can to get linux-kernel removed from the subscriber list
for that (mlist-linux-kernel) mailing list....
Thank you,
Art Wagner


--------------080604080504020808060304
Content-Type: message/rfc822;
 name="Re: How can I know the number of current users in the system?.eml"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="Re: How can I know the number of current users in the system?.eml"


>From - Tue Nov  6 16:38:24 2001
X-Mozilla-Status2: 00000000
Return-Path: <linux-kernel-owner@vger.kernel.org>
Delivered-To: awagner@neta.com
Received: (qmail 12661 invoked from network); 6 Nov 2001 09:54:49 -0000
Received: from vger.kernel.org (199.183.24.194)
  by mail.getnet.net with SMTP; 6 Nov 2001 09:54:49 -0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278714AbRKFJwF>; Tue, 6 Nov 2001 04:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278911AbRKFJvz>; Tue, 6 Nov 2001 04:51:55 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:30628 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S278722AbRKFJvl> convert rfc822-to-8bit; Tue, 6 Nov 2001 04:51:41 -0500
Received: from elin.scali.no (IDENT:root@elin.scali.no [62.70.89.10])
	by gap.cco.caltech.edu (8.9.3/8.9.3) with ESMTP id BAA20381
	for <mlist-linux-kernel@nntp-server.caltech.edu>; Tue, 6 Nov 2001 01:29:37 -0800 (PST)
Received: from pc-16.office.scali.no (IDENT:te@pc-16.office.scali.no [172.16.0.116])
	by elin.scali.no (8.11.0/8.11.0) with ESMTP id fA69SxC02164;
	Tue, 6 Nov 2001 10:29:00 +0100
Subject: Re: How can I know the number of current users in the system?
From:	Terje Eggestad <terje.eggestad@scali.no>
To:	weixl@caltech.edu
Cc:	mlist-linux-kernel@NNTP-SERVER.CALTECH.EDU
In-Reply-To: <3BE5BDFB.B49A8147@caltech.edu>
In-Reply-To: <3BE5BDFB.B49A8147@caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16 (Preview Release)
Date:	06 Nov 2001 10:28:57 +0100
Message-Id: <1005038940.2134.27.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org

The short answer is; No.

The slightly longer answer is that Linux/Unix kernels don't have a
consept of a logged in user. userids are used for really only one thing,
owner ship of data. In order to do enforce it a process must be running
as a spesific user. Once programs had a userid attached to it, things
rolled on from there. However there is no way of figuring out if a
process is "online" or something else.

However, the big iron *ix'es do this, and I can't remember exactly how
they do it. But another feature often pop up; guaranteeing a users a
minimum CPU percentage. (Even if I hate it, it has merit for RT/responce
critical apps.)

My suggestion is to loop thru the processes and collect a list of all
the userids and form a tree/list of all the processes belonging to each
of them. Then you fair share schedule between the users.

Another issue: did you want to serialize scheduling? (run all the
processes for a user in sequence before starting on the next user?)
Another feature on the "big" *ix'es. 

THis is going to have some side effects! nicing a process up or down may
only nice relative to the users other processes, not other users. It may
be what you want, just thought I'd bring it up. 

Next issue, do you want to fair share between root and the other users?
(and THAT is a time old discussion...)

TJ


søn, 2001-11-04 kl. 23:15 skrev Wei Xiaoliang:
> Hi every one,
>     I have a problem not clear: Is there any counter for the user number
> in linux?
> I want to do anexperiment which will get the number of current user in
> the system and try fair-share scheduling based on it. I read the sys.c
> and user.c but cannot find a counter for it. Is there any counter for
> this things?
> 
>     If no, where can I put the inc instruct and dec instruct  or the
> counter? in the uid_hash_insert and uid_hash_remove?
>     Thank you!
> -----------------------------------------------------------------------
> Xiaoliang (David) Wei                    Graduate Student in CS, Caltech
> E-mail: weixl@caltech.edu                Office: 158 Jorgensen
> Phone: 1-(626)-395-3555 (O)        1-(626)-577-5238 (H)
> Mail:     Xiaoliang Wei, 256-80 Caltech, Pasadena, CA 91125, U.S.A.
> WWW: http://www.cs.caltech.edu/~weixl    http://166.111.69.241/~wxl
> -----------------------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




--------------080604080504020808060304--

