Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVGBOVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVGBOVs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 10:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVGBOVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 10:21:48 -0400
Received: from opersys.com ([64.40.108.71]:16138 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261170AbVGBOVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 10:21:46 -0400
Message-ID: <42C6A58B.6020000@opersys.com>
Date: Sat, 02 Jul 2005 10:32:43 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Michael Raymond <mraymond@sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [ltt-dev] [PATCH/RFC] Significantly reworked LTT core
References: <42C60001.5050609@opersys.com> <20050702081437.A57232@xanatos.americas.sgi.com>
In-Reply-To: <20050702081437.A57232@xanatos.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the feedback Michael.

Michael Raymond wrote:
>     Karim, three comments:
> - CPU ID needs be bigger than 8-bits, else you can only support up to 256p

I don't mind. uint16_t?

> - Are 8-bit event IDs big enough?  A comment explainig that sub-IDs should
>   be placed within the log record would help avoid the issue of the 8-bit
>   space disappearing too quickly

.... uint16_t?

> - To avoid the problem of RelayFS non-reenterancy I think ltt_log_event() will
>   need a hook at its end so that whatever mechanism was used to avoid the
>   situation can be disabled.

I think this one needs more thinking ... I did think about adding such a
hook, but I didn't like the idea of it, it just seems unclean. After all
the problem is limited to a very small subset of events, namely NMIs and
page fault traps. One thing I was thinking about is that in both these
cases there's always an entry event and an exit event. ltt_mux could then
coordinate using these events. IOW, if it just got an NMI entry, it
doesn't allow any other event to get logged until it sees the NMI exit
go by ... same for page faults. By doing this, we can just keep just one
hook: ltt_mux. Right?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
