Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWH3TGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWH3TGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWH3TGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:06:17 -0400
Received: from ns1.suse.de ([195.135.220.2]:59548 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751327AbWH3TGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:06:16 -0400
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
Date: Wed, 30 Aug 2006 21:06:18 +0200
User-Agent: KMail/1.9.3
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
References: <44F1F356.5030105@zytor.com> <20060830205136.4f9bfd33@localhost> <44F5E01C.3010807@zytor.com>
In-Reply-To: <44F5E01C.3010807@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608302106.18080.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 20:59, H. Peter Anvin wrote:
> Alon Bar-Lev wrote:
> > 
> > This is not entirely true...
> > All architectures sets saved_command_line variable...
> > So I can add __init to the saved_command_line and
> > copy its contents into kmalloced persistence_command_line at
> > main.c.
> > 
> 
> My opinion is that you should change saved_command_line (which already 
> implies a copy) to be the kmalloc'd version and call the fixed-sized 
> buffer something else.

It might be safer to rename everything. Then all users could be caught
and audited. This would ensure saved_command_line is not accessed
before the kmalloc'ed copy exists.

Disadvantage: more architectures to change.

-Andi

