Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVATJbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVATJbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 04:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVATJ3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 04:29:10 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:58011 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262089AbVATJ2t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 04:28:49 -0500
Subject: Re: [patch] Job - inescapable job containers
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: guillaume.thouvenin@bull.net,
       =?UTF-8?Q?=E2=80=ABLimin?= Gu <limin@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, lkml <linux-kernel@vger.kernel.org>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Date: Thu, 20 Jan 2005 10:28:39 +0100
Message-Id: <1106213319.17195.96.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/01/2005 10:36:57,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/01/2005 10:37:01,
	Serialize complete at 20/01/2005 10:37:01
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:

> Limin Gu wrote:
>>
>>  Could you consider this for inclusion in the mm tree?
>>  The Job patch has been posted a few times, and I've addressed
>>  the issues others raised.
>
> A similar thing happened last year with the "enhanced system 
> accounting" patch.

  I have a different approach than PAGG. My goal is to minimize kernel
modifications to perform enhanced accounting (and only that). I'm using
a kernel module and a user space daemon to provide enhanced system
accounting. The only thing I need to manage "jobs" is a hook in the
do_fork() routine, everything else is done outside the kernel. Thus, I'm
not offering a real framework as PAGG does because PAGG is used not only
for accounting (I think... Limin?).

  I submitted small patches that relay fork information (it was the
relay_fork module + a hook in the do_fork() routine). It seems that some
people, like Erich Focht, were interested by this kind of feature for
others applications but unfortunately I didn't receive (yet) any
feedbacks from him.

 IMHO, I think that most of job management can be done outside the Linux
kernel tree so I've worked on a user space solution. The solution I'm
working on is specific to accounting and can not be considered as a
framework. I think that SGI's jobs is a good framework and if it is
integrated in the development tree then it will be a good solution to
enhance Linux accounting but I don't know if such framework is needed in
the kernel if the goal is only accounting. If the goal is more around
global resources management, then SGI's framework should be compared
with CKRM. 

 Thus to be clear, ELSA is a specific solution for enhanced linux system
accounting with a very small kernel modification but it's only for
accounting. I used a relay fork module which can be used by some others
applications (Erich?). PAGG is a generic framework that allows ,with
CSA, to do accounting. PAGG is more to compare with CKRM and as a
framework, it implies deeper kernel integrations and modifications than
my solution. So, if the relay fork module is interesting and is used by
others applications, ELSA is a good solution, otherwise, the discussion
is which framework to integrate, PAGG, CKRM,...  

Guillaume

