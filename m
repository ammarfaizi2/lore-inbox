Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131430AbQKNXTZ>; Tue, 14 Nov 2000 18:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131579AbQKNXTP>; Tue, 14 Nov 2000 18:19:15 -0500
Received: from unimur.um.es ([155.54.1.1]:34034 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S131430AbQKNXTF>;
	Tue, 14 Nov 2000 18:19:05 -0500
Message-ID: <3A11C480.A27E406B@ditec.um.es>
Date: Wed, 15 Nov 2000 00:02:24 +0100
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.75 [es] (X11; U; Linux 2.2.18pre17 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Addressing logically the buffer cache
In-Reply-To: <Pine.GSO.4.21.0011141445450.5482-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro escribió:
> 
> On Tue, 14 Nov 2000, Juan wrote:
> 
> > Hi!.
> >
> > Is there any patch or project to address logically the buffer cache?.
> > Now, you use three parameters to find a buffer in cache: device, block
> > number, and block size. But, what about if I want to find a buffer using
> > a super block, an inode number, and a block number within the file
> > specified by the inode number.
> 
> What's wrong with using the pagecache and per-page buffer_heads?

Suppose you are implementing a log-structured file system and a process
adds a new logical block to a file. Besides, suppose that the segment is
512 KBytes in size. Usually, you don't want to write the segment before
it is full. The logical block hasn't got a physical address because you
don't build the segment until it is written to disk. So, what happens if
another process wants to access to the new block?.

You can't assign a physical address to the new block because the address
can change when the buffer is written to disk.

Perhaps, I'm wrong, but I think that the implementation of the BSD-LFS
needs to address logically the buffer cache.

Bye!

P.D.: sorry for my bad English ;-)
-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968364633    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
