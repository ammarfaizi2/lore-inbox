Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbSKQE3E>; Sat, 16 Nov 2002 23:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267456AbSKQE3E>; Sat, 16 Nov 2002 23:29:04 -0500
Received: from packet.digeo.com ([12.110.80.53]:9637 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266161AbSKQE3D>;
	Sat, 16 Nov 2002 23:29:03 -0500
Message-ID: <3DD71CAA.E2FE9D9@digeo.com>
Date: Sat, 16 Nov 2002 20:35:54 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Justin A <ja6447@albany.edu>, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pnpbios oops on boot w/ 2.5.47
References: <200211161700.29653.ja6447@albany.edu> <3DD6C1DC.44966373@digeo.com> <3DD6F655.4214A594@digeo.com> <20021116232528.GA1273@neo.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Nov 2002 04:35:55.0339 (UTC) FILETIME=[D154C1B0:01C28DF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:
> 
> The typo appears to be in pnpbios_set_resources.  Andrew: Is this where you
> found it?

Well no.

> --- a/drivers/pnp/pnpbios/core.c        Wed Nov  6 17:51:53 2002
> +++ b/drivers/pnp/pnpbios/core.c        Sat Nov 16 23:03:00 2002
> @@ -1285,9 +1285,9 @@
>                 return -EBUSY;
>         if (flags == PNP_DYNAMIC && !pnp_is_dynamic(dev))
>                 return -EPERM;
> -       node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
>         if (pnp_bios_dev_node_info(&node_info) != 0)
>                 return -ENODEV;
> +       node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);

As far as I can see, max_node_size is never initialised anywhere.

mnm:/usr/src/25> grep -rI max_node_size .
./drivers/pnp/pnpbios/core.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
./drivers/pnp/pnpbios/core.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
./drivers/pnp/pnpbios/core.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
./drivers/pnp/pnpbios/core.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
./drivers/pnp/pnpbios/proc.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
./drivers/pnp/pnpbios/proc.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
./drivers/pnp/pnpbios/proc.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
./drivers/pnp/pnpbios/proc.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
./fs/reiserfs/fix_node.c:    int total_node_size, max_node_size, current_item_size;
./fs/reiserfs/fix_node.c:    max_node_size = MAX_CHILD_SIZE (PATH_H_PBUFFER (tb->tb_path, h));
./fs/reiserfs/fix_node.c:       if (i == max_node_size)
./fs/reiserfs/fix_node.c:       return (i / max_node_size + 1);
./fs/reiserfs/fix_node.c:    cur_free = max_node_size;
./fs/reiserfs/fix_node.c:       if (total_node_size + current_item_size <= max_node_size) {
./fs/reiserfs/fix_node.c:       if (current_item_size > max_node_size) {
./fs/reiserfs/fix_node.c:                   current_item_size, max_node_size);
./fs/reiserfs/fix_node.c:           free_space = max_node_size - total_node_size - IH_SIZE;
./include/linux/pnpbios.h:      __u16   max_node_size;
