Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136903AbREJTNz>; Thu, 10 May 2001 15:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136902AbREJTNp>; Thu, 10 May 2001 15:13:45 -0400
Received: from Xenon.Stanford.EDU ([171.64.66.201]:49819 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S136901AbREJTN3>; Thu, 10 May 2001 15:13:29 -0400
Date: Thu, 10 May 2001 12:13:26 -0700 (PDT)
From: William Ie <wie@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
cc: mc@CS.Stanford.EDU
Subject: another potential security bug
Message-ID: <Pine.GSO.4.21.0105101204230.15916-100000@Xenon.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, my name is William Ie and I am currently working under Dawson Engler's
mc project here in the Stanford CS dept. We are currently trying to
develop security related bug-checkers, particularly regarding the
capability checks done in the linux kernel. While going through the
results of our prototype checker, we run into the following anomaly and
thus was wondering if this is merely a false positive. Thank you very much
for your input.

 linux/2.4.3/drivers/net/pcmcia/netwave_cs.c
   case SIOCGIWENCODE:
 	/* Get scramble key */
 ERROR<-	if(wrq->u.encoding.pointer != (caddr_t) 0)
 	  {
 	    char	key[2];
 	    key[1] = scramble_key & 0xff;
 	    key[0] = (scramble_key>>8) & 0xff;
 	    wrq->u.encoding.flags = IW_ENCODE_ENABLED;
 	    wrq->u.encoding.length = 2;
 	    if(copy_to_user(wrq->u.encoding.pointer, key, 2))
 	      ret = -EFAULT;
 	  }
 	break;

 handling the same command with CAP_NET_ADMIN capability checks  are done
in:
 drivers/net/wavelan.c
 drivers/net/pcmcia/orinoco_cs.c
 drivers/net/pcmcia/wavelan_cs.c


