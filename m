Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTDOO1p (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbTDOO1o 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:27:44 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.26]:44007 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261570AbTDOO1m (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 10:27:42 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: BUGed to death
Date: Tue, 15 Apr 2003 16:39:25 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay> <200304151401.00704.baldrick@wanadoo.fr> <69850000.1050417343@[10.10.2.4]>
In-Reply-To: <69850000.1050417343@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304151639.25978.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 April 2003 16:35, Martin J. Bligh wrote:
> >> Seems all these bug checks are fairly expensive. I can get 1%
> >> back on system time for kernel compiles by changing BUG to
> >> "do {} while (0)" to make them all compile away. Profiles aren't
> >> very revealing though ... seems to be within experimental error ;-(
> >
> > What happens if you just turn BUG_ON into "do {} while (0)"?
>
> I believe I already did that by turning BUG() into a null expression.
>
> #define BUG_ON(condition)
> 	do { if (unlikely((condition)!=0)) BUG(); } while(0)
>
> The compiler should be smart enough to optimise that away, methinks.

No, I meant what happens if BUG() is non-trivial and BUG_ON is a no-op.
I thought it might give an indication of whether time was being lost
evaluating the condition (occurs with BUG and BUG_ON), or mispredicting
the branch (only occurs with BUG).

Duncan.
