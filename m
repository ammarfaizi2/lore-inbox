Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVCEHE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVCEHE2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 02:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVCEHE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 02:04:28 -0500
Received: from web41401.mail.yahoo.com ([66.218.93.67]:22894 "HELO
	web41401.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262110AbVCEHEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 02:04:22 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=LrDEieO2rqePnSFMp38YHc+jpdKASj0mazBeFg5ierwBLrsAYLlaa0ER8txk30xTBILlM1TJ8PZR6QyQgVyr1rcturBrtKh7JVW44E3cyfvD3YiiEiM1266WTVkAgtPbFPvAVDUeEcJi2I9xzCCYoxMJ8xvlPMZAp3S+vx0WjMM=  ;
Message-ID: <20050305070421.12802.qmail@web41401.mail.yahoo.com>
Date: Fri, 4 Mar 2005 23:04:21 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: strace on cat /proc/my_file gives results by calling read twice why?
To: kernel newbies <kernelnewbies@nl.linux.org>,
       kernerl mail <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hello,
      I have a /proc file kernel module with its proc
read function as
static char mybuf[1024];
ssize_t my_file_read(struct file *filp, char *buf,
size_t count, loff_t *ppos)
{
   printk("Reading a from a /proc file....\n");
   static int b_read = 0;

    int len = strlen(mybuf);

    if (len == 0 || b_read) {
        b_read = 0;
        return 0;
    }

    if (len > count - 1)
        len = count - 1;

    copy_to_user(buf, mybuf, len);
    put_user(0, &buf[len]);
    ++len;
    b_read = 1;
    return len;
}

when i strace cat /proc/my_file i found message
printing twice
Reading a from a /proc file....
Reading a from a /proc file....
       Why that happening?
          Also i check by writing to it as cat >
/proc/my_file
and got single result for write function call not
twice as for read.

regards,
cranium


	
		
__________________________________ 
Celebrate Yahoo!'s 10th Birthday! 
Yahoo! Netrospective: 100 Moments of the Web 
http://birthday.yahoo.com/netrospective/
