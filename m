Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbUBYBAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbUBYBAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:00:41 -0500
Received: from clix.aarnet.edu.au ([192.94.63.10]:23177 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP id S262543AbUBYBAd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:00:33 -0500
Subject: Re: PATCH: report NGROUPS_MAX via a sysctl (read-only)
From: Glen Turner <glen.turner@aarnet.edu.au>
To: Tim Hockin <thockin@hockin.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040220071028.GA4948@hockin.org>
References: <20040220023927.GN9155@sun.com>
	 <20040219213028.42835364.akpm@osdl.org> <20040220063519.GP9155@sun.com>
	 <20040219224752.44da2712.akpm@osdl.org>  <20040220071028.GA4948@hockin.org>
Content-Type: text/plain
Organization: Australian Academic and Research Network
Message-Id: <1077670767.24730.51.camel@andromache>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 25 Feb 2004 11:29:27 +1030
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -100 USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-20 at 17:40, Tim Hockin wrote:

> Well, really I don't see how apps would want to use it in any way that was
> correct.

The mere existence of the value means it can be used correctly
in application code for sanity checking.

eg:
   assert(list_length(group_list) < ngroups_max());
   list_append(&group_list, group);

An application might also use it to automatically
size data structure details, such as the parameters of
a hash function.

  h = hash_create(ngroups_max());

Returning INT_MAX for NGROUPS_MAX isn't wrong, but you
then can't blame user space for making inefficient choices
if the kernel limit is actually smaller.

Cheers,
Glen


