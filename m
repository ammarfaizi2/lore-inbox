Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVARBO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVARBO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVARBOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:14:43 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:13780 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262773AbVARBNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:13:20 -0500
Date: Tue, 18 Jan 2005 02:13:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41EC2DCA.50904@opersys.com>
Message-ID: <Pine.LNX.4.61.0501180152410.30794@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
 <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home>
 <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home>
 <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home>
 <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home>
 <41EADA11.70403@opersys.com> <Pine.LNX.4.61.0501171403490.30794@scrub.home>
 <41EC2DCA.50904@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Jan 2005, Karim Yaghmour wrote:

> a) create indexes, b) reorder events, and likely c) have to rewrite

An additional comment about the order of events. What you're doing in 
lockless_reserve is bogus anyway. There is no single correct time to 
write into the event. By artificially synchronizing event order and event 
time you only cheat yourself. You either take it into account during 
postprocessing that events can be interrupted or the time stamp doesn't 
seem to be that important, but there is nothing you can do during the 
recording of the event except of completely disabling interrupts.

bye, Roman
