Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287044AbRL2Aup>; Fri, 28 Dec 2001 19:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287043AbRL2Aug>; Fri, 28 Dec 2001 19:50:36 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:22031 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287044AbRL2AuP>;
	Fri, 28 Dec 2001 19:50:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 12:01:04 -0800."
             <20011228120104.B4077@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Dec 2001 11:50:02 +1100
Message-ID: <7390.1009587002@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc: list trimmed.

On Fri, 28 Dec 2001 12:01:04 -0800, 
Larry McVoy <lm@bitmover.com> wrote:
>On Fri, Dec 28, 2001 at 08:42:44PM +1100, Keith Owens wrote:
>> "All" I need to do is have one server process that reads the big list
>> once and the other client processes talk to the server.  Much less data
>> involved means faster conversion from absolute to standardized names.
>
>Actually, if you use the mdbm code, you can have a server process which
>reads the data, stashes it in the db, touchs ./i_am_done, and exits.
>"client" processes do a 
>
>	while (!exists("i_am_done")) usleep(100000);
>	m = mdbm_open("db", O_RDONLY, 0, 0);
>	val = mdbm_fetch_str(m, "key");
>	etc.
>
>No sockets, no back and forth, runs at mmap speed.
>
>If you tell me what the data looks like that needs to be in the DB, i.e.,
>how to get it, I'll code you up the "server" side.

I also want updates from the dependency back end code, to remove the
phase 5 processing.  The "extract dependency" code runs after each
compile step so there can be multiple updates running in parallel.  My
gut feeling is that it will be faster to have one database server and
all the back ends talk to that server.  Otherwise each compile will
have overhead for lock, open, mmap, update, close, write back, unlock.
A single threading server removes the need for lock/unlock and can sync
the data to disk after n compiles instead of being forced to do it
after every compile.

If your experience says that doing updates from each compile step
without a server process would not be too slow, let me know.

