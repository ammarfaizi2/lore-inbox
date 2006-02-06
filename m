Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWBFA7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWBFA7I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 19:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWBFA7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 19:59:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:4227 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750729AbWBFA7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 19:59:06 -0500
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kirill Korotaev <dev@openvz.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org
In-Reply-To: <43E38BD1.4070707@openvz.org>
References: <43E38BD1.4070707@openvz.org>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 11:56:31 +1100
Message-Id: <1139187391.5634.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 19:58 +0300, Kirill Korotaev wrote:

> +static inline vps_t get_vps(vps_t vps)
> +{
> +	atomic_inc(&vps->refcnt);
> +	return vps;
> +}
> +
> +static inline void put_vps(vps_t vps)
> +{
> +	atomic_dec(&vps->refcnt);
> +}

I'm not too sure about the refcounting here .. you never destroy the
object ? Also, why introduce your own refcounting mecanism instead of
using existing ones ? You could probably use at least a kref to get a
nice refcount + destructor instead of home made atomics based. Maybe
some higher level structure if you think it makes sense (not too sure
what this virtualization stuff is about so I can't comment on what data
structure is appropriate here).

Cheers,
Ben.


