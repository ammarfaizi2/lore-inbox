Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318751AbSHGSJ0>; Wed, 7 Aug 2002 14:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318752AbSHGSJZ>; Wed, 7 Aug 2002 14:09:25 -0400
Received: from pat.uio.no ([129.240.130.16]:46295 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318751AbSHGSJZ>;
	Wed, 7 Aug 2002 14:09:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15697.25389.370068.524520@charged.uio.no>
Date: Wed, 7 Aug 2002 20:13:01 +0200
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
In-Reply-To: <EE83E551E08D1D43AD52D50B9F511092E114E2@ntserver2>
References: <EE83E551E08D1D43AD52D50B9F511092E114E2@ntserver2>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Gregory Giguashvili <Gregoryg@ParadigmGeo.com> writes:

     > Well, this is the way it's been working on all UN*X platforms I
     > know. In fact, we came across this problem with NFS clients
     > being unable to synchronize on Linux.

Sorry. AFAICS O_SYNC only affects writes (just like we do).

As for reads: all commercial NFS clients I know of will check data
cache consistency on open(). They will assume that they can cache
attributes and data as per the documentation in 'man 5 nfs' (although
you can turn this off by using the 'noac' mount option).

Furthermore, even with 'noac' they *all* have problems with races in
the sort of scenario you describe because there is no atomic
GETATTR+READ operation.

Bottom line: If you want the sort of data cache consistency you are
describing, you *have* to use file locking.

Cheers,
 Trond
