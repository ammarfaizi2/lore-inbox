Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUIFA0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUIFA0I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 20:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUIFA0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 20:26:07 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:17868 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267365AbUIFA0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 20:26:02 -0400
Date: Mon, 6 Sep 2004 02:26:01 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: RCU callback and scheduling while atomic!
Message-ID: <20040906002601.GA19608@MAIL.13thfloor.at>
Mail-Followup-To: Dipankar Sarma <dipankar@in.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20040831161710.GA21782@MAIL.13thfloor.at> <20040831162140.GD3957@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831162140.GD3957@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 09:51:40PM +0530, Dipankar Sarma wrote:
> On Tue, Aug 31, 2004 at 06:17:10PM +0200, Herbert Poetzl wrote:
> > 
> > it seems that the RCU callback is not allowed 
> > to (re-)schedule, as it is done occasionally by 
> > put_namespace() for example, as I keep getting 
> > "bad: scheduling while atomic!", when I do so ...
> > 
> > now the question: what is the 'correct' way to
> > drop a reference to a namespace when freeing up 
> > a structure from an RCU callback?
> 
> You are right about not allowing schedule from callbacks. The callbacks
> are called from softirq context.
> 
> Without your current code, it is difficult to say how to do this but here are
> some guesses - 
> 
> 1. You could mark the freed up structure deleted on update, do
>    put_namspace() and do only the freeing in the rcu callback.
>    dentries do this.
> 
> 2. If not performance critical, you could use a workqueue to
>    do the actual freeing including put_namespace(). Just wake up
>    from the rcu callback.

ah, okay, I see, although it isn't time critical,
it seems to me that the first is the best choice
in my case, thanks for the hints ...

> These may or may not be applicable to your case. More details will
> help.

thanks,
Herbert

> Thanks
> Dipankar
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
