Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270239AbTGWM1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 08:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270237AbTGWM1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 08:27:08 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:16295 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S270239AbTGWM1E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 08:27:04 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01BCA5C4@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: jimis@gmx.net, linux-kernel@vger.kernel.org
Subject: RE: Feature proposal (scheduling related)
Date: Wed, 23 Jul 2003 14:42:08 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jimis,

	I have been thinking about some /etc/nice file where kernel could
pick up process nice
when doing the sys_execve stuff.Maybe it could help ...

Regards,
Fabian

-----Message d'origine-----
De : jimis@gmx.net [mailto:jimis@gmx.net]
Envoyé : mercredi 23 juillet 2003 12:58
À : linux-kernel@vger.kernel.org
Objet : Feature proposal (scheduling related)


With the current scheduler we can prioritize the CPU usage for each process.

What I think would be extremely useful (as I have needed it many times) is
the 
scheduling of disk I/O and net I/O traffic. 2 examples showing the
importance 
(the numbers are estimations just to explain whati I mean):

1)I 'm connected to the internet via dial-up, therefore I only have 40 kbits
of 
bandwidth available. What I want to do is listen to icecast radio via xmms
(at 
22 kbits), download the kernel sources with wget, and browse the web at the
same 
time. Currently I think that this is *impossible* (correct me if I'm wrong)
as 
the radio will be full of pauses and the browsing experience painfully slow.

What I would like to be able to do (let's suppose nice has the --net option
to 
set net I/O priority):
$ nice --net -1 xmms
$ nice --net 1 wget ftp://.../KernelSources.tar.bz2
$ mozilla
This way, xmms which has top priority whould always get the 22kbits it
needs. 
What remains should go to the browser when I ask for a web page, and when
the 
browser doesn't request anything (let's say I'm reading a big doc in tldp)
what 
remains should go to wget. Wget has lower priority and won't irritate the 
browsing experience, though the file will be downloaded when there is free 
bandwidth.

2) Normally mozilla starts in 5 seconds after intense disk I/O to load all 
needed libraries. If I run in the background a long disk intense process
(like find / -name 'whatever' -xdev) loading mozilla could need 20 boring 
seconds, or doing other simple tasks might be irritating slow. What I would
like 
to be able to do is (once again let's suppose nice has the --disk option to
set 
disk I/O priority):
$ nice --disk 1 find / -name 'whatever' -xdev
$ mozilla
and load mozilla ,which has the default disk priority 0, fast. The scheduler

should give to mozilla most disk troughput when it needs it.

Notes:
1) PLEASE CC REPLIES BACK TO ME since I 'm not subscribed to the list (I
can't 
stand the traffic). However I 'll be checking periodically the list via
NNTP.
2) As I have no idea of kernel programming I hope what I propose is
aplicable 
and relevant to the kernel, as I believe. Sorry if not.
3) I hope what I propose is implementable using the existing scheduler. It
would 
be nice to have one scheduler to handle them all.
4) I believe that these features don't need a lot of CPU power because the
disk 
and net I/O troughput are relatively slow.
5) If you think that UNIX tradition forbits what I propose I must say that
these 
features could be invisible to programs, setting the new  priorities to the 
default 0 or maybe to the same number as CPU priority.

Thank you very much for your time,
Dimitris


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
