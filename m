Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbTHWHc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 03:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbTHWHc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 03:32:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:14780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261629AbTHWHc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 03:32:27 -0400
Date: Sat, 23 Aug 2003 00:34:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH 2.6] 2/3 Serio: possible race in handle_events
Message-Id: <20030823003447.24aa1efc.akpm@osdl.org>
In-Reply-To: <200308230225.10308.dtor_core@ameritech.net>
References: <200308230131.45474.dtor_core@ameritech.net>
	<200308230206.25142.dtor_core@ameritech.net>
	<20030823001922.487f83f5.akpm@osdl.org>
	<200308230225.10308.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> Do you think we should introduce allocate_serio/free_serio pair for dynamically 
>  allocated serios; free_serio would scan event_list and invalidate events that 
>  refer to freed serio?

I don't understand the subsystem well enough to say.  But if we are
receiving events which refer to an already-freed serio then something is
very broken.  We should be draining all those events before allowing the
original object to be freed up.

Let's wait for Vojtech's comments.


