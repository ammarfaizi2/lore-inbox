Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSHMHtH>; Tue, 13 Aug 2002 03:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318964AbSHMHtH>; Tue, 13 Aug 2002 03:49:07 -0400
Received: from codepoet.org ([166.70.99.138]:25506 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S316182AbSHMHtG>;
	Tue, 13 Aug 2002 03:49:06 -0400
Date: Tue, 13 Aug 2002 01:52:56 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: klibc and logging
Message-ID: <20020813075256.GA26384@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	viro@math.psu.edu
References: <3D58B14A.5080500@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D58B14A.5080500@zytor.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 13, 2002 at 12:12:10AM -0700, H. Peter Anvin wrote:
> Okay... I think klibc is starting to get pretty much to the point where 
> it will need to be, although I'm sure there will be plenty of bugs once 
> we start using it heavily -- and it still needs RPC support code for 
> mounting NFS :(

May I suggest that the poor souls that wish to use NFS mounts
should be statically linking their NFS mount app vs glibc, uClibc
or whatever.  I see little need for you to recreate that whole
evil pile of mush...  What happens next week when someone wants
to get their NFS mount password from LDAP or NIS?  Will you add
klibc nss support?  Or when someone just needs to have wordexp()
and regcomp() and....  I think you are on a very slippery slope.
Keep it simple.  If people want to do stuff that is complex, they
can pay the price for the added baggage.  Even if people need to
statically link one app vs uClibc or dietlibc, they are still
going to get a very small binary.  And they can still include all
their nasty closed source binary only playtoys in the initrootfs
linked vs klibc.

> However, I'm wondering what to do about logging.  Kernel log messages 
> get stored away until klogd gets started, but early userspace may need 
> some way to log messages -- and syslog is obviously not running.  The 

Umm.  Why not just write to /dev/console.  If someone is unable
to read from that (VGA, serial, network console, whatever) while 
trying to set up an NFS-root, they get to keep both pieces.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
