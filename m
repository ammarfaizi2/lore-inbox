Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131886AbQKRWxE>; Sat, 18 Nov 2000 17:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131900AbQKRWwx>; Sat, 18 Nov 2000 17:52:53 -0500
Received: from 3dyn88.com21.casema.net ([212.64.94.88]:36368 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S131886AbQKRWwq>;
	Sat, 18 Nov 2000 17:52:46 -0500
Date: Sun, 19 Nov 2000 00:15:58 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4 sendfile() not doing as manpage promises?
Message-ID: <20001119001558.B10579@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I tried to use sendfile() to send data from a tcp/ip socket to a file on
disk. This does not work, giving EINVAL. 

Using the very fine kgdb product (http://kgdb.sourceforge.net) and my laptop
for remote debugging, I was able to trace this to this:

sys/filemap.c::sys_sendfile():

        if (!in_inode->i_mapping->a_ops->readpage)
                goto fput_in;

After some exploring with 'ddd' (a very nice graphical frontend for gdb,
which includes tools to display and traverse structs), I found that this
probably means that sendfile() can only be used to send files from
blockdevices which support mmap()-like functionality.

Is this correct? In that case, the wording of the manpage needs to be
changed, as it implies that 'either or both' of the filedescriptors can be
sockets.

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
