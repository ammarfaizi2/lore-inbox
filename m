Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTJHJAp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 05:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbTJHJAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 05:00:45 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:37000 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP id S261162AbTJHJAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 05:00:44 -0400
Date: Wed, 8 Oct 2003 09:59:05 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein31.homenet
To: Dave Jones <davej@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: changes to microcode update driver.
In-Reply-To: <20031007135417.GC11840@redhat.com>
Message-ID: <Pine.LNX.4.44.0310080953550.1126-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Dave Jones wrote:
> Assuming that it can be done without the old tools breaking, sounds good
> to me.  How will microcode_ctl -i react if you remove the ioctl ?
> Folks _will_ upgrade kernels without updating userspace.

It will fail and Red Hat's startup scripts will show the red [FAILED]
thing which users are always afraid of.

So, I thought initially we should just return 0 in that ioctl (with the 
comment that it's going away) and then remove it completely, after 
microcode_ctl has been updated.

The patch was almost ready (together with Intel's changes) but I 
discovered that microcode module (or in fact ANY module that is loaded 
first on my system, 2.6.0-test6) is not unloadable, i.e. usage count stays 
at 1 even though nothing is using it. I am not aware of this general 
problem being discussed on linux-kernel list, so I thought I should debug 
it first (after all, it may be something I am doing that causes it). And 
yes my kernel is configured to allow unloading, even forced unloading.

(still feeling ashamed after yesterday's thing with me forgetting to 
configure siimage driver and complaining that generic ATA is too slow :)

Kind regards
Tigran

