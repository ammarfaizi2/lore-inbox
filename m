Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWGRMVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWGRMVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 08:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWGRMVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 08:21:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:9525 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751328AbWGRMVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 08:21:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=BjLLJP7R7UMo8/9Wd9EbcAVkyAE3uvlUQHmVNE/NqeCErwB17sHyW/bmSv0ZWUhkatAitars29a5DGJQ91gpEngSmsK7DOmk/CNSUK3SNgOpZQvqE/n0J4QJuXHNgfpeupgpLvJW7DxJLHs4hIQmRBW/r5X5SrZZkof7a2JKt9w=
Date: Tue, 18 Jul 2006 14:20:41 +0200
From: Janos Farkas <chexum+dev@gmail.com>
To: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: nfs problems with 2.6.18-rc1
Message-ID: <priv$8d118c145627$464a3143cd@200607.shadow.banki.hu>
Mail-Followup-To: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
	nfs@lists.sourceforge.net
References: <priv$8d118c145575$b19af6759a@200607.shadow.banki.hu> <17594.51834.20365.820166@cse.unsw.edu.au> <priv$efbe06145615$0a94d550eb@200607.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <priv$efbe06145615$0a94d550eb@200607.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2006-07-17 at 09:23:38, Neil Brown wrote:
> > The standard answer for tracing nfs problems if 'tcpdump'.
> > e.g. 
> >   tcpdump -s 0 -w /tmp/trace host $CLIENT and host $SERVER and port 2049
> > 
> > that should show whether the error is coming from the server, or if
> > the client is generating it all by itself.

Closing in, I have a dump between these two machines running 18-rc2 that
has the error on the wire, but I'm not sure how much more would be
relevant:

(This is probably a successful stat() of the "mailbox" file (having the
size of 39074 bytes))

13:34:56.382832 getattr fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A20000002D
13:34:56.383109 reply ok 112 getattr REG 100600 ids 2001/500 sz 39074
13:34:56.383328 getattr fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A20000002D
13:34:56.383556 reply ok 112 getattr REG 100600 ids 2001/500 sz 39074
13:34:56.383723 access fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A20000002D 002d
13:34:56.383951 reply ok 120 access attr: REG 100600 ids 2001/500 sz 39074 nlink 1 rdev 0/0 fsid fd00 fileid 45176 a/m/ctime 1153222475.000000 1153173671.000000 1153222475.000000 c 000d
13:34:56.384241 setattr fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A200000000
13:34:56.384585 reply ok 144 setattr PRE: sz 39074 mtime 1153173671.000000 ctime 1153222475.000000 POST: REG 100600 ids 2001/500 sz 39074 nlink 1 rdev 0/0 fsid fd00 fileid 45176 a/m/ctime 1153222475.000000 1153173671.000000 1153222496.000000
13:34:56.386376 getattr fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A200000000
13:34:56.387209 reply ok 112 getattr REG 100600 ids 2001/500 sz 39074
13:34:56.387489 getattr fh Unknown/0100000100FD000002000000755104000AA487A2755104000AA487A200000000
13:34:56.388137 reply ok 112 getattr DIR 40755 ids 2001/500 sz 4096
13:34:56.388317 getattr fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A200000000
13:34:56.388560 reply ok 112 getattr REG 100600 ids 2001/500 sz 39074

(... after a few lock files, reading through the whole file)

