Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUEWTrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUEWTrr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUEWTrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:47:46 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:18641 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263540AbUEWTrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:47:43 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 VS 2.6 fork VS thread creation time test
Date: Sun, 23 May 2004 21:47:31 +0200
User-Agent: KMail/1.6.2
Cc: David Lang <david.lang@digitalinsight.com>,
       Gergely Czuczy <phoemix@harmless.hu>, itk-sysadm@ppke.hu
References: <Pine.LNX.4.60.0405230914330.15840@localhost> <200405231139.44096.linux-kernel@borntraeger.net> <Pine.LNX.4.58.0405230247450.8199@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.58.0405230247450.8199@dlang.diginsite.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405232147.36372.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Sun, 23 May 2004, Christian Borntraeger wrote:
> > Gergely Czuczy wrote:
> > > failed. As I told it above all the processes are teminated right
> > > after creation, but there were a lot of defunct processes in the
> > > system, and they were only gone when the parent termineted.
> > Have you heard of wait, waitpid and pthread_join?
> there really is some sort of problem with 2.6.6 in this area. I have an

Well in the example given by Gergely there was no wait call at all. 
Therefore I believe your problem is not related to his one.

What do you mean by with 2.6.6. Does this testcase behaves differently with 
other kernel versions? Which version is the first with this problem?

> the prarent deals with sigchild by
> handler{
> while ( wait(...) >0);
> signal(SIGCHLD, handler);
> }

You run signal within the signal handler. This is not necessary, although 
this should cause no problems. Nevertheless, can you try your test without 
signal in the signal handler?

cheers

Christian
