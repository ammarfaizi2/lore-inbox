Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315148AbSD2Mf0>; Mon, 29 Apr 2002 08:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315149AbSD2MfZ>; Mon, 29 Apr 2002 08:35:25 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:2040 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S315148AbSD2MfX>; Mon, 29 Apr 2002 08:35:23 -0400
Date: Mon, 29 Apr 2002 08:35:14 -0400
From: "V. Guruprasad" <prasad@watson.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: difficulty with symbol export
Message-ID: <20020429083514.A21779@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,


Just playing with the kernel code, I added a silly function

	struct file_operations *get_socket_fileops ()
	{
		return &socket_file_ops;
	}

at the bottom of net/socket.c, and

	EXPORT_SYMBOL(get_socket_fileops);

into net/netsyms.c, expecting to be able to call this function
from a loadable module and to printk the function addresses
from the file_operations struct.

However, on rebooting into this modified kernel, my test module
fails to load, saying

	foo.o: unresolved symbol get_socket_fileops

even though the symbol looks exported in vmlinux (nm) and
in /boot/System.map:

	c020ca90 T get_socket_fileops
	0c2b52bf ? __kstrtab_get_socket_fileops
	0c2ba358 ? __ksymtab_get_socket_fileops

which looks exactly like sock_create, which the module *is*
able to address.

Any pointers?


thanks,
-prasad.

------------------------
V. Guruprasad ('prasad'),
http://www.columbia.edu/~vg96
