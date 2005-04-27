Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVD0Fqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVD0Fqu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 01:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVD0Fqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 01:46:50 -0400
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:23421 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261576AbVD0Fqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 01:46:48 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: johnpol@2ka.mipt.ru
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Date: Wed, 27 Apr 2005 00:46:40 -0500
User-Agent: KMail/1.8
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
References: <20050411125932.GA19538@uganda.factory.vocord.ru> <200504270016.34002.dtor_core@ameritech.net> <1114579926.14282.16.camel@uganda>
In-Reply-To: <1114579926.14282.16.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504270046.41042.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 April 2005 00:32, Evgeniy Polyakov wrote:
> On Wed, 2005-04-27 at 00:16 -0500, Dmitry Torokhov wrote:
> > On Tuesday 26 April 2005 23:06, Evgeniy Polyakov wrote:
> > > Let's clarify that we are talking about userspace->kernelspace
> > > direction.
> > > Only for that messages callback path is invoked.
> > 
> > What about kernelspace->userspace or kernelspace->kernelspace?
> > From what I see nothing stops kernel code from calling cn_netlink_send,
> > in fact your cbus does exactly that. So I am confused why you singled
> > out userspace->kernelspace direction.
> 
> You miunderstand the code -
> cn_netlink_send() never ends up in callback invocation, 
> it can only deliver messages in kernelspace->userspace direction.
> kernelspace->userspace direction ends up adding buffer into
> socket queue, from which userspace may read data using recv() system
> call.

Yes, you are right, sorry. I missed the fact that message is not injected
into callback queue. Hmm, might be useful if it was, for implementing
various kinds of in-kernel notifications.

Other thing to consider - even if there is explicit schedule on userspace->
kernelspace path there is no quarantee that connector thread will be
scheduled before userspace - userspace could be higher-priority bursty task.
Although this scenario it not likely I guess.

-- 
Dmitry
