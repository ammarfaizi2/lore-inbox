Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTJOQDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTJOQDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:03:03 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:41957 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S261882AbTJOQDA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:03:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Richard J Moore <rasman@uk.ibm.com>
Organization: Linux Technoilogy Centre - RAS team
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
Date: Wed, 15 Oct 2003 16:56:06 +0000
User-Agent: KMail/1.4.1
Cc: karim@opersys.com, jmorris@redhat.com, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org, bob@watson.ibm.com
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com> <200310141132.28339.rasman@uk.ibm.com> <20031014094424.6cff5697.davem@redhat.com>
In-Reply-To: <20031014094424.6cff5697.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200310151656.06905.rasman@uk.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have read the RCF and I have to say that  I am left with the impression that 
relayfs and netlink are more or less orthogonal in what they try to achieve. 
If I'm wrong in this I'd like to know as I have no wish to push an 
alternative to any existing function of equivalent or  superior capability.

In messaging terms relayfs is more about he collation of parts of a message 
rather than the sending of multiple messages to a session partner. There are 
three aspects in which relayfs radically differs from netlink:

1) it does not require a partnership -- a client and serve, or session pair -- 
it is simply a buffering mechanism that allows data  be deposited. There is 
no expectation that the data will be consumed or that there is a listening 
partner. The reason fore this design point comes from the origin of relayfs 
as a buffering mechanism that satisfies the needs of a low-level system 
trace. Data from a trace might never be consumed if the system, sub-system or 
component never fails.

2) data can be deposited from any context - interrupt time, task time, sysinit 
in particular.

3) the depositing of data with relayfs has to depend one a very simple 
interface and infrastructure in order to function under a severely damaged 
system. My impression is that netlink depends a significant infrastructure.

Are these three points catered for by netlink?

-- 
Richard J Moore
IBM Linux Technology Centre

On Tue 14 October 2003 4:44 pm, David S. Miller wrote:
> On Tue, 14 Oct 2003 11:32:28 +0000
>
> Richard J Moore <rasman@uk.ibm.com> wrote:
> > Interesting, that assumes sequential processing, if not semi-synchronous
> > processing of events on the receiver side, which is far from guaranteed
> > when considering low-level tracing especially for flight-recorder
> > applications.
>
> With netlink you may receive the data asynchronously however you
> wish after you've requested a dump.
>
> I would like to ask that you go study how netlink works and is used
> by things like routing daemons before we discuss this further as
> it looks to me like half the conversation is going to be showing
> you how netlink works.  And hey there's even an RFC on netlink :)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
