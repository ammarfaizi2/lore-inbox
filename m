Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUAEHEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 02:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUAEHEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 02:04:09 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:27868
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265816AbUAEHEB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 02:04:01 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [offtopic] Re: udev and devfs - The final word
Date: Mon, 5 Jan 2004 01:03:12 -0600
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040103040013.A3100@pclin040.win.tue.nl> <200401042148.24742.rob@landley.net> <1073278352.1165.36.camel@nidelv.trondhjem.org>
In-Reply-To: <1073278352.1165.36.camel@nidelv.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401050103.13032.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 January 2004 22:52, Trond Myklebust wrote:
> På su , 04/01/2004 klokka 22:48, skreiv Rob Landley:
> > NFS always struck me as a peverse design.  "The fileserver must be
> > stateless with regard to clients, even though maintainging state is what
> > a filesystem DOES, and the point of the thing is to export a filesystem."
> >  Okay...  (If it was exporting read-only filesystems with no locking of
> > any kind, maybe they'd have a point, but come on guys...)
>
> Sigh... What has that got to do with anything?
>
> Read the RFCs: NFS *was* entirely stateless until v4 was drafted.
> Locking was never part of the NFS protocol, but was an external addition
> that was documented by the Open Group. So, yes, there is a history and a
> reason behind all the talk of statelessness.

I vaguely remember being pretty well up to speed on V2 (circa... 1995?)  The 
last one I even glanced at was V3, but I never had to support it.  I haven't 
even looked at V4.  For exporting /home directories, everybody I deal with 
seems to want samba servers these days instead for some reason.  (Couple of 
net boot systems that care more about permissions than that, but ram's so 
cheap that it's easier to just "ssh user@bootserver -i key "cat root_img.tgz" 
| tar xz" into a ramfs or shmfs or some such.  (Heck, the last system I set 
up like that mounted a zisofs image and ran from that...)

I'm sure it's still useful.  I just haven't wanted to even attempt to secure 
it.  For home directories, samba is doing a simple tcp/ip connection per 
session, reestablishing it automatically if it breaks (same server reboot 
question).  Since _both_ protocols seem to suck pretty badly under the hood, 
it's been a question of choosing the lesser of two evils.  It seems that more 
people actually USE samba, so...

> > So why, exactly, can the NFS server not maintain whatever extra state it
> > needs to remember between reboots in a filesystem?  (Not even necessarily
> > the one it's exporting, just some rc file something under /var.)  The
> > device node it was exporting USED to be in the filesystem, you know, ala
> > mknod.  Now that the kernel's not keeping that stable, have the #*%(&#
> > server generate a number and make a note of it somewhere.  (Is requiring
> > an NFS server to have access to persistent storage too much to ask?)
>
> It could be done (and probably entirely in userspace). I assume you are
> volunteering to do the work?

I don't like nfs, I haven't bothered to actually use it for anything since 
1999, so no.

> > Personally, I could never figure out why Samba servers are in userspace
> > but NFS servers seem to want to live in the kernel.  I can almost secure
> > a samba server for access to the outside world, but a NFS system that
> > isn't behind a firewall automatically says to me "this machine has
> > already been compromised eight ways from sunday within five minutes of
> > being exposed to the internet". Call me paranoid...
>
> Sun was doing Kerberos for NFS years before the Samba project was
> started.
>
> Security has bugger all to do with kernel or userland and everything to
> do with the short-sighted "munitions" policies of certain governments at
> the time around when the Sun RPC protocol was being drafted. The same

I can transparently tunnel any tcp/ip session through ssh with some iptables 
rules and a dozen line python script.  (Great fun for rolling your own vpn.)  
Mixing UDP and encryption is just plain a bad idea: no level at which it 
makes sense to store persistent connection state in a "fire and forget" 
packet protocol...)

I.E. this also works with samba, but didn't with (old) NFS.

> policies were still around to dictate our implementation much later when
> we were doing RPC for Linux. Now the laws have changed, and so we've
> finally been able to add strong authentication in 2.6.x.

Can you recommend a good link to the history of NFS?  Computer history's a 
hobby of mine.  (I've got snippets on this topic, but not any kind of unified 
story of NFS...)

http://www.landley.net/history/mirror/index.html
http://www.landley.net/history/scans/index.html

> Cheers,
>   Trond

Rob

