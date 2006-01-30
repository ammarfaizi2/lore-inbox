Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWA3PZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWA3PZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWA3PZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:25:17 -0500
Received: from ns.suse.de ([195.135.220.2]:38605 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932318AbWA3PZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:25:15 -0500
Date: Mon, 30 Jan 2006 16:25:15 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Balbir Singh <balbir@in.ibm.com>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       olh@suse.de
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
Message-ID: <20060130152515.GH9181@hasse.suse.de>
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060130120318.GB9181@hasse.suse.de> <20060130143814.GA25817@in.ibm.com> <20060130145418.GF9181@hasse.suse.de> <43DE2A71.80906@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DE2A71.80906@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, Kirill Korotaev wrote:

> >>We can think about optimizing this to
> >>  if (!sb->sprunes)
> >>	wake_up(&sb->s_wait_prunes);
> >>
> >
> >
> >Hardly. This is only the case when two or more shrinkers are active in
> >parallel. If that was the case often, we would have seen this much more
> >frequent IMHO.
> But this avoids taking 2nd lock on fast path.
> 

No, the fast path (more frequent) is s_prunes == 0.

sb->s_prunes--;
if (likely(!sb->s_prunes))
   wake_up(&sb->s_wait_prunes);

This is only optimizing a rare case ... and unmounting isn't very time
critical.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
