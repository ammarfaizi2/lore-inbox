Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132026AbQKKA3B>; Fri, 10 Nov 2000 19:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132097AbQKKA2v>; Fri, 10 Nov 2000 19:28:51 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:24623 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S132036AbQKKA2k>; Fri, 10 Nov 2000 19:28:40 -0500
Message-ID: <3A0C929B.EE6F7137@linux.com>
Date: Fri, 10 Nov 2000 16:28:11 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
CC: sendmail-bugs@sendmail.org, linux-kernel@vger.kernel.org,
        Neil W Rickert <sendmail+rickert@sendmail.org>,
        Claus Assmann <sendmail+ca@sendmail.org>
Subject: Wild thangs, was: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue
In-Reply-To: <3A0C427A.E015E58A@timpanogas.org> <20001110095227.A15010@sendmail.com> <3A0C37FF.23D7B69@timpanogas.org> <20001110101138.A15087@sendmail.com> <3A0C3F30.F5EB076E@timpanogas.org> <20001110133431.A16169@sendmail.com> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org>
Content-Type: multipart/mixed;
 boundary="------------6E9D5CFF3E9D4EFCC223C9C7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6E9D5CFF3E9D4EFCC223C9C7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Some wild blatherings about sendmail...

- Uses lots of memory to send a big file.
    Incorrect.  I just verified it with a 10 meg file which became a 14 meg attachment.
Sendmail consumed an additional 5 megs combined while handling the input and output v.s.
an idle daemon.  Idle is 1.8M, recv was 4.0M, send was 2.3M, no measure on the remote
side.  I sent it via pine to a remote address.

- Requires high load average allowance
    Incorrect.  Same machine barely spiked a tenth of a point for this load and dropped
back to .05.  Only time I adjusted the configured load average allowance was back in my
naive days and we got hit with 80,000 in the queue at one time from multiple spammers.
Part of this test's load came from numerous things running and the mail sending required
spinup of the drive which blocked.

- Can't send large files
    Incorrect.  I've used sendmail for the last seven years and sometimes sent emails
with attachments totally near 100 megs.  I very frequently handle mails through this
queue that are larger than 1M.

- Qmail's time has come v.s. sendmail
    I strongly disagree, I'm not the richest person or company so I frequently run most
things on one box.  Sendmail handles perfectly fine.  If your setup is hitting the sky
with load average or failing to send mails, you have a site setup problem.

- New sendmails have problems talking to old sendmails.
    Not since I discovered the problem was ECN and not sendmail.

I noticed in the original email that the system was stuck in D state on the
/sbin/modprobe for 11 nwfs attempts.  Did nobody notice this?  (load average goes up due
to IO bound procs; D state)  I have a lot of options enabled w/ all of my sendmail
setups, and most of them include patches to use SQL for the tables which requires even
more daemons to be active.

In short, sendmail does just fine on linux.  If it's not doing just fine, there's static
in the headset.  There isn't any TCP/IP issue or we would have heard a whole lot more
screeching.

End.

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------6E9D5CFF3E9D4EFCC223C9C7
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

--------------6E9D5CFF3E9D4EFCC223C9C7--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
