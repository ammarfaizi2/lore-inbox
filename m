Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbVIWNQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVIWNQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 09:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVIWNQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 09:16:49 -0400
Received: from web52614.mail.yahoo.com ([206.190.48.217]:29308 "HELO
	web52614.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750968AbVIWNQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 09:16:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=UfzvXdT0x9BkXVGWstZQwqAKO9T68VI0JFBwUSAWGxtq9JBU5z6H0UYDY4sJVXvhVd9OCbwspwRfVNqh2PKhiY78Q96Da9qBTudJimC8tunjozpl5KUOYqTM06cXNBceb1E0woPslbup9p8Y3XUCGdsnWL4ZrEQaPNrbAu6u3ow=  ;
Message-ID: <20050923131642.12688.qmail@web52614.mail.yahoo.com>
Date: Fri, 23 Sep 2005 23:16:42 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: [PROBLEM] USB Storage & D state processes
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware:
Athlon 64
VIA K8T 800

Software:
FC4
2.6.14-rc2 (vanilla)

Few usb-storage process are stuck in D state:
usb-storage   D 000000000000000a     0  8176      1   
      8250  3455 (L-TLB)
ffff8100121bfe08 0000000000000046 000000000000026b
ffff81002ec8d870
       ffff81002a47c750 ffffffff802f2750
ffff8100121bfe38 0000000000000046
       00000000000000c1 ffffffff803e6110
Call Trace:<ffffffff802f2750>{thread_return+0}
<ffffffff802f2bba>{wait_for_completion+154}
       <ffffffff8012ecd0>{default_wake_function+0}
<ffffffff80145dd0>{kthread_stop+128}
      
<ffffffff88001635>{:scsi_mod:scsi_host_dev_release+69}
       <ffffffff801dd8a1>{kobject_cleanup+97}
<ffffffff801dd900>{kobject_release+0}
       <ffffffff801de0f0>{kref_put+96}
<ffffffff882401a4>{:usb_storage:usb_stor_control_thread+500}
       <ffffffff8010f3b6>{child_rip+8}
<ffffffff8823ffb0>{:usb_storage:usb_stor_control_thread+0}
       <ffffffff8010f3ae>{child_rip+0}

usb-storage   D 000000000000000a     0  9569      1   
     16314  8250 (L-TLB)
ffff81000fdcfda8 0000000000000046 0000000000000233
ffff81000b5315f0
       ffff810037b14910 ffffffff8823ec40
ffffffff8012ecd0 0000000000100100
       0000000000200200 ffffffff803544b0
Call
Trace:<ffffffff8823ec40>{:usb_storage:usb_stor_msg_common+336}
       <ffffffff8012ecd0>{default_wake_function+0}
<ffffffff802f355e>{__down+222}
       <ffffffff8012ecd0>{default_wake_function+0}
<ffffffff802f31f3>{__down_failed+53}
      
<ffffffff880015f0>{:scsi_mod:scsi_host_dev_release+0}
       <ffffffff801460d1>{.text.lock.kthread+5}
<ffffffff88001635>{:scsi_mod:scsi_host_dev_release+69}
       <ffffffff801dd8a1>{kobject_cleanup+97}
<ffffffff801dd900>{kobject_release+0}
       <ffffffff801de0f0>{kref_put+96}
<ffffffff882401a4>{:usb_storage:usb_stor_control_thread+500}
       <ffffffff8010f3b6>{child_rip+8}
<ffffffff8823ffb0>{:usb_storage:usb_stor_control_thread+0}
       <ffffffff8010f3ae>{child_rip+0}
usb-storage   D 000000000000000a     0 16314      1   
            9569 (L-TLB)
ffff81000d32dda8 0000000000000046 000000000000027e
ffff81000b530850
       ffff81002a47d4f0 ffffffff8823ec40
0000000000000000 ffff81000d32c000
       ffff81000b530f20 ffffffff803544b0
Call
Trace:<ffffffff8823ec40>{:usb_storage:usb_stor_msg_common+336}
       <ffffffff802f355e>{__down+222}
<ffffffff8012ecd0>{default_wake_function+0}
       <ffffffff802f31f3>{__down_failed+53}
<ffffffff880015f0>{:scsi_mod:scsi_host_dev_release+0}
       <ffffffff801460d1>{.text.lock.kthread+5}
<ffffffff88001635>{:scsi_mod:scsi_host_dev_release+69}
       <ffffffff801dd8a1>{kobject_cleanup+97}
<ffffffff801dd900>{kobject_release+0}
       <ffffffff801de0f0>{kref_put+96}
<ffffffff882401a4>{:usb_storage:usb_stor_control_thread+500}
       <ffffffff8010f3b6>{child_rip+8}
<ffffffff8823ffb0>{:usb_storage:usb_stor_control_thread+0}
       <ffffffff8010f3ae>{child_rip+0}

Yum is in the middle of updating the system, & I think
it's stuck due to these problems. If possible I'd love
to avoid any reboots/restarts etc., so that yum may
complete its job :-(.

I have nothing mounted through usb storage ATM, though
I must have had something earlier today.

Thanks
Hari

Send instant messages to your online friends http://au.messenger.yahoo.com 
