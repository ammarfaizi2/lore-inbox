Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263113AbTDBRqt>; Wed, 2 Apr 2003 12:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263114AbTDBRqt>; Wed, 2 Apr 2003 12:46:49 -0500
Received: from 66-133-183-62.br1.fod.ia.frontiernet.net ([66.133.183.62]:56259
	"EHLO www.duskglow.com") by vger.kernel.org with ESMTP
	id <S263113AbTDBRqs>; Wed, 2 Apr 2003 12:46:48 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Miller <rmiller@duskglow.com>
To: linux-kernel@vger.kernel.org
Subject: subsystem crashes reboot system?
Date: Wed, 2 Apr 2003 11:49:36 -0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200304021149.36511.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a feature request, I'm willing to hack away at it myself, but I want to 
know if there's any way of doing what I want to, or if there's a good 
technical reason why it would be impossible.

As I mentioned earlier, we had an ext3 subsystem crash, which a helpful person 
was nice enough to tell me that upgrading the kernel would fix.  All well and 
good.  But this crash left the system in a semi-functional state.  The 
networking stack was up and running, the kernel was running, but the 
filesystem was not functional and because of this the kernel was in a nearly 
unusable state.  Because the system was pingable, most tcp-stack level 
detectors would not have been able to tell that something serious was wrong.  
The machine (our main production machine that serves millions of hits a week) 
was down for three hours.

Since this was an assertion that failed, one would think that bringing the 
system down automatically in an orderly - then, if that fails, disorderly - 
fashion would be possible.  In particular, I would like for it to behave 
similar as with the panic sysctl.  If a subsystem crashes, reboot the 
machine, because the system is essentially worthless in that state.  I 
realize that this behavior isn't required for everyone, so a sysctl 
(panic_on_subsys_crash maybe) would be sufficient.

Since the machine was in a semi-usable state, one might ask why we just didn't 
have an automated process in place.  Two reasons:  a subsystem crashing 
happens rarely enough that I didn't see any reason to put the effort into it 
until now, and when the system is in a state like that it is impossible to 
tell what will work and what will not.  For example, when we did the three 
finger salute, the system would not go down all the way because one of the 
user space programs made an io call to the crashed filesystem.

In order of helpfulness, please tell me (only one of the following is more 
than enough):
- whether I can do this using the existing sysctl mechanism
- whether there is a patch available (or coming available) to do this
- whether there is a technical reason for me not to do this
- what would be a good place in the code to begin applying a patch.

Please CC me with any replies as I am not on the list.

Thanks.

--Russell
