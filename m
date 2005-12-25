Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVLYQue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVLYQue (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 11:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVLYQue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 11:50:34 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:41187 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750869AbVLYQud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 11:50:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jGeZvCMDC/oBLzYOKzD+QHK2V2IasEUrxZV9peklSCxrdRWaqRqzZQ0V43NDmOwmsUHscYltJRH1zIl7dobwH8qkCdr3lXCTzgPGnYEFukzGOBEr/nOjS9T2UIAJWz+Yo+LH+vRydFs76nmsWrnBTylScTU2q/F1/7cY7b0vGAY=
Message-ID: <aec8d6fc0512250850m4f8d4bd6y3772638d620548cd@mail.gmail.com>
Date: Sun, 25 Dec 2005 17:50:32 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-mentors@selenic.com
Subject: kernel list / container_of aka list_entry question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list readers,

I have two questions and I'll keep them short

First one is about list_entry definition which is just a wrapper to
container_of with exactly the same arguments (namely, ptr, type, member)
whereas container_of is defined as follows

/**
 * container_of - cast a member of a structure out to the containing structure
 *
 * @ptr:        the pointer to the member.
 * @type:       the type of the container struct this is embedded in.
 * @member:     the name of the member within the struct.
 *
 */
#define container_of(ptr, type, member) ({                      \
        const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
        (type *)( (char *)__mptr - offsetof(type,member) );})


My question is why is there a '0' inside a definition?

The second question is why the following code generates errors
during compilation. list.h header file is included.

        struct atheros_priv *priv = ieee80211_priv(dev); /* line number 141 */
	struct list_head *iterator;
	

	list_for_each(iterator, &priv->rxbuf.list) {
		struct ath_buf *bf = list_entry(iterator, (struct ath_buf), list);

		/* ... some operations on *bf here ... */
	}

and errors are as follows

  CC [M]  /home/mb/atheros/transmit_receive.o
  /home/mb/atheros/transmit_receive.c: In function 'ath_startrecv':
  /home/mb/atheros/transmit_receive.c:141: error: syntax error before ')' token
  /home/mb/atheros/transmit_receive.c:141: error: '__mptr' undeclared
(first use in this function)
  /home/mb/atheros/transmit_receive.c:141: error: (Each undeclared
identifier is reported only once
  /home/mb/atheros/transmit_receive.c:141: error: for each function it
appears in.)
  /home/mb/atheros/transmit_receive.c:141: error: syntax error before ';' token
  /home/mb/atheros/transmit_receive.c:141: error: syntax error before ')' token
  /home/mb/atheros/transmit_receive.c:141: error: syntax error before '(' token
  /home/mb/atheros/transmit_receive.c:141: error: 'list' undeclared
(first use in this function)
  make[2]: *** [/home/mb/atheros/transmit_receive.o] Error 1


I'd appreciate if someone could help me with this problem.

kind regards
Mateusz Berezecki
