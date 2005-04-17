Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVDQRrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVDQRrb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 13:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVDQRra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 13:47:30 -0400
Received: from [62.206.217.67] ([62.206.217.67]:53399 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261375AbVDQRrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 13:47:18 -0400
Message-ID: <4262A0E8.9020905@trash.net>
Date: Sun, 17 Apr 2005 19:46:16 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Thomas Graf <tgraf@suug.ch>, Steven Rostedt <rostedt@goodmis.org>,
       hadi@cyberus.ca, netdev <netdev@oss.sgi.com>,
       Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>, kuznet@ms2.inr.ac.ru,
       devik@cdi.cz, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: ACPI/HT or Packet Scheduler BUG?
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro> <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro> <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro> <1113601029.4294.80.camel@localhost.localdomain> <1113601446.17859.36.camel@localhost.localdomain> <1113602052.4294.89.camel@localhost.localdomain> <20050415225422.GF4114@postel.suug.ch> <20050416014906.GA3291@gondor.apana.org.au> <20050416110639.GI4114@postel.suug.ch> <20050416111236.GA31550@gondor.apana.org.au>
In-Reply-To: <20050416111236.GA31550@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Sat, Apr 16, 2005 at 01:06:39PM +0200, Thomas Graf wrote:
> 
>>qdisc_destroy can still be invoked without qdisc_tree_lock via the
>>deletion of a class when it calls qdisc_destroy to destroy its
>>leaf qdisc.
>
> Indeed.  Fortuantely HTB seems to be safe as it calls sch_tree_lock
> which is another name for qdisc_tree_lock.  CBQ on the other hand
> needs to have a little tweak.

HTB also needs to be fixed. Destruction is usually defered by the
refcnt until ->put(), htb_put() doesn't lock the tree. Same for
HFSC and CBQ.

Regards
Patrick
