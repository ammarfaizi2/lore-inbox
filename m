Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbULPSt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbULPSt5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbULPStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:49:10 -0500
Received: from web51501.mail.yahoo.com ([206.190.38.193]:27528 "HELO
	web51501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261980AbULPSsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:48:32 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=23MSgv3bW8x2lcUtLNUCCLs/d9eX4/nflVFl5E8goUO+F6sGX230FUv914XkKk09zcVkHci5aj2eyFtJbursy9BuUGwBz0J7fI3JXwO2qMJv8I91SwmLFWR8oww9+/HSe5DyrHe+C2h7XdVUhk5XNYYl059KW9HgViiO/jgmkH4=  ;
Message-ID: <20041216184827.7357.qmail@web51501.mail.yahoo.com>
Date: Thu, 16 Dec 2004 10:48:27 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Issue on netconsole vs. Linux kernel oops
To: mpm@selenic.com, Paulo Marques <pmarques@grupopie.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <41C1A31A.5070902@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'd like to use netconsole to send local Linux
kernel's final messages (i.e. oops) to remote machine
when the kernel crashes. 
  Now I can successfully use a built-in netconsole to
send some loacl kernel messages to the remote machine.
(the parameter I send to local kernel on kernel
command line is
"netconsole=@192.168.0.2/,514@192.168.0.1/", I run
syslogd in remote machine). For example, When the
local kernel is booting, it will send a message
"192.168.0.2 audit(1103247021.091:0): initialized" to
remote machine through netconsole, and the syslogd on
remote machine will write the message to
/var/log/messages on remote machine.
  What CONFUSE me most is that when the kernel
crashes, there is NO message (oops) about the crash
being wrote down by syslogd on remote machine to
remote /var/log/messages file at all!! 
  But in the mean time, We can see the outputs of
tcpdump on the remote machine, they are some thing
like the following:

01:36:56.692877 IP 192.168.0.2.6665 >
192.168.0.1.syslog: UDP, length 48
01:36:56.692930 IP 192.168.0.2.6665 >
192.168.0.1.syslog: UDP, length 29
01:36:56.692982 IP 192.168.0.2.6665 >
192.168.0.1.syslog: UDP, length 15
01:36:56.693034 IP 192.168.0.2.6665 >
192.168.0.1.syslog: UDP, length 9
01:36:56.693086 IP 192.168.0.2.6665 >
192.168.0.1.syslog: UDP, length 16
01:36:56.693121 IP 192.168.0.2.6665 >
192.168.0.1.syslog: UDP, length 16
   ... ...

  From these messages, we can see that the netconsole
actually have sent the final messages (oops) to remote
machine when the local kernel crashed. But there are
no corresponding messages recorded by syslogd on
remote machine to /var/log/messages.

  Then, Where are these messages go? Do they disappear
themselves? 
  Is this a fault in netconsole or in syslogd, or Am I
miss to configure something obvious? Would you please
give me some hints on solving this problem?

  Thank you very much.



=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Jazz up your holiday email with celebrity designs. Learn more. 
http://celebrity.mail.yahoo.com
