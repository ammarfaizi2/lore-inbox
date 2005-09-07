Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVIGHI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVIGHI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 03:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVIGHIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 03:08:55 -0400
Received: from ns.firmix.at ([62.141.48.66]:9184 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751088AbVIGHIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 03:08:55 -0400
Subject: Re: what will connect the fork() with its following code ? a
	simple example below:
From: Bernd Petrovitsch <bernd@firmix.at>
To: Valdis.Kletnieks@vt.edu
Cc: walking.to.remember@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <200509061658.j86GwB5w029481@turing-police.cc.vt.edu>
References: <6b5347dc0509060215128d477e@mail.gmail.com>
	 <200509061658.j86GwB5w029481@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 07 Sep 2005 09:08:48 +0200
Message-Id: <1126076928.24425.12.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 12:58 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 06 Sep 2005 17:15:51 +0800, "Sat." said:
> 
> Not a kernel problem, please consult an intro-to-C list next time....
> 
> > if(!(pid=fork())){
> >      ......
> >      printk("in child process");
> >      ......
> > }else{
> >      .....
> >      printk("in father process"); 
> >      .....
> > }
> > 
> 
> > values., and do nothing . so the bridge  between the new process and
> > its following code, printk("in child process"), seems disappear 
> 
> I'm assuming you actually meant printf() (which is the userspace stdio call)
> rather than printk() (which is the inside-the-kernel variant).

I actually assumed the same.

> 'man setbuf' - most likely the output of the child process is buffered and
> never actually output before it exits.  You want to set stdout to be

It is buffered since the above printf() lacks a terminating "\n". So
either put a "\n" at the end or call "fflush(stdout);"

> line-buffered or unbuffered, or write to stderr (unbuffered by default) rather
> than stdout. 

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

