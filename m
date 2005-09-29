Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVI2DuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVI2DuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 23:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVI2DuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 23:50:13 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:57353 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750752AbVI2DuM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 23:50:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oWIS2VlHR/zQN7u2xNGcyufMSu+DhQl08T9spZH1ovyNG8tU/ibDFtWbrWLYNpT4VA1C+EynOzBx/3rHwVcYgWGKABK0i/768XxKqKAJDvptkL/Kc3ocd8h9+XPAEGrWU97p7tawBnD4Nv/lJBCE4LVoTrQrSpKw2YxULG5biA8=
Message-ID: <c775eb9b0509282050429bd73@mail.gmail.com>
Date: Wed, 28 Sep 2005 23:50:11 -0400
From: Bharath Ramesh <krosswindz@gmail.com>
Reply-To: Bharath Ramesh <krosswindz@gmail.com>
To: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: Registering for multiple SIGIO within a process
Cc: "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>,
       "Bhattacharjee, Satadal" <Satadal.Bhattacharjee@engenio.com>,
       linux-kernel@vger.kernel.org,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Ram, Hari" <hari.ram@engenio.com>,
       "Mukker, Atul" <Atul.Mukker@engenio.com>
In-Reply-To: <1127956550.25462.15.camel@orca.madrabbit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <0E3FA95632D6D047BA649F95DAB60E57060CD1EB@exa-atlanta>
	 <1127956550.25462.15.camel@orca.madrabbit.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Ray Lee <ray-lk@madrabbit.org> wrote:
> On Wed, 2005-09-28 at 20:44 -0400, Bagalkote, Sreenivas wrote:
> > >(Sheesh, what is it with people thinking signals are something
> > >to be used in any design after the 1970's?)
> > What's your recommendation for asynchronous notification from driver
> > to an application?
>
> Pass back an fd to select() upon. Cuts out that nasty middle step where
> app authors end up registering a signal handler that merely write()s the
> signal number down a pipe into the (nearly ubiquitous) select loop.

If its just linux i would use asynchronous notification using RT
signals. You can use sigwaitinfo to check for the arrival of the
signal by blocking it. siginfo will contain the fd which receivd the
notification. That saves you the call to select as you would have to
select upto maxfd. If you are using just one fd poll would be a better
option IMHO.


Bharath
