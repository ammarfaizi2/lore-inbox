Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbRETPaM>; Sun, 20 May 2001 11:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbRETPaC>; Sun, 20 May 2001 11:30:02 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:14602 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262036AbRETP3s>; Sun, 20 May 2001 11:29:48 -0400
Date: Sun, 20 May 2001 17:29:48 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: question: permission checking for network filesystem
Message-ID: <20010520172948.A27935@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to impelemnt a lightweight network filesystem and ran into
trouble implementing lookup, permissions and open.

The protocol requires me to specify open mode in it's open command. The
open mode has 4 bits: read, write, append and execute. But I can't tell
execution from read in file_operations->open. I could send the open command
from the inode_operations->permission, but this does not solve the problem,
as I can't find weather to count the new file descriptor as reader or
executer (I have to know that when closing the file).

The server always checks permission on the actual request, so I can't open
the file for reading, when it should be open for execution.

Could anyone see a solution other than adding a flags to open mode (say
O_EXEC and O_EXEC_LIB), that would be added to the dentry_open in open_exec
and sys_uselib? I don't like the idea of pathing vfs for this.

If it has to be patched, what kind of patch has a chance to get into 2.4
series kernel?

There is another thing with lookup. The protocol allows looking up and
opening a file in one command. Unfortunately there are some file-type
checks between i_ops->lookup and f_ops->open that force me to wait on the
lookup to finish before I can open. I think these checks could be done by
simply having the f_ops->open set correctly (thinks like not opening
directory for write). But I do not expect these to change before 2.5,
right?

Thanks in advance.

Bulb

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
