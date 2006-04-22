Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWDVUmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWDVUmx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWDVUmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:42:53 -0400
Received: from [212.33.164.120] ([212.33.164.120]:51210 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751167AbWDVUmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:42:37 -0400
From: Al Boldi <a1426z@gawab.com>
To: sekharan@us.ibm.com
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
Date: Sat, 22 Apr 2006 23:40:41 +0300
User-Agent: KMail/1.5
Cc: Matt Helsley <matthltc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200604212207.44266.a1426z@gawab.com> <200604220708.40018.a1426z@gawab.com> <1145684800.21231.30.camel@linuxchandra>
In-Reply-To: <1145684800.21231.30.camel@linuxchandra>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604222340.41332.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Sat, 2006-04-22 at 07:08 +0300, Al Boldi wrote:
> > i.e: it should be possible to run the RCs w/o CKRM.
> >
> > The current design pins the RCs on CKRM, when in fact this is not
> > necessary. One way to decouple them, could be to pin them against pid,
> > thus allowing an RC to leverage the pid hierarchy w/o the need for CKRM.
> >  And only when finer RM control is necessary, should CKRM come into
> > play, by dynamically adjusting the RC to achieve the desired effect.
>
> This model works well in universities, where you associate some resource
> when a student logs in, or a virtualised environment (like a UML or
> vserver), where you attach resource to the root process.
>
> It doesn't work with web servers, database servers etc.,, where the main
> application will be forking tasks for different set of end users. In
> that case you have to group tasks that are not related to one another
> and attach resources to them.
>
> Having a unified interface gives the system administrator ability to
> group the tasks as they see them in real life (a department or important
> transactions or just critical apps in a desktop).

So, why drag this unified interface around when it is only needed in certain 
models.  The underlying interface via pid comes for free and should be 
leveraged as such to yield a low overhead implementation.  Then maybe, when 
a more complex model is involved should CKRM come into play.

> It also has the added advantage that the resource controller writer do
> not have to spend their time in coming up with an interface for their
> controller. On the other hand if they do, the user finally ends up with
> multiple interface (/proc, sysfs, configfs, /dev etc.,) to do their
> resource management.

So, maybe what is needed is an abstract parent RC that implements this 
interface and lets the child RCs implement the specifics, and allows CKRM to 
connect to the parent RC to allow finer RM control when a specific model 
requires it.

Thanks!

--
Al

