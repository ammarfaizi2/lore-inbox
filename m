Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbSJQNQL>; Thu, 17 Oct 2002 09:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbSJQNQL>; Thu, 17 Oct 2002 09:16:11 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:30393 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261412AbSJQNQK>; Thu, 17 Oct 2002 09:16:10 -0400
Message-ID: <003301c275e1$0bf76810$2a060e09@beavis>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: "Hirokazu Takahashi" <taka@valinux.co.jp>
Cc: <neilb@cse.unsw.edu.au>, <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <nfs@lists.sourceforge.net>
References: <15788.57476.858253.961941@notabene.cse.unsw.edu.au><20021015.213102.80213000.davem@redhat.com><012d01c27581$677d2180$2a060e09@beavis> <20021017.113126.102592502.taka@valinux.co.jp>
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
Date: Thu, 17 Oct 2002 08:16:43 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36


> Hello,
>
> Thanks for testing my patches.
>
> > I am still seeing some sort of problem on an 8 way (hyperthreaded 8
> > logical/4 physical) on UDP with these patches.  I cannot get more than 2
> > NFSd threads in a run state at one time.  TCP usually has 8 or more.
The
> > test involves 40 100Mbit clients reading a 200 MB file on one server (4
> > acenic adapters) in cache.  I am fighting some other issues at the
moment
> > (acpi wierdness), but so far before the patches, 82 MB/sec for NFSv2,UDP
and
> > 138 MB/sec for NFSv2,TCP.  With the patches, 115 MB/sec for NFSv2,UDP
and
> > 181 MB/sec for NFSv2,TCP.  One CPU is maxed due to acpi int storm, so I
> > think the results will get better.  I'm not sure what other lock or
> > contention point this is hitting on UDP.  If there is anything I can do
to
> > help, please let me know, thanks.
>
> I guess some UDP packets might be lost. It may happen easily as UDP
protocol
> doesn't support flow control.
> Can you check how many errors has happened?
> You can see them in /proc/net/snmp of the server and the clients.

server: Udp: InDatagrams NoPorts InErrors OutDatagrams
        Udp: 1000665 41 0 1000666

clients: Udp: InDatagrams NoPorts InErrors OutDatagrams
         Udp: 200403 0 0 200406
         (all clients the same)

> And how many threads did you start on your machine?
> Buffer size of a UDP socket depends on number of kNFS threads.
> Large number of threads might help you.

128 threads.  client rsize=8196.  Server and client MTU is 1500.

Andrew Theurer

