Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265117AbRFUTEu>; Thu, 21 Jun 2001 15:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265118AbRFUTEp>; Thu, 21 Jun 2001 15:04:45 -0400
Received: from web9604.mail.yahoo.com ([216.136.129.183]:5640 "HELO
	web9604.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265116AbRFUTEg>; Thu, 21 Jun 2001 15:04:36 -0400
Message-ID: <20010621190434.82955.qmail@web9604.mail.yahoo.com>
Date: Thu, 21 Jun 2001 12:04:34 -0700 (PDT)
From: abc abc <netlogin_99@yahoo.com>
Subject: rename problem on vfat file systems
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been having problems using rename system call
on vfat file systems. I have looked at the kernel code
and tried everything I could do to figure out what
might be going wrong. As a last resort I thought you
might be able to help me.

The /etc/fstab entry for the drive that I mount looks
like this

/dev/sdc1 /mnt/sns-c vfat noauto,sync,user 0 0

here's the code snippet of what I am trying to do

int copy_seg_file(char *segFile)
{
  char command[128];
  sprintf(command, "cp %s /mnt/sns-c/tmp/segfile",
          *segFile);
  system(command);
  sync();
  rename("/mnt/sns-c/tmp/segfile",
         "/mnt/sns-c/segments/segfile");
  printf("file copied\n");
}

initially the file is copied to the temporary
directory to deal with the power outage during the
file copy. Once the file is completely copied, it will
be renamed to the final destination.

If I reboot the machine just after the rename() call
is completed, when the machine comes up the file
/mnt/sns-c/segments/segfile has zero bytes and there
is no file in the tmp directory. Effectively the file
is lost some where. Running fsck recovers the file,
but it doesn't help me much because I would be copying
hundreds of files and its difficult to match the
files.

Can you think of any thing that might be causing this.
Any help is highly appreciated.

Thanks,
Kumar

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
