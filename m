Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTK2Joi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 04:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTK2Joi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 04:44:38 -0500
Received: from holomorphy.com ([199.26.172.102]:7109 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263734AbTK2Joh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 04:44:37 -0500
Date: Sat, 29 Nov 2003 01:44:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: John Zielinski <grim@undead.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rootfs mounted from user space - problem with umount
Message-ID: <20031129094435.GS14258@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Zielinski <grim@undead.cc>, linux-kernel@vger.kernel.org
References: <3FC82D8F.9030100@undead.cc> <20031129053128.GF8039@holomorphy.com> <3FC8394A.7010702@undead.cc> <20031129062136.GH8039@holomorphy.com> <3FC869A3.8070809@undead.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC869A3.8070809@undead.cc>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Looks like either namespace->sem or sb->s_umount; you should be able
>> to put some instrumentation code in down_write() and/or down_read() to
>> see who acquired it first by checking to see if the sem acquired belongs
>> to rootfs' sb or some namespace (doubtful you'll create many of them).

On Sat, Nov 29, 2003 at 04:40:51AM -0500, John Zielinski wrote:
> Found it.  It was a stupid mistake.  I made the get_sb function return 
> the same superblock when it was still get_sb_nodev.  When I switched it 
> to the proper get_sb_single I forgot to remove the code that returned 
> the old sb so it wasn't calling get_sb_single to increase the sb's usage 
> count.  Doh!

Cool! So when do we get a swappable initrd's/initramfs's?


-- wli
