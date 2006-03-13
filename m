Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWCMNtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWCMNtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 08:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWCMNtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 08:49:07 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:33515 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750769AbWCMNtG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 08:49:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bql71Hl2vPXrcpE0vIfz7DGn4CIemMl3dGZ26TAkRkds/K3qnn533iOW5F38f7cV4xSJaGZjkkWzwuAizeS9hB9UqJj0b1BoUiHDiTh5cOXunKiqzLOuahpxSkHTAWVJ8q0U7cc3iNc5QKuGcWqjgN3Ijs1cDfETFi8DdWoZsvY=
Message-ID: <3f250c710603130549w6ccdf14cu73a0d7d2999fd4ee@mail.gmail.com>
Date: Mon, 13 Mar 2006 09:49:04 -0400
From: "Mauricio Lin" <mauriciolin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Jiffy is not able to measure the fraction of time a process runs a processor
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

 I am trying to measure the fraction of time a process runs on a
processor, but the jiffies is not able to provide an accurate value.

 The example below shows that in one kernel tick or one jiffy, kmix
and  lpd was schedule in the same processor and the cpu time of each
one was  zero. The calculation of cpu time is based on jiffies and the
cpu time  is zero because the jiffy value was not incremented yet.

  PID  :  NAME              : LAST ARRIVAL : CPU TIME            : CALLER
 4544  : kmix                  : 6170433                 : 0          
                 : work_resched+0x6c
 4078  : lpd                     : 6170433                 : 0        
                   : __down_interruptible+0x5
 4544  : kmix                  : 6170433                 : 0          
                  : schedule_timeout+0xb8


 Look again, when jiffies is 6170503 klipper and emacs are scheduled
many  times.

 4534  : klipper               : 6170503                 : 0          
                : preempt_schedule_irq+0xb8
 4534  : klipper               : 6170503                 : 0          
                : preempt_schedule+0x3d
 4534  : klipper               : 6170503                 : 0          
                : work_resched+0x34
 4534  : klipper               : 6170503                 : 0          
                : work_resched+0x5
 4534  : klipper               : 6170503                 : 0          
                : preempt_schedule+0x5
 4534  : klipper               : 6170503                 : 0          
                : work_resched+0x34
 4534  : klipper               : 6170503                 : 0          
                : work_resched+0x5
 4534  : klipper               : 6170503                 : 0          
                : work_resched+0x5
 4534  : klipper               : 6170503                 : 0          
                : work_resched+0x5
 4534  : klipper               : 6170503                 : 0          
                : work_resched+0x5
 4534  : klipper               : 6170503                 : 0          
                : work_resched+0x5
 16150 : emacs               : 6170503                 : 0            
              : work_resched+0x5
 16150 : emacs               : 6170503                 : 0            
              : work_resched+0x5
 16150 : emacs               : 6170503                 : 0            
              : work_resched+0x5
 16150 : emacs               : 6170503                 : 0            
              : preempt_schedule+0x5
 16150 : emacs               : 6170503                 : 0            
              : schedule_timeout+0x34
 4534  : klipper               : 6170503                 : 0          
                : preempt_schedule+0x6c
 4534  : klipper               : 6170503                 : 0          
                : work_resched+0x34
 4534  : klipper               : 6170503                 : 0          
                : work_resched+0x5
 4534  : klipper               : 6170503                 : 0          
                : schedule_timeout+0x5

 Does anyone know how can I measure precisely the fraction of time a
process runs on a processor?

 BR,

 Mauricio Lin.
