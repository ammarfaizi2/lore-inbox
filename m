Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbTIPOaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTIPOaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:30:46 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:50155 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S261896AbTIPOao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:30:44 -0400
Message-ID: <3F671E51.7030604@blue-labs.org>
Date: Tue, 16 Sep 2003 10:29:37 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030912
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: NFS issues, the usual :-/   up to 2.6.0-test5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In short, NFS client (mail/web server) pulls /home from NFS server 
(shell).  The below is from the shell server; nfs debug level 2.  For 
the environment, the two servers are very un-loaded.  Server is rarely 
above 0.20 load.  Client bursts up to 2.00 now and then, typically is 
under 0.50.  There are three machines on this network.  The firewall, 
shell, and mail/web server.  Network traffic is very low, a bit faster 
than visually trackable.

-ESTALE is returned to programs accessing the NFS mount on the client.  
What's annoying is that the -ESTALE continues once per second (imapd 
process) for a few minutes before the imap process gives up.  If I run 
another program (ls -lR) in that directory, -ESTALE "fixes".

If anybody wants more information, please ask.

David

nfsd: fh_verify(12: 00000001 02001600 003df0f3 00000000 00000000 00000000)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 003c7258 00018816 00000000)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 0010fca3 0001881b 00000000)
nfsd: fh_verify(28: 02000001 02001600 003df0f3 002f7528 f11a36b5 002f7497)
nfsd_acceptable failed at c1e80004 
auto-whitelist.lock.jaymale.blue-labs.org.23530
nfsd_acceptable failed at c1e80004 
auto-whitelist.lock.jaymale.blue-labs.org.23530
nfsd: fh_verify(12: 00000001 02001600 003df0f3 00000000 00000000 00000000)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 002f7497 a8b0c207 00000000)
nfsd_acceptable failed at c2d28004 .spamassassin
nfsd: fh_verify(20: 01000001 02001600 003df0f3 002f7497 a8b0c207 00000000)
nfsd: fh_compose(exp 16:02/4059379 
.spamassassin/auto-whitelist.lock.jaymale.blue-labs.org.23530, ino=3110184)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 002ef5cd 0001b794 00000000)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 002ef5cd 0001b794 00000000)
nfsd: fh_compose(exp 16:02/4059379 jon5000/.spamassassin, ino=3110039)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 002f7497 a8b0c207 00000000)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 002f7497 a8b0c207 00000000)
nfsd: fh_compose(exp 16:02/4059379 .spamassassin/auto-whitelist.lock, 
ino=3110182)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 002f7497 a8b0c207 00000000)
nfsd: fh_compose(exp 16:02/4059379 
.spamassassin/auto-whitelist.lock.jaymale.blue-labs.org.23530, ino=3110184)
nfsd: fh_verify(12: 00000001 02001600 003df0f3 00000000 00000000 00000000)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 003c7258 00018816 00000000)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 0010fca3 0001881b 00000000)
nfsd: fh_verify(28: 02000001 02001600 003df0f3 00177ffe a8b0c1e1 00177ffc)
nfsd: fh_verify(28: 02000001 02001600 003df0f3 00178007 a8b0c24e 00177ffc)
nfsd: fh_verify(28: 02000001 02001600 003df0f3 00178007 a8b0c24e 00177ffc)
nfsd: fh_verify(28: 02000001 02001600 003df0f3 00178008 a8b0c24f 00177ffc)
nfsd: fh_verify(28: 02000001 02001600 003df0f3 00178008 a8b0c24f 00177ffc)
nfsd: fh_verify(28: 02000001 02001600 003df0f3 00178007 a8b0c24e 00177ffc)
nfsd: fh_verify(28: 02000001 02001600 003df0f3 00178007 a8b0c24e 00177ffc)
nfsd: fh_verify(28: 02000001 02001600 003df0f3 00178008 a8b0c24f 00177ffc)
nfsd: fh_verify(28: 02000001 02001600 003df0f3 00178008 a8b0c24f 00177ffc)
nfsd: fh_verify(12: 00000001 02001600 003df0f3 00000000 00000000 00000000)
nfsd: fh_verify(12: 00000001 02001600 003df0f3 00000000 00000000 00000000)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 003c7258 00018816 00000000)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 0010fca3 0001881b 00000000)
nfsd: fh_verify(12: 00000001 02001600 003df0f3 00000000 00000000 00000000)
RPC request reserved 0 but used 124
RPC request reserved 0 but used 124
RPC request reserved 0 but used 124
RPC request reserved 0 but used 124
nfsd: fh_verify(28: 02000001 02001600 003df0f3 002f7528 f11a36b5 002f7497)
nfsd_acceptable failed at c1e80004 
auto-whitelist.lock.jaymale.blue-labs.org.23530
nfsd_acceptable failed at c1e80004 
auto-whitelist.lock.jaymale.blue-labs.org.23530
nfsd: fh_verify(20: 01000001 02001600 003df0f3 002f7497 a8b0c207 00000000)
nfsd: fh_verify(20: 01000001 02001600 003df0f3 002f7497 a8b0c207 00000000)
nfsd_acceptable failed at c2d28004 .spamassassin
nfsd: fh_verify(20: 01000001 02001600 003df0f3 002f7497 a8b0c207 00000000)
nfsd: fh_compose(exp 16:02/4059379 
.spamassassin/auto-whitelist.lock.jaymale.blue-labs.org.23530, ino=3110184)