13:34:56.392869 lookup fh Unknown/0100000100FD000002000000755104000AA487A2000000076D61696C626F7800 "mailbox"
13:34:56.393129 reply ok 236 lookup fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A200000001 REG 100600 ids 2001/500 sz 39074 nlink 1 rdev 0/0 fsid fd00 fileid 45176 a/m/ctime 1153222475.000000 1153173671.000000 1153222496.000000 post dattr: DIR 40755 ids 2001/500 sz 4096 nlink 2 rdev 0/0 fsid fd00 fileid 45175 a/m/ctime 1153222413.000000 1153222496.000000 1153222496.000000
13:34:56.393325 access fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A20000002D 002d
13:34:56.393556 reply ok 120 access attr: REG 100600 ids 2001/500 sz 39074 nlink 1 rdev 0/0 fsid fd00 fileid 45176 a/m/ctime 1153222475.000000 1153173671.000000 1153222496.000000 c 000d
13:34:56.393953 read fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A200000000 8192 bytes @ 0
13:34:56.393967 read fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A200000000 8192 bytes @ 8192
13:34:56.394631 reply ok 1472 read REG 100600 ids 2001/500 sz 39074 nlink 1 rdev 0/0 fsid fd00 fileid 45176 a/m/ctime 1153222496.000000 1153173671.000000 1153222496.000000 8192 bytes
13:34:56.395717 reply ok 1472 read REG 100600 ids 2001/500 sz 39074 nlink 1 rdev 0/0 fsid fd00 fileid 45176 a/m/ctime 1153222496.000000 1153173671.000000 1153222496.000000 8192 bytes
13:34:56.398241 read fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A200000000 8192 bytes @ 16384
13:34:56.398257 read fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A200000000 8192 bytes @ 24576
13:34:56.398266 read fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A2000000006306 bytes @ 32768
13:34:56.399338 reply ok 1472 read REG 100600 ids 2001/500 sz 39074 nlink 1 rdev 0/0 fsid fd00 fileid 45176 a/m/ctime 1153222496.000000 1153173671.000000 1153222496.000000 8192 bytes
13:34:56.400120 reply ok 1472 read REG 100600 ids 2001/500 sz 39074 nlink 1 rdev 0/0 fsid fd00 fileid 45176 a/m/ctime 1153222496.000000 1153173671.000000 1153222496.000000 8192 bytes
13:34:56.401822 reply ok 1472 read REG 100600 ids 2001/500 sz 39074 nlink 1 rdev 0/0 fsid fd00 fileid 45176 a/m/ctime 1153222496.000000 1153173671.000000 1153222496.000000 6306 bytes EOF
13:34:56.403059 getattr fh Unknown/0100000100FD000002000000755104000AA487A2742049207468696E6B0A6162
13:34:56.403359 reply ok 112 getattr DIR 40755 ids 2001/500 sz 4096
13:34:56.403538 getattr fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A26B0A6162
13:34:56.403743 reply ok 112 getattr REG 100600 ids 2001/500 sz 39074
13:34:56.403931 lookup fh Unknown/0100000100FD000002000000755104000AA487A20000000C6D61696C626F782E "mailbox.lock"
13:34:56.404298 reply ok 236 lookup fh Unknown/0100000200FD000002000000775104000EA487A2755104000AA487A200000001 REG 100000 ids 2001/500 sz 0 n link 1 rdev 0/0 fsid fd00 fileid 45177 a/m/ctime 1153222496.000000 1153222496.000000 1153222496.000000 post dattr: DIR 40755 ids 2001/500 sz 4096 nlink 2 rdev 0/0 fsid fd00 fileid 45175 a/m/ctime 1153222413.000000 1153222496.000000 1153222496.000000
13:34:56.404484 remove fh Unknown/0100000100FD000002000000755104000AA487A20000000C6D61696C626F782E "mailbox.lock"
13:34:56.404844 reply ok 120 remove PRE: POST: DIR 40755 ids 2001/500 sz 4096 nlink 2 rdev 0/0 fsid fd00 fileid 45175 a/m/ctime 1153222413.000000 1153222496.000000 1153222496.000000
13:34:56.405728 lookup fh Unknown/0100000100FD000002000000755104000AA487A2000000076D61696C626F7800 "mailbox"
13:34:56.406419 reply ok 236 lookup fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A200000001 REG 100600 ids 2001/500 sz 39074 nlink 1 rdev 0/0 fsid fd00 fileid 45176 a/m/ctime 1153222496.000000 1153173671.000000 1153222496.000000 post dattr: DIR 40755 ids 2001/500 sz 4096 nlink 2 rdev 0/0 fsid fd00 fileid 45175 a/m/ctime 1153222413.000000 1153222496.000000 1153222496.000000

(More operations, and pause.  After a while, pressing a key makes mutt to
revalidate the mailbox file, nothing more skipped before the error)

13:35:23.139297 getattr fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A200030001
13:35:23.139958 reply ok 112 getattr REG 100600 ids 2001/500 sz 39074
13:36:29.902394 access fh Unknown/0100000100FD000002000000755104000AA487A20000001F0AA487A200030001 001f
13:36:29.903109 reply ok 120 access attr: DIR 40755 ids 2001/500 sz 4096 nlink 2 rdev 0/0 fsid fd00 fileid 45175 a/m/ctime 1153222413.000000 1153222496.000000 1153222496.000000 c 001f
13:36:29.903314 getattr fh Unknown/0100000200FD000002000000765104000BA487A2755104000AA487A200030001
13:36:29.903603 reply ok 112 getattr REG 100600 ids 2001/500 sz 39074
13:37:41.196223 getattr fh Unknown/0100000000FD000002000000000000000004517644BCC7600000000044BC08A7
13:37:41.196678 reply ok 112 getattr DIR 40775 ids 0/0 sz 4096
13:37:41.196903 getattr fh Unknown/0100000000FD000402000000000000000000000244BCA4790000000044A22F45
13:37:41.197146 reply ok 112 getattr DIR 40755 ids 0/0 sz 1024
13:37:41.197304 getattr fh Unknown/0100000000FD000102000000000000000000000244BCB6A80000000042CACA97
13:37:41.197494 reply ok 112 getattr DIR 40755 ids 0/0 sz 4096
13:37:51.254708 access fh Unknown/0100000100FD000002000000755104000AA487A20000001F0AA487A200030001 001f
13:37:51.255375 reply ok 32 access ERROR: Permission denied attr:
13:37:51.255924 access fh Unknown/0100000000FD0001020000000000001F0AA487A20000001F0AA487A200030001 001f
13:37:51.256216 reply ok 120 access attr: DIR 40755 ids 0/0 sz 4096 nlink 4 rdev 0/0 fsid fd01 fileid 2 a/m/ctime 1153217912.000000 1139267032.000000 1139267032.000000 c 0003
13:37:51.256434 getattr fh Unknown/0100000100FD00010200000001DC0500E909CCBB0000001F0AA487A200030001
13:37:51.256655 reply ok 112 getattr DIR 40755 ids 0/0 sz 4096
13:37:51.256821 access fh Unknown/0100000100FD00010200000001DC0500E909CCBB0000001F0AA487A200030001 001f
13:37:51.257048 reply ok 120 access attr: DIR 40755 ids 0/0 sz 4096 nlink 3 rdev 0/0 fsid fd01 fileid 5dc01 a/m/ctime 1153217912.000000 1120496574.000000 1120496574.000000 c 0003

Apparently, the access that results in EACCESS is having the same
filehandle as one above that suceeded, but it is an fh of the current
directory that contained the mailbox.lock file (judging by the fileid).
But it's still confusing to me.  I also have this in raw tcpdump
format.  Would the client and/or server debug log be more helpful?

Janos
