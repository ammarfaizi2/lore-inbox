Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVCYWsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVCYWsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVCYWsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:48:32 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:44161 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261872AbVCYWpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:45:23 -0500
Date: Fri, 25 Mar 2005 14:45:19 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Subject: Re: [patch 1/2] fork_connector: add a fork connector
In-Reply-To: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
Message-ID: <Pine.LNX.4.62.0503251440260.1481@twinlark.arctic.org>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005, Guillaume Thouvenin wrote:

...
>   The lmbench shows that the overhead (the construction and the sending
> of the message) in the fork() routine is around 7%.
...
> +		/* 
> +		 * size of data is the number of characters 
> +		 * printed plus one for the trailing '\0'
> +		 */
> +		memset(msg->data, '\0', CN_FORK_INFO_SIZE);
> +		msg->len = scnprintf(msg->data, CN_FORK_INFO_SIZE-1, 
> +				    "%i %i %i", 
> +				    smp_processor_id(), parent, child) + 1;

i'm certain that if you used a struct {} and filled in 3 fields rather 
than zeroing 64 bytes of memory, and doing 3 conversions to decimal ascii 
then you'd see a marked decrease in the overhead of this.  it's not clear 
to me why you need ascii here -- the rest of the existing bsd accounting 
code is not ascii (i'm assuming the purpose of the fork connector is for 
accounting).

-dean
