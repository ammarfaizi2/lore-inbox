Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263345AbSJTSPK>; Sun, 20 Oct 2002 14:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263403AbSJTSPK>; Sun, 20 Oct 2002 14:15:10 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:7896 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S263345AbSJTSPI>;
	Sun, 20 Oct 2002 14:15:08 -0400
Date: Sun, 20 Oct 2002 20:21:13 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: nfsd/sunrpc boot on reboot in 2.5.44
Message-ID: <20021020182113.GB26384@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
References: <20021020173142.GA26384@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020173142.GA26384@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 07:31:42PM +0200, bert hubert wrote:

> I'm looking if I can reproduce this.

Like clockwork, it happens just after 'Unexporting directories'. If you run
exportfs -au first, nothing happens. the error only happens when the entire
script runs.

  stop)
        printf "Stopping $DESC: mountd"
        start-stop-daemon --stop --oknodo --quiet \
            --name rpc.mountd --user 0
        printf " nfsd"
        start-stop-daemon --stop --oknodo --quiet \
            --name nfsd --user 0 --signal 2
        echo "."

        printf "Unexporting directories for $DESC..."
        $PREFIX/sbin/exportfs -au
        echo "done."
        ;;

This is /etc/exports:
 # /etc/exports: the access control list for filesystems which may be
exported
#		to NFS clients.  See exports(5)
/ 10.0.0.0/255.0.0.0(rw)
/mnt 10.0.0.0/255.0.0.0(rw)

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
