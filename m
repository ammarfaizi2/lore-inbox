Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282905AbRK0K2r>; Tue, 27 Nov 2001 05:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282899AbRK0K2a>; Tue, 27 Nov 2001 05:28:30 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:18948 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S282901AbRK0K2S>; Tue, 27 Nov 2001 05:28:18 -0500
Message-ID: <3C036A83.F23E6EBE@idb.hist.no>
Date: Tue, 27 Nov 2001 11:27:15 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Mark Richards <richard@ecf.utoronto.ca>, linux-kernel@vger.kernel.org
Subject: Re: Multiplexing filesystem
In-Reply-To: <3C030FB4.C3303BE4@ecf.utoronto.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Richards wrote:
> 
> Quick question, which I suspect has a long answer.
> 
> I would like to write a multiplexing filesystem.  The idea is as follows:
> 
> The filesystem would ideally wrap another filesystem, such as nfs or smbfs or
> ext2.  Most operations would just be passed to the native fs call.  However, for
> some files, selectable at run time by some control singal, would actually reside
> on another file system.  The other filesystem would have to be mounted.
> 
> The idea is for a version controlling filesystem.  The server would be a network
> server (hence the desire to wrap nfs) which presents a 'view' of the source
> code.  When the user reserves a file for editing, the file is copied to the
> local disk.  From that point on, the local file is referred to until the user
> commits the change or unreserves the file.  Ideally, the local copy of the file
> could be on any file system, not one that is necessarily local.  And this has to
> be totally transparent to the user, except for the step where the user
> 'reserves' the file.

Coda already do what you want:
Files are kept on a server, and copied to your local disk when
you use it.  You may even disconnect when working on the local
copy - your changes will be propagated back to the server
whenever you reconnect to the network.
The copying is indeed completely transparent.

If you need reservation - use the permission system. 
A suid program simply makes _you_ owner, and only
the owner gets write permission.  This is your check-out
program.  Check-in consists of changing ownership
back to root (or some userid allocated to the versioning system)

Helge Hafting
