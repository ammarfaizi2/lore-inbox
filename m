Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVD0Noq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVD0Noq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVD0No3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:44:29 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:56229 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S261597AbVD0Nnn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:43:43 -0400
Date: Wed, 27 Apr 2005 16:43:31 +0300
From: Ville Herva <vherva@vianova.fi>
To: Jan Hudec <bulb@ucw.cz>
Cc: Jamie Lokier <jamie@shareable.org>, John Stoffel <john@stoffel.org>,
       "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050427134331.GT5470@viasys.com>
Reply-To: vherva@vianova.fi
References: <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <17006.22498.394169.98413@smtp.charter.net> <20050426152434.GB14297@mail.shareable.org> <20050427093412.GB1904@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427093412.GB1904@vagabond>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.vianova.fi 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 11:34:12AM +0200, you [Jan Hudec] wrote:
> On Tue, Apr 26, 2005 at 16:24:34 +0100, Jamie Lokier wrote:
> > John Stoffel wrote:
> > > >>>>> "Jamie" == Jamie Lokier <jamie@shareable.org> writes:
> > > 
> > > Jamie> No.  A transaction means that _all_ processes will see the
> > > Jamie> whole transaction or not.
> > > 
> > > This is really hard.  How do you handle the case where process X
> > > starts a transaction modifies files a, b & c, but process Y has file b
> > > open for writing, and never lets it go?  Or the file gets unlinked?  
> > 
> > Then it starts to depend on what kind of transactions you want to
> > implement.
> > 
> > You can say that a transaction isn't allowed when a process has one of
> > the files opened for writing.  Or you can say a transaction is
> > equivalent to calling all of the I/O system calls at once.  You can
> > also decide if you want the reads and directory lookups performed in
> > the transactions to become prerequisites for the transaction
> > completing (so it's aborted if another process writes to those file
> > regions or changes the directory structure in a way which breaks a
> > prerequisite), or if you want those to lock the things which are read
> > for the duration of the transaction, or even just ignore reads for
> > transaction purposes.  Or, you can say that transactions are limited
> > to just directory structure, and not file contents (that's good enough
> > for package management), or you can say they're limited to just file
> > contents (that's good enough for databases and text file edits).
> > 
> > Etc, etc, quite a lot of semantic choices.
> 
> How do we specify which calls belong to a transaction? By some kind of
> extra file handle?
> 
> I'd think having global per-process transaction is not the best way.
> So I think we should have some kind of transaction handle (probably in
> the file handle space) and a way to say that a syscall is done within
> a transaction. To avoid duplicating all syscalls, we could have
> set_active_transaction() operation.

That's more or less what NTFS does. See the example at
http://blogs.msdn.com/because_we_can/
 


-- v -- 

v@iki.fi

