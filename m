Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281288AbRKTVv0>; Tue, 20 Nov 2001 16:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281393AbRKTVvS>; Tue, 20 Nov 2001 16:51:18 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42742
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281288AbRKTVvI>; Tue, 20 Nov 2001 16:51:08 -0500
Date: Tue, 20 Nov 2001 13:50:59 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Steffen Persvold <sp@scali.no>,
        Christopher Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: NFS, Paging & Installing [was: Re: Swap]
Message-ID: <20011120135059.D4210@mikef-linux.matchmail.com>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Steffen Persvold <sp@scali.no>,
	Christopher Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011120131839.B4210@mikef-linux.matchmail.com> <Pine.LNX.3.95.1011120163024.14793A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1011120163024.14793A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 04:43:01PM -0500, Richard B. Johnson wrote:
> On Tue, 20 Nov 2001, Mike Fedyk wrote:
> > IIRC (if wrong flame...)
> > 
> > When you delete an open file, the entry is removed from the directory, but
> > not unlinked until the file is closed.  This is a standard UNIX semantic.
> > 
> > Now, if you have a set of processes with shared memory, and one closes, and
> > another is created to replace, the new process will get the new libraries,
> > or even new version of the process.  This could/will bring down the entire
> > set of processes.
> > 
> > Apps like samba come to mind...
> > 
> > Mike
> 
> If the file is local, everything is fine. A file won't actually
> be deleted until the last access is closed. However, the long-standing
> problem with NFS is that it's `phony`. Basically, we send a message
> to a server that says "Give me a directory listing...". The server
> does the `opendir()` etc., and returns the results. If I want to
> open a file on the server, the server has no knowledge of the `open`.
> The client's software just emulated a file-system open(). When the
> client wants to read data from a server's file, it sends a message;
> "Gimmie data from file xxx, offset x, length y.". The server responds
> with that data. To get that data, the server did an open/lseek/read/close.
> 
> So, as far as the server is concerned, that file is closed. Somebody
> else (with privilege) can delete the file and replace it. The client,
> the one that got the data for an executable, doesn't even know it.
> 
> This is 'nice' for the server, it doesn't have the overhead of maintaining
> a file-system state. That's why servers are supposed to be read-only.
> However, somebody has got to write the stuff to the file-system that's
> going to (eventually) be read-only. Beware when such access occurs.
> 

Do any newer versions of NFS fix the stateless server problem?

If not, are there any drop in (at least for linux) replacements that do keep
state on the server?

SMB is out because it doesn't propagate the unix uid/gid

Striped down (auth wise) AFS?

Intermezzo?

