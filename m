Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbQKKCmY>; Fri, 10 Nov 2000 21:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129251AbQKKCmO>; Fri, 10 Nov 2000 21:42:14 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:54831 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129250AbQKKClz>; Fri, 10 Nov 2000 21:41:55 -0500
Message-ID: <3A0CB1ED.C38B7667@linux.com>
Date: Fri, 10 Nov 2000 18:41:49 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: sendmail-bugs@sendmail.org, linux-kernel@vger.kernel.org
Subject: Re: Wild thangs, was: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue
In-Reply-To: <20001110095227.A15010@sendmail.com> <3A0C37FF.23D7B69@timpanogas.org> <20001110101138.A15087@sendmail.com> <3A0C3F30.F5EB076E@timpanogas.org> <20001110133431.A16169@sendmail.com> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <3A0C929B.EE6F7137@linux.com> <3A0C9277.273FA907@timpanogas.org> <3A0C96FD.8441F995@linux.com> <20001110202527.A3342@vger.timpanogas.org>
Content-Type: multipart/mixed;
 boundary="------------A8CB83D0EE4B167A1EE51A05"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A8CB83D0EE4B167A1EE51A05
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> They're not modprobes, they're misnamed processes sleeping from NWFS.

If they're sleeping, why are they in D state?  That ups the load average.


> I got the fix from someone so now they display their proper names.
> top displays the names correctly, ps does not.  Several people have
> verified this problem, and all you are saying is that your servers
> are never heavily loaded for long periods of time, say 200 hours
> at a stretch of consatnt ftp traffic?

If I had a normally expected constant load average that came very close to the
sendmail configured limit, I would increase the limit.  That's just common
sense for an admin.  Sendmail in itself doesn't affect the load average any
more than any daemon does.

If your normal operating load is significant, and your configured limits are
close to that, you have to expect sendmail to throttle back.  It doesn't pick
large emails as it's victims, everything gets throttled.

I would suspect that if you are near the limit then your disk is blocking
causing a load spike which is detected by sendmail so sendmail throttles back.

In my experience, Linux (and others) can be very sluggish at a load of 2 and at
another time be quite responsive w/ a load of 200.  An admin should configure
limits based on that machine's load history, not any given default number.

I've run sendmail for a lot of years at a lot of places.  I've never seen this
'large emails aren't sent' issue that people have verified.  The only reason I
find valid is if the machine hovers near the limit and disk io causes the
spike.  That isn't sendmail's fault, it's a configuration fault.

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------A8CB83D0EE4B167A1EE51A05
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------A8CB83D0EE4B167A1EE51A05--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
