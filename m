Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTHWG55 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 02:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbTHWG55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 02:57:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:18345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261362AbTHWG5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 02:57:55 -0400
Date: Sat, 23 Aug 2003 00:00:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH 2.6] 2/3 Serio: possible race in handle_events
Message-Id: <20030823000008.07050a75.akpm@osdl.org>
In-Reply-To: <200308230131.45474.dtor_core@ameritech.net>
References: <200308230131.45474.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> +static int is_known_serio(struct serio *serio)
>  +{
>  +	struct serio *s;
>  +	
>  +	list_for_each_entry(s, &serio_list, node)
>  +		if (s == serio)
>  +			return 1;
>  +	return 0;
>  +}

Could this just be

	return !list_empty(&serio->node);

?
