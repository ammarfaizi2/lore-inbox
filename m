Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGTxx>; Wed, 7 Feb 2001 14:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130460AbRBGTxn>; Wed, 7 Feb 2001 14:53:43 -0500
Received: from denise.shiny.it ([194.20.232.1]:20752 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S129032AbRBGTxi>;
	Wed, 7 Feb 2001 14:53:38 -0500
Message-ID: <3A806260.BB77D017@denise.shiny.it>
Date: Tue, 06 Feb 2001 21:45:20 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.1 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 tcp ack bug ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IMHO this tcpdump trace is quite strange:


20:56:25.232532 ppp0 < mc105-v-2.royaume.com.6699 > ppp12.shiny.it.33148: .
96265:97725(1460) ack 77 win 8684 (DF)
20:56:25.242532 ppp0 > ppp12.shiny.it.33148 > mc105-v-2.royaume.com.6699: .
77:77(0) ack 88073 win 62780 <nop,nop, sack 1 {90121:97725} > (DF)
20:56:25.352532 ppp0 < mc105-v-2.royaume.com.6699 > ppp12.shiny.it.33148: P
97725:98313(588) ack 77 win 8684 (DF)
20:56:25.362532 ppp0 > ppp12.shiny.it.33148 > mc105-v-2.royaume.com.6699: .
77:77(0) ack 88073 win 62780 <nop,nop, sack 1 {90121:98313} > (DF)
20:56:26.172532 ppp0 < mc105-v-2.royaume.com.6699 > ppp12.shiny.it.33148: .
88073:89533(1460) ack 77 win 8684 (DF)
20:56:26.302532 ppp0 < mc105-v-2.royaume.com.6699 > ppp12.shiny.it.33148: P
89533:90121(588) ack 77 win 8684 (DF)

Ok, it has just received the missing part, so why it does not ack 98313 ?

20:56:26.312532 ppp0 > ppp12.shiny.it.33148 > mc105-v-2.royaume.com.6699: .
77:77(0) ack 88073 win 62780 <nop,nop, sack 1 {89533:98313} > (DF)
20:56:32.272532 ppp0 < mc105-v-2.royaume.com.6699 > ppp12.shiny.it.33148: .
88073:89533(1460) ack 77 win 8684 (DF)
20:56:32.282532 ppp0 > ppp12.shiny.it.33148 > mc105-v-2.royaume.com.6699: .
77:77(0) ack 98313 win 52560 (DF)


I have other traces where the sack interval looks wrong too, let me know if
you're interested.


[kernel 2.4.1, gcc 2.95.3, tcpdump 3.4, ppp 2.4.0, PowerPC 750]

Bye.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
