Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbVJUPrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVJUPrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVJUPrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:47:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39373 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964997AbVJUPrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:47:52 -0400
Date: Fri, 21 Oct 2005 08:47:42 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Simon.Derr@bull.net,
       akpm@osdl.org, kravetz@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, magnus.damm@gmail.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
In-Reply-To: <20051021081553.50716b97.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0510210845140.23212@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
 <20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
 <4358588D.1080307@jp.fujitsu.com> <Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
 <435896CA.1000101@jp.fujitsu.com> <20051021081553.50716b97.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2005, Paul Jackson wrote:

>  * Christoph - what is the permissions check on sys_migrate_pages()?
>    It would seem inappropriate for 'guest' to be able to move the
>    memory of 'root'.

The check is missing. 

Maybe we could add:

 if (!capable(CAP_SYS_RESOURCE))
                return -EPERM;

Then we may also decide that root can move any process anywhere and drop 
the retrieval of the mems_allowed from the other task.

