Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268718AbUH3Rvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268718AbUH3Rvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUH3Rt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:49:26 -0400
Received: from alpha.Xerox.COM ([13.1.64.93]:46985 "HELO alpha.xerox.com")
	by vger.kernel.org with SMTP id S268681AbUH3RrP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:47:15 -0400
Date: Mon, 30 Aug 2004 10:43:58 PDT
From: Paul Stewart <stewart@parc.com>
Subject: Re: silent semantic changes with reiser4
To: Paul Jackson <pj@sgi.com>
Cc: Hans Reiser <reiser@namesys.com>, riel@redhat.com, ninja@slaphack.com,
       torvalds@osdl.org, diegocg@teleline.es, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
	<412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com>
In-Reply-To: <20040827230857.69340aec.pj@sgi.com> (from pj@sgi.com on Fri,
	Aug 27, 2004 at 23:08:57 -0700)
X-Mailer: Balsa 2.1.2
Message-Id: <1093887838l.11947l.1l@orlando>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.08.27 23:08, Paul Jackson wrote:
> Hans wrote:
> > We create filename/pseudos/backup, and that tells the archiver what  
> > to do.....
> 
> Instead of exposing the old semantics under a new interface, why not
> expose the new semantics under a new interface.

Here's another take on the same theme.  To see attrs on files, one can  
either use a newly developed application which can use special new  
syscalls/flags on syscalls a Paul Jackson recommends.  However from an  
old shell or application one can also open the attribute node on
/home/myself/foo.txt by checking out /attr/home/myself/foo.txt/, which  
points to the "as directory" node on the filesystem that foo.txt points  
to.

The strange part of this idea is that the /attr filesystem wouldn't be  
conventionally browsable.  An opendir() on any path would return the  
attributes, not the subdirectory contents, even if the target was a  
conventional directory.  File based operations (open(), unlink(), etc)  
would operate on the "as directory" node of the dirname() of the file  
argument.  The /attr filesystem would be completely virtual, honoring  
the permissions, crossing filesystems, and inheriting the root  
directory of the calling process.

Just a thought from a Linux fs layman -- certainly one of the Reiser  
unwashed masses.

--
Paul


