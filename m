Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTK2Jk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 04:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbTK2Jk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 04:40:58 -0500
Received: from gw-undead3.tht.net ([216.126.84.18]:46208 "HELO mail.undead.cc")
	by vger.kernel.org with SMTP id S263732AbTK2Jk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 04:40:57 -0500
Message-ID: <3FC869A3.8070809@undead.cc>
Date: Sat, 29 Nov 2003 04:40:51 -0500
From: John Zielinski <grim@undead.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Rootfs mounted from user space - problem with umount
References: <3FC82D8F.9030100@undead.cc> <20031129053128.GF8039@holomorphy.com> <3FC8394A.7010702@undead.cc> <20031129062136.GH8039@holomorphy.com>
In-Reply-To: <20031129062136.GH8039@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>Looks like either namespace->sem or sb->s_umount; you should be able
>to put some instrumentation code in down_write() and/or down_read() to
>see who acquired it first by checking to see if the sem acquired belongs
>to rootfs' sb or some namespace (doubtful you'll create many of them).
>
>
>  
>

Found it.  It was a stupid mistake.  I made the get_sb function return 
the same superblock when it was still get_sb_nodev.  When I switched it 
to the proper get_sb_single I forgot to remove the code that returned 
the old sb so it wasn't calling get_sb_single to increase the sb's usage 
count.  Doh!

John




