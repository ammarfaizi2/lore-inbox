Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277719AbRJLOwa>; Fri, 12 Oct 2001 10:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277721AbRJLOwV>; Fri, 12 Oct 2001 10:52:21 -0400
Received: from web11903.mail.yahoo.com ([216.136.172.187]:60422 "HELO
	web11903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277719AbRJLOwQ>; Fri, 12 Oct 2001 10:52:16 -0400
Message-ID: <20011012145247.62082.qmail@web11903.mail.yahoo.com>
Date: Fri, 12 Oct 2001 07:52:47 -0700 (PDT)
From: Kirill Ratkin <kratkin@yahoo.com>
Subject: I can loop dev_base only once. Why?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I have a problem.

I write module which scans network device list. 
I made:

int init(void)
{
  struct net_device *dev, **dp;

  printk("<1>Ok\n");
  while ((dev = *dp) != NULL) {
    printk("<1>Searching ...\n"); 
    write_lock_bh(&dev_base_lock);

    /* ... here I change one fileld ... */

    *dp = dev->next;
    write_unlock_bh(&dev_base_lock);
  }
  return 0;
}

void cleanup(void)
{
  while ((dev = *dp) != NULL) {
    write_lock_bh(&dev_base_lock);

    /* ... here turn change back  ... */

   *dp = dev->next;
   write_unlock_bh(&dev_base_lock);
 }
}

The problem:
This code works only once. Then I remove module and
start it again I see only 'Ok' string. Could you
explain me where is problem?

Regards,
Kirill.

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
