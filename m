Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSFDCFB>; Mon, 3 Jun 2002 22:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSFDCFA>; Mon, 3 Jun 2002 22:05:00 -0400
Received: from ausxc10.us.dell.com ([143.166.98.229]:55819 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S316088AbSFDCFA>; Mon, 3 Jun 2002 22:05:00 -0400
Message-ID: <9A2D9C0E5A442340BABEBE55D81BEBDB0120518A@AUSXMPS313.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: matti.aarnio@zmailer.org
Cc: linux-kernel@vger.kernel.org
Subject: RE: please kindly get back to me
Date: Mon, 3 Jun 2002 21:04:53 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2002-06-03 at 20:23, Matti Aarnio wrote:
> I think there are several free codes of this kind 
> available, but my time
> has been chronically over-subscribed to do radical things 
> like taking this kind of codes into use.

I've been using SpamAssassin on lists.us.dell.com for a couple months now.
It's pretty effective, but of course not perfect - maybe one a month gets
through, though I'm dealing with less traffic than vger.  I'm not actually
filtering linux-kernel-digest or -daily-digest, except to verify that the
mail actually was sent from vger and not some spammer.  With procmail
recipies, it works quite well.  Because I'm using mailman, it's a
multi-stage thing.  Procmail does the heavy lifting, and mailman sticks
suspected spam in the moderator queue.

/etc/aliases has:
linux-poweredge:         "|procmail -m /etc/procmailrcs/spamfilter post
linux-poweredge"

/etc/procmailrcs/spamfilter has:
# drop known spam senders in our killfile
:0
* ? formail -x"From" -x"From:" -x"Sender:" -x"X-Envelope-Sender:" | egrep
-is -f
 /home/mailman/SPAMMERS
/dev/null

:0fw
| spamc

# This avoids having to moderate completely obvious spam.
# Send obvious spam to /var/spool/mail/caught-spam
# Eventually we'll just send it to /dev/null instead.
:0
* ? formail -x"X-Spam-Status:" | sed -e 's/hits=//g' | \
    awk '{if ($2 < 10) exit 1}'
caught-spam

:0
|/home/mailman/mail/wrapper $1 $2


Messages that match known spammers are dropped.
Messages with scores < 5 are considered not spam.
Messages with scores 5-10 are caught by Mailman filters and dropped into
moderator queue
Messages with scores > 10 are stored in caught-spam, could be /dev/null - it
hasn't missed yet.
Mailman then has its own list of things to catch for moderation, and I've
mimic'd vger's filters too.

Successful messages give automatic whitelist points to the author, which
cuts down on false positives from people who post regularly.  In all I'm
quite pleased.  A useful addition would be automatic updates of rules as
they get added to CVS, but SpamAssassin isn't mature enough to allow such
quiet yet.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001! (IDC Mar 2002)
