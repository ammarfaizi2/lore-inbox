Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265260AbSJaSYr>; Thu, 31 Oct 2002 13:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265272AbSJaSYq>; Thu, 31 Oct 2002 13:24:46 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:45539 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265260AbSJaSXr>;
	Thu, 31 Oct 2002 13:23:47 -0500
Date: Thu, 31 Oct 2002 10:30:09 -0800
To: Juan Gomez <juang@us.ibm.com>
Cc: Josh Myer <jbm@joshisanerd.com>, jbm@blessed.joshisanerd.com,
       linux-kernel@vger.kernel.org
Subject: Re: How to get a local IPv4 address from within a kernel module?
Message-ID: <20021031183009.GB2972@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <OFA4AB1D53.AE6E9560-ON87256C63.006382A4@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA4AB1D53.AE6E9560-ON87256C63.006382A4@us.ibm.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 10:09:54AM -0800, Juan Gomez wrote:
> 
> Josh
> 
> That is the purpose of my orignal message. In fact I have implemented
> somthing along the lines of what you suggest below and I just want to test
> the waters on whether this will be accepted. My current implementation is a
> little more specific as it only gets the interfaces with IPv4 enabled on
> them and skip lo but the idea is to get a consensus on what would be
> genrally useful and then introduce that.
> 
> Regards, Juan

	I personally think it's a very bad idea, because it will lead
to confusion. You will define a concept of "the node IP address",
which doesn't exist and is a very dangerous assumption.
	Just take VPN, which is becoming very widespread. You have two
IP addresses, one on the interface, one on the tunnel. Which one do
you get ? Those two IP address will have widely different behaviour
and you can't exchange them.
	My fear is that people will start coding around this API and
flawed concept, and most of their programs will be immediately flawed,
because incapable to adapt to the reality of networking (it will work
in the simple case, but give bizarre behavior in non simple cases).
	Don't get me wrong, there is a small class of applications
where the IP address doesn't matter (and for those, 127.0.0.1 should
be fine). But, from my experience, the vast majority of people wanting
"the node IP address" have broken designs, i.e. it's not that they
want any one of them, it's that they assume that only one exist.

	Now, there is only one thing that could qualify as "the node
IP address", this is the IP address associated with the hostname :
		gethostbyname(hostname());
	IMHO, if you define the interface you are proposing, it should
always return the result above, because this is a well defined
semantic and it is more useful.

	But, I'm only one of the little guy here, so what I say
doesn't matter much. Ask Alan or DaveM.
	Regards,

	Jean
