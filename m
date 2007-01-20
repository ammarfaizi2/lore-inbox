Return-Path: <linux-kernel-owner+w=401wt.eu-S1750774AbXATXHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXATXHA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 18:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbXATXG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 18:06:59 -0500
Received: from web52909.mail.yahoo.com ([206.190.49.19]:44141 "HELO
	web52909.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750842AbXATXG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 18:06:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=iq/ZBVOZu2kC4MUlKw5hSkHcwprh4mnEdZcUqcAz48nQS3asvlLQOZUceUg2GqT7JlZWbeR6UnBqLDVZUfR2iAX8w5Ds0WUXPukL2CdEfzN4Ct0ON0qjCsDFYHfpOl79w5XMHIO8FtEzF/0XGwq7rd2qeGaTFptf2CNI1JdWHcA=;
X-YMail-OSG: D8ZArzAVM1npA_8g5r9E.2PUbzDjplvYE5bcUGd2Fx3wa8jvhYIPSU2ciDDLaLwZNKCqhBo.g2DamQ1_nlig7tFtcJqA62fJWVHpKtIOaFImaFoxN.agCs9KbSzcgZTWdyJUu7ZbPvaqYQKMBc0K0SAOaIF6TBBGL4LljUN7Gf3owtwQVtMVakgEKCyh
Date: Sat, 20 Jan 2007 23:06:57 +0000 (GMT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: [BUG] Sleeping function called from invalid context (2.6.18.6)
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <957323.87386.qm@web52909.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been testing my wireless zd1211rw driver with kismet, but have noticed my logs filling up
with these messages instead:

BUG: sleeping function called from invalid context at kernel/mutex.c:86
in_atomic():0, irqs_disabled():1
 [<c029688e>] mutex_lock+0x12/0x1a
 [<c02496ae>] netdev_run_todo+0x10/0x1f1
 [<c024a148>] dev_ioctl+0x465/0x497
 [<c01626ff>] d_rehash+0x47/0x78
 [<c0240379>] sock_attach_fd+0x6c/0xcb
 [<c023fc9d>] sock_ioctl+0x0/0x1b3
 [<c015e508>] do_ioctl+0x1c/0x5d
 [<c015e78a>] vfs_ioctl+0x241/0x254
 [<c015e7c9>] sys_ioctl+0x2c/0x43
 [<c0102c3f>] syscall_call+0x7/0xb

According to the comment in linux/net/core/dev.c

 * 2) Since we run with the RTNL semaphore not held, we can sleep
 *    safely in order to wait for the netdev refcnt to drop to zero.

Well, apparently we can't sleep safely after all because IRQs have been disabled.

Cheers,
Chris



	
	
		
___________________________________________________________ 
New Yahoo! Mail is the ultimate force in competitive emailing. Find out more at the Yahoo! Mail Championships. Plus: play games and win prizes. 
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk 
