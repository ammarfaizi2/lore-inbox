Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVIFHMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVIFHMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 03:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVIFHMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 03:12:18 -0400
Received: from ns2.suse.de ([195.135.220.15]:40936 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932419AbVIFHMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 03:12:18 -0400
From: Andi Kleen <ak@suse.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Tue, 6 Sep 2005 09:13:59 +0200
User-Agent: KMail/1.8
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <p73aciqrev0.fsf@verdi.suse.de> <200509060939.28055.vda@ilport.com.ua>
In-Reply-To: <200509060939.28055.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509060913.59822.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 08:39, Denis Vlasenko wrote:

> I think one of the reasons is:
>
> "No matter how big stack is, there are always careless
> code which can overflow it. 4k, 8k, 64k (hypotetically),
> we still must keep stack size in mind when coding.
>
> So, since we already are writing stack size aware code,
> why not pick minimum realistically working stack size? Looks
> like we can make 4k stack work, and it's naturally smallest
> sensible (and in fact easiest to allocate/manage) stack for i386.
> So be it, let's use 4k."

Better engineering is to take the minimum size and then
add some safety margin.  Running with the minimum only
is ok when you have the infrastructure to prove maximum
stack usage, but Linux is far too complex for that. In general
running with no safety margin is not a good idea.

BTW your minimum doesn't seem to be everybody's
minimum - everytime you see someone advocating
the smallest stacks they go "it's fine for us, but don't
use A, B, C, D" (and I expect these lists to get longer
with more experience). 

The trend in Linux clearly seems to be towards more
complex code. While that is not always a good thing but
it seems to be unstoppable (everybody wants their
favourite features and the merging machinery is well oiled
and in full action). And doing all that will need more 
stack space over time so shrinking is clearly the wrong
strategic direction. 

At some point we undoubtedly will need to increase it further, 
the logical point would be when Linux switches to larger softpage 
sizes.

-Andi
