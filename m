Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRIZX2p>; Wed, 26 Sep 2001 19:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275695AbRIZX2g>; Wed, 26 Sep 2001 19:28:36 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:61658 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S275693AbRIZX2Z>; Wed, 26 Sep 2001 19:28:25 -0400
Importance: Normal
Subject: Bug in tcp_v4_hnd_req?
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Utz Bacher" <utz.bacher@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF9A5AA6CF.110D18E7-ONC1256AD3.0080234F@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Thu, 27 Sep 2001 01:27:33 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 27/09/2001 01:28:45
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the following code in tcp_v4_hnd_req looks broken:

     if (nsk) {
          if (nsk->state != TCP_TIME_WAIT) {
               bh_lock_sock(nsk);
               return nsk;
          }
          tcp_tw_put((struct tcp_tw_bucket*)sk);
          return NULL;
     }

Shouldn't it put *nsk* instead of sk?  This appears to be the cause of
weird crashes under heavy network load we've been experiencing ...


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

