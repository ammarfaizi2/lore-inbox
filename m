Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281311AbRKPLqT>; Fri, 16 Nov 2001 06:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281313AbRKPLp7>; Fri, 16 Nov 2001 06:45:59 -0500
Received: from pat.uio.no ([129.240.130.16]:37099 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S281311AbRKPLpw>;
	Fri, 16 Nov 2001 06:45:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15348.64613.465429.628445@charged.uio.no>
Date: Fri, 16 Nov 2001 12:45:41 +0100
To: Birger Lammering <b.lammering@science-computing.de>
Cc: linux-kernel@vger.kernel.org
Subject: nfs problem: hp|aix-server --- linux 2.4.15pre5 client
In-Reply-To: <15348.63313.961267.735216@stderr.science-computing.de>
In-Reply-To: <20011115222920.A9929@ludwig2.science-computing.de>
	<shssnbf37td.fsf@charged.uio.no>
	<15348.63313.961267.735216@stderr.science-computing.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Birger Lammering <b.lammering@science-computing.de> writes:

     > not reproduce the Ooops with the HP nfs server. But still: The
     > Kernel complains about: "NFS: short packet in readdir reply!" 
     > when I access any directory provided by a HP-UX 10.20
     > nfs-server (using nfs2 | nfs3). I dont' notice any strange
     > behaviour other than that, though.

That's because the HP is returning a READDIR reply that is larger than
the buffer size we specified. When this happens, we truncate the reply
at the last valid record before the buffer overflow, and print out the
above message.

     > But a new problem emerged: Copying from a linux (2.4.13 |
     > 2.4.15pre5) nfs-client onto an AIX nfs-server doesn't
     > work. About 800kb are copied then the cp command just
     > hangs. Syslog says: Nov 16 11:51:12 capc20 kernel: nfs: server
     > caes04 not responding, still trying This problem only occures
     > with nfs3, and not with nfs2.

     > Is there a cure for this, without being too experimental?

No idea. That depends on where the problem lies...
Do you have a tcpdump for me? Preferably one from the client and one
from the server (showing the same period of time).

Cheers,
   Trond
