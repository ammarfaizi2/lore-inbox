Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbQLLWkJ>; Tue, 12 Dec 2000 17:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129449AbQLLWjt>; Tue, 12 Dec 2000 17:39:49 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:53008 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129415AbQLLWjo>; Tue, 12 Dec 2000 17:39:44 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 12 Dec 2000 15:09:02 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012121236360.2553-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012121236360.2553-100000@penguin.transmeta.com>
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
MIME-Version: 1.0
Message-Id: <00121215090200.00928@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 December 2000 13:38, Linus Torvalds wrote:
> On Tue, 12 Dec 2000, Steven Cole wrote:
> > Task: make -j3 bzImage for 2.4.0-test12-pre7 kernel tree.
>
> Actually, do it with
>
> 	make -j3 'MAKE=make -j3' bzImage
>
> A single "-j3" won't do much. It will only build three directories at a
> time, and you'll never see much load. But doing it recursively means that
> you'll build three at a time all the way out to the leaf directories, and
> you should see loads up to 20+, and much more memory pressure too.
>
> 		Linus

Ok, repeated the tests with make -j3 'MAKE=make -j3' bzImage

I ran xosview to monitor the load.

The load values for 2.2.18 seemed to stay higher longer than
for 2.4.0-test12. I recorded the peak load observed.

For comparison, with make -j3 bzImage, the peak load was much
lower, about 2.7.

Task: make -j3 'MAKE=make -j3' bzImage for 2.4.0-test12-pre7 kernel tree.
Numbers are seconds to build.
New results:

 1       2       3      ave.
143     143     143     143     Running 2.2.18 SMP
19.1    17.5    19.2    18.6    Max load observed with xosview

142     141     141     141.3   Running 2.4.0-test12-pre7 SMP
16.2    16.8    15.2    16.1    Max load observed with xosview

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
