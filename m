Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135321AbRA2Q1m>; Mon, 29 Jan 2001 11:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135330AbRA2Q1d>; Mon, 29 Jan 2001 11:27:33 -0500
Received: from h56s242a129n47.user.nortelnetworks.com ([47.129.242.56]:40906
	"EHLO zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S135184AbRA2Q1O>; Mon, 29 Jan 2001 11:27:14 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDCE2@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'clock@atrey.karlin.mff.cuni.cz'" <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
Subject: RE: CBQ simply doesn't work
Date: Mon, 29 Jan 2001 10:38:39 -0500
X-Mailer: Internet Mail Service (5.5.2652.35)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	/sbin/insmod cls__u32

	insmod: cls__u32: no module by that name found

I think you meant cls_u32, not cls__u32.  Your script output seems to
indicate that you've already got the modules loaded somewhere.

	tc class add dev ppp0 parent 10:1 classid 10:300 cbq bandwidth
28Kbit rate 3Kbit allot 1514 weight 3Kbit prio 5 maxburst 20 avpkt 1000

To get a 3kbit flow, you need the 'bounded' keyword in that line.  Without
it, it will borrow all available bandwidth.

Further, you didn't appear to include your filter definitions in your
script.  If the bounded keyword doesn't fix it, check what you are matching
in your filters.  Packets not matching will sail right between your queues
without a care in the world.

Jon

> I can't get the CBQ running on 2.2.17. Alexey look like he 
> doesn't reply to his
> mails.  I made one more man to check it over me. We both 
> can't find a problem.
> The file with config info is attached.
> 
> Eager for any idea
> 
> Clock
> 
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
