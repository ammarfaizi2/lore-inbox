Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270638AbRHJAlo>; Thu, 9 Aug 2001 20:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270639AbRHJAle>; Thu, 9 Aug 2001 20:41:34 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:58330 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S270638AbRHJAlW>; Thu, 9 Aug 2001 20:41:22 -0400
Message-ID: <3B732DAE.CD117CBA@sympatico.ca>
Date: Thu, 09 Aug 2001 20:41:18 -0400
From: Chris Friesen <chris_friesen@sympatico.ca>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nitpicky questions regarding mmap() and msync()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple questions about mmap()'d files.

1) If I have an mmap()'d file and I write to it and then I am hit with a SIGKILL
before I have a chance to msync(), am I guaranteed that changes I've made to the
information in the file will be available if I restart and try to mmap() the
same file?  The man page says only that there is no guarantee that changes are
written back to disk if msync() is not called, but some informal testing seems
to indicate that changes are in fact written out.  Is this a timing issue or
does the system guarantee this?

2) If I make changes to the contents of an mmap()'d file, am I guaranteed that
the order I make the changes is the same order that they will be available to
another process that has mmap()'d the same file?  (Or can I be bit by
optimization reordering?  If this is the case, can I get around this by reading
it as volatile and using the barrier() macro?)

The basic idea is that I have a state file stored in ramdisk in which I keep
track of some system state variables.   This gets mmap()'d into memory.  If my
process gets killed for whatever reason it can restart and read this file to
check the state.  One of the variables in this file is a flag that says whether
or not its a valid file.  If the file is invalid then more drastic recovery
measures must be taken. I want to be sure that if I clear the flag before doing
any multi-stage operations and then set it after I'm done, I can always
guarantee that if that variable is set then the contents are valid.  I would
also like to avoid calling msync() after every change if I can avoid it.

Anyone know the definitive answers to these questions?  I don't need posix
standard behaviour, just what linux currently does (and is likely to do in the
future, if it is different).

Thanks,

Chris
