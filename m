Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314635AbSDTPqD>; Sat, 20 Apr 2002 11:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314640AbSDTPqC>; Sat, 20 Apr 2002 11:46:02 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:7301 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S314635AbSDTPqB>; Sat, 20 Apr 2002 11:46:01 -0400
Message-ID: <002201c1e882$ffe03200$2e060e09@beavis>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: "Hirokazu Takahashi" <taka@valinux.co.jp>
Cc: <trond.myklebust@fys.uio.no>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020419.122142.85422229.taka@valinux.co.jp><E16yUXe-0004qj-00@charged.uio.no><200204192128.QAA24592@popmail.austin.ibm.com> <20020420.191419.35011774.taka@valinux.co.jp>
Subject: Re: [PATCH] zerocopy NFS updated
Date: Sat, 20 Apr 2002 10:49:38 -0500
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

> Hi,
>
> > With all this talk on serialization on UDP, and have a question.  first,
let
> > me explain the situation.  I have an NFS test which calls 48 clients to
read
> > the same 200 MB file on the same server.  I record the time for all the
> > clients to finish and then calculate the total throughput. The server is
a
> > 4-way IA32.  (I used this test to measure the zerocopy/tcp/nfs patch)
Now,
> > right before the test, the 200 MB file is created on the server, so
there is
> > no disk IO at all during the test.  It's just an very simple cached
read.
> > Now, when the clients use udp, I can only get a run queue length of 1,
and I
> > have confirmed there is only one nfsd thread in svc_process() at one
time,
> > and I am 65% idle.  With tcp, I can get all nfsd threads running, and
max all
> > CPUs.  Am I experiencing a bottleneck/serialization due to a single UDP
> > socket?
>
> What version do you use?
> 2.5.8 kernel has a problem in readahead of NFSD.
> It doesn't work at all.

I have this problem on every version I have used, including 2.4.18, 2.4.18
w/ Niel's patches, 2.5.6, and 2.5.7.  One other thing I forgot to mention:
If I set the number of resident nfsd threads to "2", I can get 2 nfsd
threads running at once (nfsd_busy = 2), along with ~30% improvement in
throughput.  If I use any other qty of resident nfsd threads, I always get
exactly 1 nfsd threads running (nfsd_busy = 1) during this test.  With tcp
there is no serialization at all.  I can get nearly 48 nfsd threads busy
with the 48 clients all reading at once.

-Andrew

