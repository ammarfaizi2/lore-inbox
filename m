Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132120AbQK3KNv>; Thu, 30 Nov 2000 05:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132718AbQK3KNl>; Thu, 30 Nov 2000 05:13:41 -0500
Received: from pusa.informat.uv.es ([147.156.24.61]:60170 "EHLO
        pusa.informat.uv.es") by vger.kernel.org with ESMTP
        id <S132120AbQK3KNb>; Thu, 30 Nov 2000 05:13:31 -0500
Date: Thu, 30 Nov 2000 10:43:01 +0100
To: linux-kernel@vger.kernel.org
Subject: innofensive BUG and fix: area->map's size is not calculated ok
Message-ID: <20001130104301.A22355@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In a 2.4 kernel, mm/page_alloc.c:free_area_init_core(), in the following
assignement...

	bitmap_size = size >> i;

...makes bitmap_size be the double of the needed size, this calculum
assumes that with a 512 byte map size the kernel is mapping 8*512= 4096 chunks 
of memory, that is: one bit of the map is used for each chunk of memory, 
and that's not true. 

Really one bit of area->map is used to map two chunks of memory, so in the 
example above an area->map of just 256 bytes is really needed, the other 256
bytes are _never accessed_.

So the righ thing would be to do is:

	bitmap_size = size >> (i+1);


also I tested it and it works ok, so I believe I'm right...


Please CC: your replies to (I'm not subscribed to this list)

Ulisses Alonso Camaró	<uaca@NOSPAM.alumni.uv.es>	

PD: my nick on #kernelnewbies is despistao

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
