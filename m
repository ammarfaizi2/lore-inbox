Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTCCPZ2>; Mon, 3 Mar 2003 10:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbTCCPZ2>; Mon, 3 Mar 2003 10:25:28 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:7818 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S265675AbTCCPZ1>;
	Mon, 3 Mar 2003 10:25:27 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15971.30297.165727.589583@laputa.namesys.com>
Date: Mon, 3 Mar 2003 18:35:53 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oleg Drokin <green@namesys.com>, Andrew Morton <akpm@digeo.com>,
       mason@suse.com, trond.myklebust@fys.uio.no, jaharkes@cs.cmu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 iget5_locked port attempt to 2.4
In-Reply-To: <1046708741.6509.5.camel@irongate.swansea.linux.org.uk>
References: <20030220175309.A23616@namesys.com>
	<20030220154924.7171cbd7.akpm@digeo.com>
	<20030221220341.A9325@namesys.com>
	<20030221200440.GA23699@delft.aura.cs.cmu.edu>
	<20030303170924.B3371@namesys.com>
	<1046708741.6509.5.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under 21.5  (beta9) "brussels sprouts" XEmacs Lucid
X-Uboat-Death-Message: BOMBED BY ENORMOUS GNATS. WEB PAGES. SINKING. U-859.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Mon, 2003-03-03 at 14:09, Oleg Drokin wrote:
 > > Hello!
 > > 
 > >    It's me again, I basically got no reply for this iget5_locked patch
 > >    I have now. Would there be any objections if I try push it to Marcelo
 > >    tomorrow? ;)
 > 
 > I just binned it. Certainly its not the kind of stuff I want to test in -ac, 
 > too many VFS changes outside reiserfs

In 2.4 there is a race when find_actor is used in conjunction with
->read_inode2, because inode_lock is released before calling
->read_inode2 and hence, find_actor cannot safely rely on
initialisations of inode's private part done in ->read_inode2. This is
why in 2.5 iget5_locked takes special "set" callback that is called from
under inode_lock. It so happened that reiserfs is the only (is it?) file
system that used both find_actor and ->read_inode2, but whole API is
just broken and should be fixed.

 > 

Nikita.
