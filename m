Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVF2ARP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVF2ARP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVF2AOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:14:38 -0400
Received: from smtpout.mac.com ([17.250.248.84]:46790 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262311AbVF2ANG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:13:06 -0400
In-Reply-To: <200506282154.j5SLsETL010486@laptop11.inf.utfsm.cl>
References: <200506282154.j5SLsETL010486@laptop11.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A595C063-7F6E-49AD-A797-1133C731E7E3@mac.com>
Cc: Andrew Thompson <andrewkt@aktzero.com>, Petr Baudis <pasky@ucw.cz>,
       Christopher Li <hg@chrisli.org>, mercurial@selenic.com,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 20:12:54 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2005, at 17:54:14, Horst von Brand wrote:
> Andrew Thompson <andrewkt@aktzero.com> wrote:
>> I believe this works because the files stored in a binary format that
>> appends new changesets onto the end. Thus, truncating the new stuff
>> from the end effectively removes the commit.
>
> And is exactly the wrong way around. Even RCS stored the _last_  
> version and
> differences to earlier ones (you'll normally want the last one (or
> something near), and so occasionally having to reconstruct earlier  
> ones by
> going back isn't a big deal; having to build up the current version by
> starting from /dev/null and applying each and every patch that ever  
> touched
> the file each time is expensive given enough history, besides that any
> error in the file is guaranteed to destroy the current version, not
> (hopefully) just making old versions unavailable).  It also means that
> losing old history (what you'll want to do once in a while, e.g.  
> forget
> everything before 2.8) is simple: Chop off at the right point.

If we have versions A through A+N, Mercurial will create a new revlog  
file and
store a new full version when the total size of the changes between A  
and A+N
is greater than a certain amount, effectively ensuring that  
retrieving the
latest version of a file is O(size-of-file) instead of O(size-of- 
file*revisions).
This is the same speed as RCS for the tip, and significantly faster  
than RCS
for non-tip, which is crucial for merges.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.
   -- C.A.R. Hoare

