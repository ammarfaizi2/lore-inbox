Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965920AbWKTPfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965920AbWKTPfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965921AbWKTPfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:35:18 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:48288 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S965920AbWKTPfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:35:16 -0500
Message-ID: <4561CB33.2060502@s5r6.in-berlin.de>
Date: Mon, 20 Nov 2006 16:35:15 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] WorkStruct: Separate delayable and non-delayable
 events.
References: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com> <20061120142716.12685.47219.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061120142716.12685.47219.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Separate delayable work items from non-delayable work items be splitting them
> into a separate structure (dwork_struct), which incorporates a work_struct and
> the timer_list removed from work_struct.
...
>  	if (!delay)
> -		rc = queue_work(ata_wq, &ap->port_task);
> +		rc = queue_dwork(ata_wq, &ap->port_task);
>  	else
>  		rc = queue_delayed_work(ata_wq, &ap->port_task, delay);
...

A consequent (if somewhat silly) name for queue_delayed_work would be
queue_delayed_dwork, since it requires a struct dwork_struct.

Are there many or frequent usages of "undelayed delayable work" like
above, where runtime decides if a delay is necessary? If not,
queue_dwork could be removed from the API and queue_(delayed_|d)work be
called with delay=0.
-- 
Stefan Richter
-=====-=-==- =-== =-=--
http://arcgraph.de/sr/
