Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTJ3EqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 23:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTJ3EqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 23:46:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14088 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262196AbTJ3EqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 23:46:19 -0500
Date: Wed, 29 Oct 2003 23:47:05 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: paulus@samba.org, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <davem@redhat.com>
Subject: Re: Bug somewhere in crypto or ipsec stuff
In-Reply-To: <20031030.124124.26191552.yoshfuji@linux-ipv6.org>
Message-ID: <Xine.LNX.4.44.0310292344530.23580-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:

> In article <Xine.LNX.4.44.0310292221320.23405-100000@thoron.boston.redhat.com> (at Wed, 29 Oct 2003 22:22:50 -0500 (EST)), James Morris <jmorris@redhat.com> says:
> 
> > On Thu, 30 Oct 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> > 
> > 
> > > I would just disallow name == NULL,
> > > well, what algorithm do you expect?
> > 
> > Good question.  It seems to me to be a bug in the calling code if it is 
> > trying to look up nothing -- I'd rather not paper that over.
> 
> Do you mean that we need to fix the caller?

Yes.

> 
> Well, people may want to get just any algorithm.
> In such case,
>  - crypto allows name == NULL, and return any algorithm
>    (for example, an algorithm that we see first.)
>  - caller may filter name == NULL case if it is ambiguous in their context.

I think that could be dangerous, including if calling with null is a 
bug, and they get an inappropriate algorithm.  An incorrect algorithm type 
could also be returned (e.g. digest instead of a cipher).

- James
-- 
James Morris
<jmorris@redhat.com>


